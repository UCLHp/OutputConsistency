"""
Created on Thurs May 26 2022
@author: Alex Grimwood
Interaction with QA database
"""

import string
import PySimpleGUI as sg
import pypyodbc
from pypyodbc import IntegrityError
import pandas as pd

SESSION_TABLE = "OutputConsSession"
RESULTS_TABLE = "OutputConsResults"
DB_PATH = "\\\\9.40.120.20\\rtassetBE\\AssetsDatabase_be.accdb"
PASSWORD = "JoNiSi"

def populate_fields():
    '''
        Populate dropdown boxes from database
        return:
            Op          list of operator initials
            Roos        list of Roos chamber serials
            Semiflex    list of semiflex serials
            El          list of electrrometer serials
    '''
    print("Connecting to database...")
    connection_flag = True
    # operators list
    fields = {'table': 'Operators', 'target': 'Initials', 'filter_var': None}
    Op = read_db_data(fields)
    if not Op:
        print("Oops Op")
        Op = ['AB', 'AG', 'AGr', 'AJP', 'AK', 'AM', 'AT', 'AW', 'CB', 'CG', 'LHC', 'PI', 'RM', 'SC', 'SG', 'SavC', 'TNC', 'VMA', 'VR']
        connection_flag = False
    Op.sort()
    # chamber list
    fields = {'table': 'Assets', 'target': "[Serial Number]", 'filter_var': "Model", 'filter_val': 'TW34001SC'}
    Roos = read_db_data(fields)
    Roos = [str(int(i)) for i in Roos]
    if not Roos:
        print("Oops Roos")
        Roos = ['003126', '003128', '003131', '003132']
        connection_flag = False
    fields['filter_val'] = 'TW31021'
    Semiflex = read_db_data(fields)
    if not Semiflex:
        print("Oops Semiflex")
        Semiflex = ['142438', '142586', '142587']
        connection_flag = False
    # electrometer list
    fields['filter_val'] = 'UnidosE'
    El = read_db_data(fields)
    if not El:
        print("Oops El")
        El = ['92579', '92580', '92581']
        connection_flag = False
    if connection_flag:
        print("Connected...")
    return Op, Roos, Semiflex, El

def update_ref():
    '''
        Create a dictionary ref_data of most recent reference dose values
        in OutputConsRef table.

        list of reference dose energies:
            ref_data['Energy']

        lists of reference doses:
            ref_data['Gantry 1']
            ref_data['Gantry 2']
            ref_data['Gantry 3']
            ref_data['Gantry 4']
    '''
    # instantiate reference data
    e_lst = list(range(240,69,-10))
    ref_data = {'Energy': e_lst,
        'Gantry 1': [0]*len(e_lst),
        'Gantry 2': [0]*len(e_lst),
        'Gantry 3': [0]*len(e_lst),
        'Gantry 4': [0]*len(e_lst),
        }
    # connect to DB
    if not DB_PATH:
        sg.popup("Path Error.","Provide a path to the Access Database.")
        print("Database Path Missing!")
        return None
    if PASSWORD:
        new_connection = 'DRIVER={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=%s;PWD=%s'%(DB_PATH,PASSWORD) 
    else:
        new_connection = 'DRIVER={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=%s'%(DB_PATH)   
    try:  
        conn = pypyodbc.connect(new_connection)               
    except:
        print("Connection to table reference failed...")
        sg.popup("Could not connect to database","WARNING")
    if isinstance(conn,pypyodbc.Connection):
        # retrieve most recent reference data from DB
        sql =   '''
                Select A.Energy
                    , A.[Machine Name]
                    , A.RefDose
                    , A.RefDate
                From OutputConsRef As A
                Inner Join (
                    Select Energy
                        , [Machine Name]
                        , Max(RefDate) As MRefDate
                    From OutputConsRef
                    Group By Energy, [Machine Name]) As B
                On A.Energy = B.Energy
                And A.[Machine Name] = B.[Machine Name]
                And A.RefDate = B.MRefDate
            '''
        cursor = conn.cursor()
        cursor.execute(sql)
        records = cursor.fetchall()
        cursor.close()
        conn.commit()
        conn = None        
        #write to dict
        for row in records:
            en = row[0]
            machine = row[1]
            refdose = row[2]
            if en in e_lst:
                idx = e_lst.index(en)
                ref_data[machine][idx]=refdose
    return ref_data


def update_cal(Adate,roos,semiflex,elect):
    '''
        Retrieve valid calibration factors from database
        Input:
            Adate       string timestamp in the format dd/mm/yyyy hh:mm:ss
            roos        list of roos serial numbers
            semiflex    list of semiflex serial numbers
            elect       list of electrometer serial numbers

        Return int values for:
            kpol
            ndw
            kelec
    '''
    # concatenate all serial numbers
    roos = [str(int(i)) for i in roos]
    ch_numbers = roos + semiflex

    # instantiate cal factor dicts
    kpol = {}
    ndw = {}
    kelec = {}
    if Adate=='':
        sg.popup("Date required","Please enter a date to retrieve the latest calibration factors.")
        return False
    else:
        # reformat date
        d = Adate[0:2]
        m = Adate[3:5]
        y = Adate[6:10]
        #query_date = y+'-'+m+'-'+d
        query_date = "'%s-%s-%s'"%(y,m,d)
        # query database for most recent calibration factors
        sql = '''SELECT CQ2.*, Assets.Category \
            FROM Assets INNER JOIN \
            (SELECT Calibration.Equipment, Calibration.[CalFactor], Calibration.Kpol, Calibration.[Cal Date] \
            FROM (SELECT A.[Equipment], Max(A.[Cal Date]) AS [MaxOfCal Date] \
            FROM Calibration AS A WHERE A.[Cal Date] <= CDate(%s) \
            GROUP BY A.[Equipment])  AS CQ1 INNER JOIN Calibration \
            ON (CQ1.[MaxOfCal Date] = Calibration.[Cal Date]) AND (CQ1.Equipment = Calibration.Equipment) \
            WHERE ((Calibration.Operator) Is Not Null))  AS CQ2 ON Assets.Item = CQ2.Equipment;'''%(query_date)
        new_connection = 'DRIVER={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=%s;PWD=%s'%(DB_PATH,PASSWORD) 
        conn = pypyodbc.connect(new_connection)  
        cursor = conn.cursor()
        cursor.execute(sql)
        records = cursor.fetchall()
        cursor.close()
        conn.commit()
        #conn = None
        # cal factors to dicts
        for k in records:
            for x in ch_numbers:
                if "["+x+"]" in k[0]:
                    ndw[x]=int(k[1])
                    kpol[x]=int(k[2])
            for y in elect:
                if "["+y+"]" in k[0]:
                    kelec[y]=int(k[1])

        # query database for most recent gantry-specific cal factors
        sql = '''
            SELECT
                Outputcons_ks.MachineName, Outputcons_ks.CorrFactorVal
            FROM
                (SELECT
                    MachineName, Max(CalDate) AS MCalD
                FROM
                    Outputcons_ks
                GROUP BY
                    MachineName) AS B
            INNER JOIN
                Outputcons_ks
            ON
                Outputcons_ks.MachineName = B.MachineName AND
                Outputcons_ks.CalDate = B.MCalD
            WHERE
                Outputcons_ks.CorrFactor LIKE 'ks'
            '''
        cursor = conn.cursor()
        cursor.execute(sql)
        records = cursor.fetchall()
        cursor.close()
        conn.commit()
        conn = None
        ks = dict(records)

        return kpol, ndw, kelec, ks


def read_db_data(fields):
    '''
        Helper function
        Return record from a table as a list
        If DB connection fails, return None
        Input dict fields:
            fields['target']        desired record field(s)
            fields['table']         table containing the records
            fields['filter_var']    field to filter records
            fields['filter_val']    value of filter field
        
        Return:
            data                    list of records
    '''

    target = fields['target']
    table = fields['table']
    filter_var = fields['filter_var']
    if filter_var:
        filter_val = fields['filter_val']

    conn=None

    if not DB_PATH:
        sg.popup("Path Error.","Provide a path to the Access Database.")
        print("Database Path Missing!")
        return None
    if PASSWORD:
        new_connection = 'DRIVER={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=%s;PWD=%s'%(DB_PATH,PASSWORD) 
    else:
        new_connection = 'DRIVER={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=%s'%(DB_PATH)   
    try:  
        conn = pypyodbc.connect(new_connection)               
    except:
        print("Connection to table "+table+" failed...")
        sg.popup("Could not connect to database","WARNING")
    if isinstance(conn,pypyodbc.Connection):
        if filter_var:
            sql = '''
                    SELECT %s FROM %s WHERE %s = '%s'
                '''%(target, table, filter_var, filter_val)
        else:
            sql = '''
                    SELECT %s FROM %s
                '''%(target, table)
        cursor = conn.cursor()
        cursor.execute(sql)
        records = cursor.fetchall()
        cursor.close()
        conn.commit()
        conn = None
        data = []
        for row in records:
            if len(row)==1:
                data.append(row[0])
            else:
                data.append(list(row))
        return data
    else:
        return None

def write_session_data(conn, df_session):
    '''
        Helper function
        Write to session table and return True if successful, else false
        Input:
            conn            database connection object
            df_session      dataframe of session table values
    '''
       
    cursor = conn.cursor()   
    sql = '''
            INSERT INTO "%s" (ADate, [Op1], [Op2], [T], [P], \
                Electrometer, [V], MachineName, [GA], Chamber, [kQ], \
                    [ks], [kelec], [kpol], NDW, TPC, Comments)
            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
          '''%(SESSION_TABLE)
    data = df_session.values.tolist()[0]    
    try:
        print("Writing session to database...")
        cursor.execute(sql, data)
        conn.commit()
        cursor.close()
        return True
    except IntegrityError:
        sg.popup("Session Write Error","WARNING: Write to database failed.")
        print("Integrity Error, nothing written to database")
        cursor.close()
        return False  


def write_results_data(conn,df_results):
    '''
        Helper function
        Write results to table and return True if successful
        Input:
            conn            database connection object
            df_results      dataframe of results table values
        
        Return:
            write_flag      True if write successful, else False
    '''
    
    cursor = conn.cursor()   
    sql = '''
            INSERT INTO "%s" (Rindex, ADate, Energy, [R], RGy) 
            VALUES (?,?,?,?,?)  
         '''%(RESULTS_TABLE)
    print("Writing results to database...")
    write_flag = True
    for row in df_results.iterrows():
        try:
            data = [
                str(row[1]['Rindex']),
                str(row[1]['ADate']),
                int(row[1]['Energy']),
                float(row[1]['R']), 
                float(row[1]['RGy']),                 
            ]
            cursor.execute(sql, data)
        except IntegrityError:
            sg.popup("Results Write Error","WARNING: Write to database failed.")
            print("Integrity Error, record "+str(row[0]+1)+" not written to database")
            write_flag = False        
    conn.commit()
    cursor.close()
    return write_flag


def write_to_db(df_session,df_results):
    '''
        Write session and results dataframes to tables
        Input:
            df_session      dataframe of session table values   
            df_results      dataframe of results table values
    '''
    
    conn=None

    if not DB_PATH:
        sg.popup("Write Failed.","Provide a path to the Access Database.")
        return

    if PASSWORD:
        new_connection = 'DRIVER={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=%s;PWD=%s'%(DB_PATH,PASSWORD) 
    else:
        new_connection = 'DRIVER={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=%s'%(DB_PATH)   

    try:  
        print('trying to connect')
        conn = pypyodbc.connect(new_connection)                 
    except:
        #sg.popup("Could not connect to database, nothing written","WARNING")
        print("Could not connect to database; nothing written")
    
    if isinstance(conn,pypyodbc.Connection):
        session_written = write_session_data(conn,df_session)
        print("Session Write Status: "+str(session_written))
        if session_written:
            results_written = write_results_data(conn,df_results)
            print("Results Write Status: "+str(results_written))
