import datetime
#import time
import os
#from turtle import color
import pandas as pd
import numpy as np
import PySimpleGUI as sg
import database_df as db
import re
#import matplotlib.pyplot as plt
#from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg

### import data from database
Op, Roos, Semiflex, El = db.populate_fields()
currdatetime = datetime.datetime.today().strftime("%d/%m/%Y %H:%M:%S")
kpol, ndw, kelec, ks = db.update_cal(currdatetime,Roos,Semiflex,El)
kq=1.001
rbe=1.1

### Calibration data (kpol, ndw, kelec will update from database when Adate is generated)
selected_ks=None
selected_kpol=None
selected_kelec=None
selected_ndw=None
# dropdown list data
G = ['Gantry 1', 'Gantry 2', 'Gantry 3', 'Gantry 4']
Chtype = ['Roos', 'Semiflex']
V = [-400,-200,0,200,400]
Rng = ['Low','Medium','High']
Ch = Roos
en_layers = ['18', '5','1']
layers = [list(range(240,69,-10)),[240,200,150,100,70],list(range(160,159,-10))]
# Gantry specific reference data from database
ref_data = db.update_ref()

### Helper functions
def calc_metrics(i):
    '''
        Calculate mean dose from readings for energy layer i and update GUI display
        Input:
            i           int index of energy layer in GUI
        Return:
            r_mean      mean reading
            r_range     range betwen reading max-min
            d_mean      mean dose
            d_diff      percentage difference between mean reference dose values
            d           list of calculated dose values
    '''
    r = [float(x) for x in [values['r'+i+'1'],values['r'+i+'2'],values['r'+i+'3'],values['r'+i+'4'],values['r'+i+'5']] if re.fullmatch(r'^(?:[0-9]+(?:\.[0-9]*)?)$', x)]
    r_mean=None
    r_range=None
    d = []
    d_mean=None
    d_diff=None
    diff_color='lightgray'
    if len(r)>0:
        # mean R
        r_mean = np.mean(r)
        window['rm'+i]('%.4f' % r_mean)
        # R range
        eps = np.finfo(float).eps # remove risk of dividing by zero
        r_range = (max(r)-min(r)) / (r_mean+eps) * 100
        window['rang'+i]('%.2f' % r_range)
        if len(window['rr'+i].get())>0:
            energy = int(window['E'+i].get())
            idx = ref_data['Energy'].index(energy)
            dref = ref_data[values['-G-']][idx]
            # Dose measured
            try:
                dose_coeff = tpc*float(selected_ndw)*float(kq)*float(selected_ks)*float(selected_kelec)*float(selected_kpol)*float(rbe)*1e-9
                # calc dose for each reading
                for reading in r:
                    d.append(reading*dose_coeff)
                # mean dose
                d_mean = np.mean(d)
                window['ad'+i]('%.4f' % d_mean)
                # Dose diff
                d_diff = (d_mean - dref)/dref*100
                # Conditional formatting
                if abs(d_diff)>=2.0:
                    diff_color='red'
                elif abs(d_diff)>=0.5:
                    diff_color='orange'
                else:
                    diff_color='green'
                window['diff'+i]('%.3f' % d_diff, background_color=diff_color, text_color='white')
            except:
                window['ad'+i]('')
                window['diff'+i]('', background_color=diff_color, text_color='black')
        
        return r_mean, r_range, d_mean, d_diff, d, r
    else:
        window['rm'+i].Update('')
        window['rang'+i]('')
        window['diff'+i]('',background_color=diff_color, text_color='black')
        window['ad'+i]('')

def pre_analysis_check(values):
    '''
        Check GUI values are valid
        Input:
            values                  GUI values dict

        Returns list of lists check_fail:
            check_fail[n][0]       True if check n failed
            check_fail[n][1]       unique int for check n
    '''
    check_fail = [[False,0]]     
    
    # helper functions
    def _range_check(value, key, minval, maxval):
        if not maxval >= value >= minval:
            sg.popup("Invalid Value", "Enter a valid "+key+" between "+str(minval)+" and "+str(maxval))
            return True
        else:
            return False

    # check ADate
    try:
        adate = datetime.datetime.strptime(values['ADate'],"%d/%m/%Y %H:%M:%S")
    except:
        sg.popup("Invalid Value", "Select a valid Date (dd/mm/yyyy hh:mm:ss)")
        check_fail.append([True,1])
        return check_fail

    # check temperature
    try:
        check_flag = _range_check(float(values['Temp']), 'Temperature', 18., 26.)
        if check_flag:
            check_fail.append([check_flag,2])
            return check_fail
    except:
        sg.popup("Invalid Value","Temperature error, check entered value")
        check_fail.append([True,3])
        return check_fail

    # check pressure
    try:
        check_flag = _range_check(float(values['Press']), 'Pressure', 955, 1055)
        if check_flag:
            check_fail.append([check_flag,4])
            return check_fail
    except:
        sg.popup("Invalid Value","Pressure error, check entered value")
        check_fail.append([True,5])
        return check_fail

    # check gantry angle
    try:
        if not 0 <= int(values['GA']) <= 359:
            sg.popup("Invalid Value","Enter an integer gantry angle between 0 and 359")
            check_fail.append([True,6])
            return check_fail
    except:
        sg.popup("Invalid Value","Gantry angle error, check entered value")
        check_fail.append([True,7])
        return check_fail
    
    # check readings are deimcal or blank
    r = []
    try:
        for n,_ in enumerate(layers[0]):
            i = str(n)
            lst = [values['r'+i+'1'],values['r'+i+'2'],values['r'+i+'3'],values['r'+i+'4'],values['r'+i+'5']]
            r.extend([x for x in lst if not re.fullmatch(r'^(?:[0-9]+(?:\.[0-9]*)?)?$', x)])
        if len(r)!=0:
           sg.popup("Invalid Value","Ensure all readings are positive decimal numbers")
           check_fail.append([True,8])
           return check_fail
    except:
        sg.popup("Invalid Value","R error, check entered values")
        check_fail.append([True,9])
        return check_fail
    
    # check operator
    if values['-Op1-'] == '':
        check_fail.append([True,10])
        sg.popup("Invalid Value", "Select Operator 1 initials")
        return check_fail
    
    # check gantry, chamber, electrometer, voltage
    equipment = {'Gantry':'-G-','Chamber':'-Ch-','Electrometer':'-El-','Voltage':'-V-'}
    for n in equipment:
        if values[equipment[n]] == '':
            check_fail.append([True,11])
            sg.popup("Invalid Value", "Select a value for: "+n)
            return check_fail

    # check Humidity
    try:
        if not 0 <= float(values['H']) <= 100:
            sg.popup("Invalid Value","Enter a percentage humidity between 0 and 100")
            check_fail.append([True,12])
            return check_fail
    except:
        sg.popup("Invalid Value","Humidity error, check entered value")
        check_fail.append([True,13])
        return check_fail
    
    return check_fail
        

### GUI window function
def build_window():
    '''
        Create the GUI layout
        Returns PySimpleGUI window object
    '''
    #theme
    sg.theme('DefaultNoMoreNagging')

    #equipment
    sess0_layout = [
        [sg.T('Date', justification='right', size=(5,1)), sg.Input(key='ADate', enable_events=True, size=(18,1), readonly=True)],
        [sg.T('', size=(5,1)), sg.CalendarButton('dd/mm/yyyy hh:mm:ss', font=('size',9), target='ADate',format='%d/%m/%Y %H:%M:%S', close_when_date_chosen=True, no_titlebar=False, key='-CalB-')],
        [sg.T('Energy Layers', justification='right', size=(12,1)), sg.DD(en_layers, enable_events=True, default_value='18', size=(8,1), key='-Layers-', readonly=True)],
    ]
    sess1_layout = [
        [sg.T('Operator 1', justification='right', size=(13,1)), sg.DD(['']+Op, size=(8,1), key='-Op1-', readonly=True)],
        [sg.T('Operator 2', justification='right', size=(13,1)), sg.DD(['']+Op, size=(8,1), key='-Op2-', readonly=True)],
    ]

    #calibration
    cal0_layout = [
        [sg.T('T (C)', justification='right', size=(8,1)), sg.Input(key='Temp', enable_events=True, size=(6,1))],
        [sg.T('P (hPa)', justification='right', size=(8,1)), sg.Input(key='Press', enable_events=True, size=(6,1))],
        [sg.T('TPC', justification='right', size=(8,1)), sg.T(key='tpc', size=(6,1), background_color='lightgray', text_color='black', justification='right')],
    ]
    cal1_layout = [
        [sg.T('kQ', justification='right', size=(5,1)), sg.T(str(kq), key='kq', size=(5,1), background_color='lightgray', text_color='black', justification='right')],
        [sg.T('ks', justification='right', size=(5,1)), sg.T(key='ks', enable_events=True, size=(5,1), background_color='lightgray', text_color='black', justification='right')],
        [sg.T('kelec', justification='right', size=(5,1)), sg.T(key='kelec', enable_events=True, size=(5,1), background_color='lightgray', text_color='black', justification='right')],
    ]
    cal3_layout = [
        [sg.T('kpol', justification='right', size=(5,1)), sg.T(key='kpol', enable_events=True, size=(5,1), background_color='lightgray', text_color='black', justification='right')],
        [sg.T('RBE', justification='right', size=(5,1)), sg.T(str(rbe), key='rbe', enable_events=True, size=(5,1), background_color='lightgray', text_color='black', justification='right')],
        [sg.T('Ndw', justification='right', size=(5,1)), sg.T(key='ndw', enable_events=True, size=(8,1), background_color='lightgray', text_color='black', justification='right')],
    ]
    cal4_layout = [
        [sg.T('H (%)', justification='right', size=(5,1)), sg.Input(key='H', enable_events=True, size=(12,1))],
    ]

    #equipment
    eq0_layout = [
        [sg.T('Gantry', justification='right', size=(12,1)), sg.DD(G, size=(11,1), enable_events=True, key='-G-', readonly=True)],
        [sg.T('GA (deg)', justification='right', size=(12,1)), sg.Input(key='GA', enable_events=True, default_text='0', size=(11,1))],
    ]
    eq1_layout = [
        [sg.T('Chamber Type', justification='right', size=(12,1)), sg.DD(Chtype, size=(11,1), default_value='Roos', enable_events=True, key='-Chtype-', readonly=True)],
        [sg.T('Chamber', justification='right', size=(12,1)), sg.DD(Ch, size=(11,1), enable_events=True, key='-Ch-', readonly=True)],
    ]
    eq2_layout = [
        [sg.T('Electrometer', justification='right', size=(12,1)), sg.DD(El, size=(11,1), enable_events=True, key='-El-', readonly=True)],
        [sg.T('Voltage (V)', justification='right', size=(12,1)), sg.DD(V, size=(11,1), enable_events=True, key='-V-', readonly=True)],
    ]

    #results
    def results_fields(layers=layers[0], Rng=Rng):
        en_layout = [ [sg.T('Energy (MeV):')] ]
        el_layout = [ [sg.T('Range:')] ]
        r1_layout = [ [sg.T('R1 (nC):')] ]
        r2_layout = [ [sg.T('R2 (nC):')] ]
        r3_layout = [ [sg.T('R3 (nC):')] ]
        r4_layout = [ [sg.T('R4 (nC):')] ]
        r5_layout = [ [sg.T('R5 (nC):')] ]
        rm_layout = [ [sg.T('Ravg (nC):')] ]
        rr_layout = [ [sg.T('Dref (Gy):')] ]
        diff_layout = [ [sg.T('Ddiff (%):')] ]
        rang_layout = [ [sg.T('Rrng (%):')] ]
        ad_layout = [ [sg.T('Davg (Gy):')] ]
        for i,E in enumerate(layers):
            en_layout.append([sg.T(str(E), size=(10,1), justification='right', key='E'+str(i), visible=True)])
            el_layout.append([sg.DD(Rng, size=(8,1), default_value=Rng[1], enable_events=True, key='-Rng'+str(i)+'-', readonly=True)])
            r1_layout.append([sg.InputText(key='r'+str(i)+'1', default_text='', size=(6,1), justification='right', enable_events=True)])
            r2_layout.append([sg.InputText(key='r'+str(i)+'2', default_text='', size=(6,1), justification='right', enable_events=True)])
            r3_layout.append([sg.InputText(key='r'+str(i)+'3', default_text='', size=(6,1), justification='right', enable_events=True)])
            r4_layout.append([sg.InputText(key='r'+str(i)+'4', default_text='', size=(6,1), justification='right', enable_events=True)])
            r5_layout.append([sg.InputText(key='r'+str(i)+'5', default_text='', size=(6,1), justification='right', enable_events=True)])
            rm_layout.append([sg.T('', background_color='lightgray', text_color='black', justification='right',  key='rm'+str(i), size=(6,1))])
            rr_layout.append([sg.T('', background_color='lightgray', text_color='black', justification='right',  key='rr'+str(i), size=(6,1))])
            diff_layout.append([sg.T('', background_color='lightgray', text_color='black', justification='right',  key='diff'+str(i), size=(6,1))])
            rang_layout.append([sg.T('', background_color='lightgray', text_color='black', justification='right',  key='rang'+str(i), size=(6,1))])
            ad_layout.append([sg.T('', background_color='lightgray', text_color='black', justification='right',  key='ad'+str(i), size=(6,1))])
        measurements_layout = sg.Frame('Measurements',
                                [[  sg.Column(en_layout),
                                    sg.Column(el_layout),
                                    sg.Column(r1_layout),
                                    sg.Column(r2_layout),
                                    sg.Column(r3_layout),
                                    sg.Column(r4_layout),
                                    sg.Column(r5_layout),
                                    sg.Column(rm_layout),
                                    sg.Column(rang_layout),
                                    sg.Column(ad_layout),
                                    sg.Column(rr_layout),
                                    sg.Column(diff_layout)  ]],
                                key='-Measurements-')
        return measurements_layout

    ml_layout = [
        [sg.Multiline('No comment', key='-ML-', enable_events=True, size=(135,3))],
    ]

    #buttons
    button_layout = [
        [sg.B('Check Session', key='-AnalyseS-'),
         sg.B('Submit to Database', disabled=True, key='-Submit-'),
         sg.FolderBrowse('Export to CSV', key='-CSV_WRITE-', disabled=True, target='-Export-'), sg.In(key='-Export-', enable_events=True, visible=False),
         sg.B('Clear Results', button_color='red', key='-NxtSess-')],
    ]

    #combine layout elements
    layout = [
        [sg.Text('Output Consistency:', font=['bold',18])],
        [sg.Frame('Session',[[sg.Column(sess0_layout), sg.Column(sess1_layout)]], size=(420,110)),
         sg.Frame('Calibration',[[sg.Column(cal0_layout), sg.Column(cal1_layout), sg.Column(cal3_layout)]], size=(420,110))],
        [sg.Frame('Equipment',[[sg.Column(eq0_layout), sg.Column(eq1_layout), sg.Column(eq2_layout)]], size=(688,80)), sg.Frame('Humidity',[[sg.Column(cal4_layout)]], size=(110,80))],
        [results_fields()],
        [sg.Frame('Comments', ml_layout)],
        [button_layout],
    ]

    icon_file = os.path.abspath(os.path.join(os.path.dirname(__file__), 'icon', 'strawberry_icon.ico'))
    return sg.Window('Output Consistency', layout, resizable=False, finalize=True, grab_anywhere=True, return_keyboard_events=True, icon=icon_file)


### Initialise output data dict
tpc=None
session_analysed = False
session = {}
results = {}
results['Rindex']=[]
results['ADate']=[]
results['Energy']=[]
results['R']=[]
results['Ravg']=[]
results['Rrange prcnt']=[]
results['RGy']=[]
results['RavgGy']=[]
results['Rref']=[]
results['Rdelta']=[]
export_flag=False
db_flag=False

### Generate GUI
window = build_window()
# bind keyboard presses to moving the active field in GUI (up, down, enter)
window.bind('<Return>', '-NEXTE-') 
window.bind('<Down>', '-NEXT-')
window.bind('<Up>', '-PREV-')

# Event Loop listens out for events e.g. button presses
while True:
    event, values = window.read()

    ### handle exit events
    if event == sg.WIN_CLOSED or event == 'Exit': ### user closes window or clicks cancel
        break

    ### clear fields on button press
    if event == '-NxtSess-':
        # deactivate buttons
        window['-Submit-'](disabled=True)
        window['-CSV_WRITE-'](disabled=True)
        # clear readings
        window['ADate'].Update('')
        window['GA'].Update('')
        window['-ML-'].Update('No comment')
        for i,E in enumerate(layers[0]):
            for r in range(1,6):
                window['r'+str(i)+str(r)].update('') 
            window['rm'+str(i)].update('') 
            window['rang'+str(i)].update('') 
            window['ad'+str(i)].update('') 
            window['diff'+str(i)].update('', background_color='light gray')  




    ### handle keyboard events
    if event == '-NEXT-':
        try:
            next_element = window.find_element_with_focus().get_next_focus()
            next_element.set_focus()
        except:
            "pass"
    if event == '-NEXTE-':
        try:
            next_element = window.find_element_with_focus().get_next_focus()
            next_element.set_focus()
        except:
            "pass"
    if event == '-PREV-':
        try:
            prev_element = window.find_element_with_focus().get_previous_focus()
            prev_element.set_focus()
        except:
            "pass"

    ### reset analysed flag if there is just about any event
    if event not in ['-Submit-','-AnalyseS-','-Export-','-ML-','-NEXT-','-NEXTE-','-PREV-',sg.WIN_CLOSED]:
        session_analysed=False
        window['-CSV_WRITE-'](disabled=True) # disable csv export button
        window['-Submit-'](disabled=True) # disable access export button
        
    ### Button event actions
    if event == '-AnalyseS-': ### Analyse results
        dd = values['ADate'][0:2]
        mm = values['ADate'][3:5]
        yy = values['ADate'][6:10]
        tt = values['ADate'][11:]
        dt = yy+"/"+mm+"/"+dd+" "+tt

        session = {}
        results = {}
        results['Rindex']=[]
        results['ADate']=[]
        results['Energy']=[]
        results['R']=[]
        results['Ravg']=[]
        results['Rrange prcnt']=[]
        results['RGy']=[]
        results['RavgGy']=[]
        results['Rref']=[]
        results['Rdelta']=[]
        print('Analysing...')
        session_analysed=True
        anal_flag = pre_analysis_check(values)
        if anal_flag[-1][0]:
            session_analysed = False
            print('ERROR: Session not analysed - check all information is entered correctly (Err Code: '+str(anal_flag[-1])+')')
        if session_analysed:
            try:
                session['Adate']=[dt]
                session['Op1']=[values['-Op1-']]
                session['Op2']=[values['-Op2-']]
                session['Temp']=[values['Temp']]
                session['P']=[values['Press']]
                session['Electrometer']=[values['-El-']]
                session['V']=[values['-V-']]
                session['Gantry']=[values['-G-']]
                session['GA']=[values['GA']]
                session['Chamber']=[values['-Ch-']]
                session['kQ']=[window['kq'].get()]
                session['ks']=[window['ks'].get()]
                session['kelec']=[window['kelec'].get()]
                session['kpol']=[window['kpol'].get()]
                session['NDW']=[window['ndw'].get()]
                session['TPC']=[str(tpc)]
                session['Humidity']=[values['H']]
                session['Comments']=[values['-ML-']]
            except:
                session_analysed = False
                print('ERROR: Session not analysed - check session data is complete')

        if session_analysed:
            try:
                refs = [ref_data[values['-G-']],ref_data['Energy']]
                tstamp = values['ADate']
                cnt=0
                for i,_ in enumerate(layers[0]):
                    if window['diff'+str(i)].get() != '':
                        en = int(window['E'+str(i)].get())
                        idx = refs[1].index(en)
                        r_mean, r_range, d_mean, d_diff, d, r = calc_metrics(str(i))
                        for j, (rn, dn) in enumerate(zip(r,d)):
                            cnt += 1
                            #results['Rindex'].append("%02d_%01d"%(i,j))
                            results['Rindex'].append(str(cnt))
                            results['ADate'].append(dt)
                            results['Energy'].append(window['E'+str(i)].get())
                            results['R'].append(str(rn))
                            results['Ravg'].append(str(r_mean))
                            results['Rrange prcnt'].append(str(r_range))
                            results['RGy'].append(str(dn))
                            results['RavgGy'].append(str(d_mean))
                            results['Rref'].append(str(refs[0][idx]))
                            results['Rdelta'].append(str(d_diff))
            except:
                session_analysed = False
                print('ERROR: Results not analysed - check all information is entered correctly')
                sg.popup("Session not analysed","Check you have entered all information correctly")
        
        if len(results['R'])==0 and session_analysed:
            session_analysed = False
            print('ERROR: Results not analysed - check measurements')
            sg.popup("No Results","Enter some results before clicking Check Session")

        if session_analysed:
            #activate buttons
            window['-CSV_WRITE-'](disabled=False)
            window['-Submit-'](disabled=False)
            # convert session and results to dataframes
            sess_df = pd.DataFrame.from_dict(session)
            reslt_df = pd.DataFrame.from_dict(
                {k: results[k] for k in results.keys() & {'Rindex', 'ADate', 'Energy', 'R', 'RGy'}}
                )
            
            db.review_dose(sess_df,reslt_df)


            print('Results analysed.')
        else:
            #deactivate buttons
            window['-CSV_WRITE-'](disabled=True)
            window['-Submit-'](disabled=True)

                
    if event == '-Export-': ### Export results to csv
        print('Exporting to csv...')
        export_flag=False
        try:
            # create timestamped folder
            csv_time = datetime.datetime.now().strftime("%Y-%m-%d_%H%M%S")
            csv_dir = values['-Export-']+os.sep+csv_time+'_'+values['-G-']
            os.makedirs(csv_dir, exist_ok=True)
            sess_df.to_csv(csv_dir+os.sep+'session.csv', index=False)
            reslt_df.to_csv(csv_dir+os.sep+'result.csv', index=False)
            print('Exported.')
            export_flag=True
        except:
            print('ERROR: Failed to export to csv!')
        if export_flag:
            #deactivate buttons
            window['-Submit-'](disabled=False)
        else:
            window['-Submit-'](disabled=True)


    if event == '-Submit-': ### Submit data to database
        print('Contacting database...')
        db_flag=False
        try:
            db.write_to_db(sess_df,reslt_df)
            db_flag=True
        except:
            print('ERROR: Failed write to database!')
            # create timestamped folder
            fldr = sg.popup_get_folder("DB write failed. Select a folder to save results:", "Save results to csv...", keep_on_top=True)
            csv_time = datetime.datetime.now().strftime("%Y-%m-%d_%H%M%S")
            csv_dir = fldr+os.sep+values['-Export-']+os.sep+csv_time+'_'+values['-G-']
            os.makedirs(csv_dir, exist_ok=True)
            sess_df.to_csv(csv_dir+os.sep+'session.csv', index=False)
            reslt_df.to_csv(csv_dir+os.sep+'result.csv', index=False)
            print('Exported.')
            export_flag=True
        if db_flag:
            #deactivate buttons
            window['-Submit-'](disabled=True)
            window['ADate'].Update('')
            values['ADate']=''
            window['-ML-'].Update('No comment')
        else:
            window['-CSV_WRITE-'](disabled=True)
            window['-Submit-'](disabled=True)

    ### Populate Chamber ID list
    if event == '-Chtype-':   # chamber type dictates chamber list
        if values['-Chtype-'] == 'Roos':
            Ch = Roos
        elif values['-Chtype-'] == 'Semiflex':
            Ch = Semiflex
        else:
            Ch = []
        window['-Ch-'].update(values=Ch, value='') # update Ch combo box
    
    ### Update calibration factors
    if event == '-G-':
        selected_ks = ks[values['-G-']]
        window['ks'](str(selected_ks)) 
        for i,_ in enumerate(layers[0]):
            _=calc_metrics(str(i))
    
    if event == '-Ch-':
        if values['-Ch-'] in Ch:
            selected_ndw = ndw[values['-Ch-']]
            selected_kpol = kpol[values['-Ch-']]
            window['kq'](str(kq)) 
            window['kpol'](str(selected_kpol))
            window['ndw'](str(selected_ndw)) 
        else:
            window['kq']('') 
            window['kpol']('')
            window['ndw']('') 
        for i,_ in enumerate(layers[0]):
            _=calc_metrics(str(i))

    if event == '-El-':
        if values['-El-'] in El:
            selected_kelec=kelec[values['-El-']]
            window['kelec'](str(selected_kelec)) 
        else:
            window['kelec']('') 
        for i,_ in enumerate(layers[0]):
            _=calc_metrics(str(i))

    ### Update temp and press correction
    if event in ['Temp','Press'] and re.match('[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)', values[event]):
        try:
            t = float(values['Temp'])
            p = float(values['Press'])
            tpc = (t+273.15)/293.15*1013.25/p
            window['tpc']('%.4f' % tpc)
            for i,_ in enumerate(layers[0]):
                _=calc_metrics(str(i))
        except:
            window['tpc']('')
    
    ### Update reference values
    if event == '-G-' and values['-G-'] in G:
        refs = [ref_data[values['-G-']],ref_data['Energy']]
        for i,_ in enumerate(layers[0]):
            if window['E'+str(i)].get() != '':
                en = int(window['E'+str(i)].get())
                idx = refs[1].index(en)
                window['rr'+str(i)].update("%.4f" % refs[0][idx])
            _=calc_metrics(str(i))

    ### Update measurement fields
    if event == '-Layers-':
        idx = en_layers.index(values['-Layers-'])
        l = layers[idx]
        for i,E in enumerate(layers[0]):
            if i<int(values['-Layers-']):
                en = l[i]
                window['E'+str(i)](en,visible=True)
                window['-Rng'+str(i)+'-'](visible=True)
                for j in range(1,6):
                    window['r'+str(i)+str(j)]('',visible=True)
                    values['r'+str(i)+str(j)]=''
                window['rm'+str(i)]('',visible=True)
                window['rr'+str(i)](visible=True)
                window['ad'+str(i)]('',visible=True)
                window['diff'+str(i)]('',visible=True)
                window['rang'+str(i)]('',visible=True)
            else:
                window['E'+str(i)](visible=False)
                window['-Rng'+str(i)+'-'](visible=False)
                for j in range(1,6):
                    window['r'+str(i)+str(j)]('',visible=False)
                    values['r'+str(i)+str(j)]=''
                window['rm'+str(i)]('',visible=False)
                window['rr'+str(i)](visible=False)
                window['ad'+str(i)]('',visible=False)
                window['diff'+str(i)]('',visible=False)
                window['rang'+str(i)]('',visible=False)
            _=calc_metrics(str(i))

    ### Update calibration factors
    if event == 'ADate':
        kpol, ndw, kelec, ks = db.update_cal(values['ADate'],Roos,Semiflex,El)
        
        if values['-G-'] in G:
            selected_ks=ks[values['-G-']]
            window['ks'](str(selected_ks))
        else:
            window['ks']('')
        
        if values['-Chtype-'] == 'Roos':
            Ch = Roos
        elif values['-Chtype-'] == 'Semiflex':
            Ch = Semiflex
        else:
            Ch = []
        window['-Ch-'].update(values=Ch, value='') # update Ch combo box

        if values['-El-'] in El:
            selected_kelec=kelec[values['-El-']]
            window['kelec'](str(selected_kelec)) 
        else:
            window['kelec']('') 

        if values['-Ch-'] in Ch:
            selected_ndw = ndw[values['-Ch-']]
            selected_kpol = kpol[values['-Ch-']]
            window['kq'](str(kq)) 
            window['kpol'](str(selected_kpol))
            window['ndw'](str(selected_ndw)) 
        else:
            window['kq']('') 
            window['kpol']('')
            window['ndw']('') 

        for i,_ in enumerate(layers[0]):
            _=calc_metrics(str(i))

    ### Calculate average, diff, range and dose on the fly
    if event in ['r'+str(i)+str(j) for i,_ in enumerate(layers[0]) for j in range(1,6)] and \
        (re.match('[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)', values[event]) or values[event]==''):      
        i = event[1:-1]
        _ = calc_metrics(i)
