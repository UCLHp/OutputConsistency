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
DB_PATH = None
PASSWORD = None

def populate_fields():
    print("Connecting to database...")
    connection_flag = True
    # baseline data needs updating
    baseline_readings = [[5,10,14,20,25],[3,6,8.4,12,15]]
    # gantry list
    G = ['Gantry 1', 'Gantry 2', 'Gantry 3', 'Gantry 4']
    # chamber type list
    Chtype = ['Roos', 'Semiflex']
    # voltage list
    V = [-400,-200,0,200,400]
    # electrometer range list
    Rng = ['Low','Medium','High']
    # operator list
    fields = {'table': 'Operators', 'target': 'Initials', 'filter_var': None}
    Op = read_db_data(fields)
    if not Op:
        Op = ['AB', 'AG', 'AGr', 'AJP', 'AK', 'AM', 'AT', 'AW', 'CB', 'CG', 'PI', 'RM', 'SC', 'SG', 'SavC', 'TNC', 'VMA', 'VR']
        connection_flag = False
    Op.sort()
    # chamber list
    fields = {'table': 'Assets', 'target': "[Serial Number]", 'filter_var': "Model", 'filter_val': 'TW34001SC'}
    Roos = read_db_data(fields)
    if not Roos:
        Roos = ['003126', '003128', '003131', '003132']
        connection_flag = False
    fields['filter_val'] = 'TW31021'
    Semiflex = read_db_data(fields)
    if not Semiflex:
        Semiflex = ['142438', '142586', '142587']
        connection_flag = False
    Ch = []
    # electrometer list
    fields['filter_val'] = 'UnidosE'
    El = read_db_data(fields)
    if not El:
        El = ['92579', '92580', '92581']
        connection_flag = False
    if connection_flag:
        print("Connected...")
    return G, Chtype, V, Rng, Op, Roos, Semiflex, Ch, El, baseline_readings

def read_db_data(fields):
    ''' Return field records from a table as a list'''
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
        sg.popup("WARNING","Could not connect to database")
        print("Connection to table "+table+" failed...")
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
            data.append(row[0])
        return data
    else:
        return None

def write_session_data(conn, df_session):
    '''Write to session table; return True if successful'''
        
    cursor = conn.cursor()   
    sql = '''
            INSERT INTO "%s" (ADate, [Op1], [Op2], [T], [P], \
                Electrometer, [V], [GA], Chamber, [kQ], [ks], [kelec], [kpol], NDW, TPC, Comments)
            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
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
    """Write results to table; return true if successful"""    
    
    cursor = conn.cursor()   
    sql = '''
            INSERT INTO "%s" (Rindex, ADate, Energy, [R], Ravg, \
                [Rrange prcnt], RGy, Rref, Rdelta) 
            VALUES (?,?,?,?,?,?,?,?,?)  
         '''%(RESULTS_TABLE)
    print("Writing results to database...")
    write_flag = True
    for i,row in df_results.iterrows():
        try:
            data = row.values.tolist()
            for n,j in enumerate(data):
                if not isinstance(j,(float, int, str)):
                    data[n] = str(j)
            cursor.execute(sql, data)
        except IntegrityError:
            sg.popup("Results Write Error","WARNING: Write to database failed.")
            print("Integrity Error, record "+str(i+1)+" not written to database")
            write_flag = False
        
    conn.commit()
    cursor.close()
    return write_flag


def write_to_db(df_session,df_results):
    '''main function: write session and results dataframes to tables'''
    
    conn=None

    if not DB_PATH:
        sg.popup("Write Failed.","Provide a path to the Access Database.")
        return

    if PASSWORD:
        new_connection = 'DRIVER={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=%s;PWD=%s'%(DB_PATH,PASSWORD) 
    else:
        new_connection = 'DRIVER={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=%s'%(DB_PATH)   

    try:  
        conn = pypyodbc.connect(new_connection)                 
    except:
        sg.popup("Could not connect to database, nothing written","WARNING")
        print("Could not connect to database; nothing written")
    
    if isinstance(conn,pypyodbc.Connection):
        session_written = write_session_data(conn,df_session)
        print("Session Write Status: "+str(session_written))
        if session_written:
            results_written = write_results_data(conn,df_results)
            print("Results Write Status: "+str(results_written))
