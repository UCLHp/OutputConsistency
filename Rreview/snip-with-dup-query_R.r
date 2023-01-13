# with a (named) list of col objects:
# MeasuredBy,Date,ChamberSN,ElectrometerUsed,ElectrometerRange,TdegC,PhPa,GA,V1,NDW,TPC,Energy,R1,R2,R3,R4,R5,Avg,range,Gy,Diff,Comments

OutputG1raw = read_csv("OutputG1.txt", col_types = list(
  MeasuredBy = col_character(),
  Date = col_date( format = "%d/%m/%Y" ) ,
  ChamberSN = col_factor(levels=c("3131","3126","3128","3132")),
  ElectrometerUsed = col_factor(levels=c("92579","92578","92581","92580")),
  ElectrometerRange = col_factor(levels=c("Medium","Low","High")),
  TdegC = col_double(),
  PhPa = col_double(),
  GA = col_factor(levels=c("0","90","270","180")),
  V1 = col_factor(levels=c("200","-200","0")),
  NDW = col_double(),
  TPC = col_double(),
  Energy = col_factor(levels = c("70","80","90","100","110","120","130","140","150","160","170","180","190","200","210","220","230","240")),
  R1 =col_double(),
  R2 =col_double(),
  R3 =col_double(),
  R4 =col_double(),
  R5 =col_double(),
  Avg =col_double(),
  range =col_double(),
  Gy =col_double(),
  Diff =col_double(),
  Comments =col_character()
  ))

  
  #2
  OutputG2raw = read_csv("OutputG2.txt", col_types = list(
  MeasuredBy = col_character(),
  Date = col_date( format = "%d/%m/%Y" ) ,
  ChamberSN = col_factor(levels=c("3131","3126","3128","3132")),
  ElectrometerUsed = col_factor(levels=c("92579","92578","92581","92580")),
  ElectrometerRange = col_factor(levels=c("Medium","Low","High")),
  TdegC = col_double(),
  PhPa = col_double(),
  GA = col_factor(levels=c("0","90","270","180")),
  V1 = col_factor(levels=c("200","-200","0")),
  NDW = col_double(),
  TPC = col_double(),
  Energy = col_factor(levels = c("70","80","90","100","110","120","130","140","150","160","170","180","190","200","210","220","230","240")),
  R1 =col_double(),
  R2 =col_double(),
  R3 =col_double(),
  R4 =col_double(),
  R5 =col_double(),
  Avg =col_double(),
  range =col_double(),
  Gy =col_double(),
  Diff =col_double(),
  Comments =col_character()
  ))

  #3
  OutputG3raw = read_csv("OutputG3.txt", col_types = list(
  MeasuredBy = col_character(),
  Date = col_date( format = "%d/%m/%Y" ) ,
  ChamberSN = col_factor(levels=c("3131","3126","3128","3132")),
  ElectrometerUsed = col_factor(levels=c("92579","92578","92581","92580")),
  ElectrometerRange = col_factor(levels=c("Medium","Low","High")),
  TdegC = col_double(),
  PhPa = col_double(),
  GA = col_factor(levels=c("0","90","270","180")),
  V1 = col_factor(levels=c("200","-200","0")),
  NDW = col_double(),
  TPC = col_double(),
  Energy = col_factor(levels = c("70","80","90","100","110","120","130","140","150","160","170","180","190","200","210","220","230","240")),
  R1 =col_double(),
  R2 =col_double(),
  R3 =col_double(),
  R4 =col_double(),
  R5 =col_double(),
  Avg =col_double(),
  range =col_double(),
  Gy =col_double(),
  Diff =col_double(),
  Comments =col_character()
  ))

  #4
  OutputG4raw = read_csv("OutputG4.txt", col_types = list(
  MeasuredBy = col_character(),
  Date = col_date( format = "%d/%m/%Y" ) ,
  ChamberSN = col_factor(levels=c("3131","3126","3128","3132")),
  ElectrometerUsed = col_factor(levels=c("92579","92578","92581","92580")),
  ElectrometerRange = col_factor(levels=c("Medium","Low","High")),
  TdegC = col_double(),
  PhPa = col_double(),
  GA = col_factor(levels=c("0","90","270","180")),
  V1 = col_factor(levels=c("200","-200","0")),
  NDW = col_double(),
  TPC = col_double(),
  Energy = col_factor(levels = c("70","80","90","100","110","120","130","140","150","160","170","180","190","200","210","220","230","240")),
  R1 =col_double(),
  R2 =col_double(),
  R3 =col_double(),
  R4 =col_double(),
  R5 =col_double(),
  Avg =col_double(),
  range =col_double(),
  Gy =col_double(),
  Diff =col_double(),
  Comments =col_character()
  ))
  
  #Or, with their abbreviations:
#region prepend column for gantry ID
prep_g1 = first_col(OutputG1raw,as.factor(1),var="Gantry")
prep_g2 = first_col(OutputG2raw,as.factor(2),var="Gantry")
prep_g3 = first_col(OutputG3raw,as.factor(3),var="Gantry")
prep_g4 = first_col(OutputG4raw,as.factor(4),var="Gantry")
#region bind rows together
prepAllG = bind_rows(prep_g1,prep_g2,prep_g3,prep_g4)

# write out file for later use and audit purposes
write_excel_csv( prepAllG, "OutputGallxl3.csv", na = "NA", append = FALSE, col_names = TRUE, delim = ",", quote = "none", escape = c("double", "backslash", "none"), eol = "\n", num_threads = readr_threads(), progress = show_progress() )
