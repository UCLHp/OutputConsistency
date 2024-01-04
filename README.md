# OutputConsistency
Output Consistency QA Check  
Code: https://github.com/UCLHp/OutputConsistency  
Author: Alex Grimwood  
  
Run example in python (Requires connection to database specified in config.cfg)  
`python main.py`  

* Fill in all Session, Calibration and Equipment fields  
* Record your Measurements  
* Check Session  
* Submit to Database or Export to CSV  
* If any changes are made to the form, Check Session again  
* End Session or close window  

Connects to 32-bit MS Access database, requires 32-bit Python:  
https://stackoverflow.com/questions/33709391/using-multiple-python-engines-32bit-64bit-and-2-7-3-5/58014896#58014896  

## `main.py`
Code for building and running GUI. It also includes functions for analysing data.
* `calc_metrics(i)`: Calculates mean dose from readings for energy layer i and updates GUI display. The function is called for most interactions with the GUI.
* `pre_analysis_check(values)`: Checks values entered into the GUI are valid. The function is called when "Check Session" button is pressed.
* `build_window()`: generates GUI window.
* GUI actions are handled within the `while` loop.



