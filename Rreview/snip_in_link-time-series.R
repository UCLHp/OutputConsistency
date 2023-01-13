https://www.business-science.io/code-tools/2017/10/25/demo_week_sweep.html
https://www.business-science.io/code-tools/2017/10/26/demo_week_tibbletime.html

devtools::install_github("business-science/tibbletime")
#region failed - no g++ installed
#region
notes
+     ElectrometerRange = col_factor(levels=c("Medium","Low","High")),
+     TdegC = col_double(),
+     PhPa = col_double(),
+     GA = col_factor(levels=c("0","90","270","180")),
+     V1 = col_factor(levels=c("200","-200","0")),
+     NDW = col_double(),
+     TPC = col_double(),
+     Energy = col_factor(levels = c("70","80","90","100","110","120","130","140","150","160","170","180","190","200","210","220","230","240")),
+     R1 =col_double(),
+     R2 =col_double(),
+     R3 =col_double(),
+     R4 =col_double(),
+     R5 =col_double(),
+     Avg =col_double(),
+     range =col_double(),
+     Gy =col_double(),
+     Diff =col_double(),
+     Comments =col_character()
+ ))
                                                                                                                                          
> glimpse(OutputG1raw)
Rows: 2,016
Columns: 22
$ MeasuredBy        <chr> "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG~
$ Date              <date> 2023-01-02, 2023-01-02, 2023-01-02, 2023-01-02, 2023-01-02, 2023-01-02, 20~
$ ChamberSN         <fct> 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 313~
$ ElectrometerUsed  <fct> 92579, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
$ ElectrometerRange <fct> Medium, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ TdegC             <dbl> 23.9, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 2~
$ PhPa              <dbl> 1018.9, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ GA                <fct> 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, ~
$ V1                <fct> -200, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, -~
$ NDW               <dbl> 83700000, 83700000, 83700000, 83700000, 83700000, 83700000, 83700000, 83700~
$ TPC               <dbl> 1.007685, 1.007685, 1.007685, 1.007685, 1.007685, 1.007685, 1.007685, 1.007~
$ Energy            <fct> 240, 230, 220, 210, 200, 190, 180, 170, 160, 150, 140, 130, 120, 110, 100, ~
$ R1                <dbl> 6.645, 6.627, 6.616, 6.608, 6.596, 6.584, 6.578, 6.593, 6.600, 6.615, 6.647~
$ R2                <dbl> 6.638, 6.627, 6.619, 6.598, 6.594, 6.589, 6.584, 6.588, 6.600, 6.619, 6.639~
$ R3                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ R4                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ R5                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ Avg               <dbl> 6.642, 6.627, 6.618, 6.603, 6.595, 6.587, 6.581, 6.591, 6.600, 6.617, 6.643~
$ range             <dbl> 0.11, 0.00, 0.05, 0.15, 0.03, 0.08, 0.09, 0.08, 0.00, 0.06, 0.12, 0.04, 0.0~
$ Gy                <dbl> 0.6186, 0.6173, 0.6164, 0.6151, 0.6143, 0.6135, 0.6130, 0.6139, 0.6148, 0.6~
$ Diff              <dbl> -0.3334, -0.2845, -0.2194, -0.2022, -0.1823, -0.1752, -0.2292, -0.1639, -0.~
$ Comments          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
> OutputG2raw = read_csv("OutputG2.txt", col_types = list(
+     MeasuredBy = col_character(),
+     Date = col_date( format = "%d/%m/%Y" ) ,
+     ChamberSN = col_factor(levels=c("3131","3126","3128","3132")),
+     ElectrometerUsed = col_factor(levels=c("92579","92578","92581","92580")),
+     ElectrometerRange = col_factor(levels=c("Medium","Low","High")),
+     TdegC = col_double(),
+     PhPa = col_double(),
+     GA = col_factor(levels=c("0","90","270","180")),
+     V1 = col_factor(levels=c("200","-200","0")),
+     NDW = col_double(),
+     TPC = col_double(),
+     Energy = col_factor(levels = c("70","80","90","100","110","120","130","140","150","160","170","180","190","200","210","220","230","240")),
+     R1 =col_double(),
+     R2 =col_double(),
+     R3 =col_double(),
+     R4 =col_double(),
+     R5 =col_double(),
+     Avg =col_double(),
+     range =col_double(),
+     Gy =col_double(),
+     Diff =col_double(),
+     Comments =col_character()
+ ))
Warning message:                                                                                     
One or more parsing issues, call `problems()` on your data frame for details, e.g.:
  dat <- vroom(...)
  problems(dat) 
> problems(OutputG2raw)
# A tibble: 42 x 5
     row   col expected actual  file 
   <int> <int> <chr>    <chr>   <chr>
 1   429    21 a double #VALUE! ""   
 2   430    21 a double #VALUE! ""   
 3   431    21 a double #VALUE! ""   
 4   432    21 a double #VALUE! ""   
 5   433    21 a double #VALUE! ""   
 6   645    21 a double #VALUE! ""   
 7   646    21 a double #VALUE! ""   
 8   647    21 a double #VALUE! ""   
 9   648    21 a double #VALUE! ""   
10   649    21 a double #VALUE! ""   
# ... with 32 more rows
# i Use `print(n = ...)` to see more rows
> OutputG2raw = read_csv("OutputG2.txt", col_types = list(
+     MeasuredBy = col_character(),
+     Date = col_date( format = "%d/%m/%Y" ) ,
+     ChamberSN = col_factor(levels=c("3131","3126","3128","3132")),
+     ElectrometerUsed = col_factor(levels=c("92579","92578","92581","92580")),
+     ElectrometerRange = col_factor(levels=c("Medium","Low","High")),
+     TdegC = col_double(),
+     PhPa = col_double(),
+     GA = col_factor(levels=c("0","90","270","180")),
+     V1 = col_factor(levels=c("200","-200","0")),
+     NDW = col_double(),
+     TPC = col_double(),
+     Energy = col_factor(levels = c("70","80","90","100","110","120","130","140","150","160","170","180","190","200","210","220","230","240")),
+     R1 =col_double(),
+     R2 =col_double(),
+     R3 =col_double(),
+     R4 =col_double(),
+     R5 =col_double(),
+     Avg =col_double(),
+     range =col_double(),
+     Gy =col_double(),
+     Diff =col_double(),
+     Comments =col_character()
+ ))
                                                                                                     
> problems(OutputG2raw)
# A tibble: 0 x 5
# ... with 5 variables: row <int>, col <int>, expected <chr>, actual <chr>, file <chr>
# i Use `colnames()` to see all variable names
> glimpse(OutputG2raw)
Rows: 2,124
Columns: 22
$ MeasuredBy        <chr> "JW", "JW", "JW", "JW", "JW", "JW", "JW", "JW", "JW", "JW", "JW", "JW", "JW~
$ Date              <date> 2023-01-10, 2023-01-10, 2023-01-10, 2023-01-10, 2023-01-10, 2023-01-10, 20~
$ ChamberSN         <fct> 3128, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 3~
$ ElectrometerUsed  <fct> 92581, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
$ ElectrometerRange <fct> Medium, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ TdegC             <dbl> 23.0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 2~
$ PhPa              <dbl> 1000.1, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ GA                <fct> 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, ~
$ V1                <fct> -200, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, -~
$ NDW               <dbl> 83585563, 83585563, 83585563, 83585563, 83585563, 83585563, 83585563, 83585~
$ TPC               <dbl> 1.0235, 1.0235, 1.0235, 1.0235, 1.0235, 1.0235, 1.0235, 1.0235, 1.0235, 1.0~
$ Energy            <fct> 240, 230, 220, 210, 200, 190, 180, 170, 160, 150, 140, 130, 120, 110, 100, ~
$ R1                <dbl> 6.547, 6.538, 6.536, 6.512, 6.512, 6.503, 6.503, 6.508, 6.522, 6.534, 6.572~
$ R2                <dbl> 6.545, 6.538, 6.529, 6.514, 6.495, 6.508, 6.503, 6.510, 6.513, 6.535, 6.567~
$ R3                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ R4                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ R5                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ Avg               <dbl> 6.546, 6.538, 6.533, 6.513, 6.504, 6.506, 6.503, 6.509, 6.518, 6.535, 6.570~
$ range             <dbl> 0.03, 0.00, 0.11, 0.03, 0.26, 0.08, 0.00, 0.03, 0.14, 0.02, 0.08, 0.03, 0.0~
$ Gy                <dbl> 0.6185, 0.6177, 0.6172, 0.6154, 0.6145, 0.6147, 0.6144, 0.6150, 0.6158, 0.6~
$ Diff              <dbl> -0.4960, -0.2806, -0.2076, -0.3467, -0.3831, -0.2874, -0.3101, -0.3384, -0.~
$ Comments          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
> OutputG3raw = read_csv("OutputG3.txt", col_types = list(
+     MeasuredBy = col_character(),
+     Date = col_date( format = "%d/%m/%Y" ) ,
+     ChamberSN = col_factor(levels=c("3131","3126","3128","3132")),
+     ElectrometerUsed = col_factor(levels=c("92579","92578","92581","92580")),
+     ElectrometerRange = col_factor(levels=c("Medium","Low","High")),
+     TdegC = col_double(),
+     PhPa = col_double(),
+     GA = col_factor(levels=c("0","90","270","180")),
+     V1 = col_factor(levels=c("200","-200","0")),
+     NDW = col_double(),
+     TPC = col_double(),
+     Energy = col_factor(levels = c("70","80","90","100","110","120","130","140","150","160","170","180","190","200","210","220","230","240")),
+     R1 =col_double(),
+     R2 =col_double(),
+     R3 =col_double(),
+     R4 =col_double(),
+     R5 =col_double(),
+     Avg =col_double(),
+     range =col_double(),
+     Gy =col_double(),
+     Diff =col_double(),
+     Comments =col_character()
+ ))
Warning message:                                                                                                                          
One or more parsing issues, call `problems()` on your data frame for details, e.g.:
  dat <- vroom(...)
  problems(dat) 
> problems(OutputG3raw)
# A tibble: 28 x 5
     row   col expected           actual   file                                                        
   <int> <int> <chr>              <chr>    <chr>                                                       
 1     2     3 value in level set 3131.00  C:/Users/alemoore/Documents/DoseCons/OutputConsistency/Rrev~
 2     2     4 value in level set 92579.00 C:/Users/alemoore/Documents/DoseCons/OutputConsistency/Rrev~
 3    20     3 value in level set 3131.00  C:/Users/alemoore/Documents/DoseCons/OutputConsistency/Rrev~
 4    20     4 value in level set 92579.00 C:/Users/alemoore/Documents/DoseCons/OutputConsistency/Rrev~
 5    38     3 value in level set 3131.00  C:/Users/alemoore/Documents/DoseCons/OutputConsistency/Rrev~
 6    38     4 value in level set 92579.00 C:/Users/alemoore/Documents/DoseCons/OutputConsistency/Rrev~
 7    56     3 value in level set 3131.00  C:/Users/alemoore/Documents/DoseCons/OutputConsistency/Rrev~
 8    56     4 value in level set 92579.00 C:/Users/alemoore/Documents/DoseCons/OutputConsistency/Rrev~
 9    74     3 value in level set 3132.00  C:/Users/alemoore/Documents/DoseCons/OutputConsistency/Rrev~
10    74     4 value in level set 92579.00 C:/Users/alemoore/Documents/DoseCons/OutputConsistency/Rrev~
# ... with 18 more rows
# i Use `print(n = ...)` to see more rows
> OutputG3raw = read_csv("OutputG3.txt", col_types = list(
+     MeasuredBy = col_character(),
+     Date = col_date( format = "%d/%m/%Y" ) ,
+     ChamberSN = col_factor(levels=c("3131","3126","3128","3132")),
+     ElectrometerUsed = col_factor(levels=c("92579","92578","92581","92580")),
+     ElectrometerRange = col_factor(levels=c("Medium","Low","High")),
+     TdegC = col_double(),
+     PhPa = col_double(),
+     GA = col_factor(levels=c("0","90","270","180")),
+     V1 = col_factor(levels=c("200","-200","0")),
+     NDW = col_double(),
+     TPC = col_double(),
+     Energy = col_factor(levels = c("70","80","90","100","110","120","130","140","150","160","170","180","190","200","210","220","230","240")),
+     R1 =col_double(),
+     R2 =col_double(),
+     R3 =col_double(),
+     R4 =col_double(),
+     R5 =col_double(),
+     Avg =col_double(),
+     range =col_double(),
+     Gy =col_double(),
+     Diff =col_double(),
+     Comments =col_character()
+ ))
                                                                                                                                          
> problems(OutputG3raw)
# A tibble: 0 x 5
# ... with 5 variables: row <int>, col <int>, expected <chr>, actual <chr>, file <chr>
# i Use `colnames()` to see all variable names
> glimpse(OutputG3raw)
Rows: 1,260
Columns: 22
$ MeasuredBy        <chr> "AGr", "AGr", "AGr", "AGr", "AGr", "AGr", "AGr", "AGr", "AGr", "AGr", "AGr"~
$ Date              <date> 2022-12-19, 2022-12-19, 2022-12-19, 2022-12-19, 2022-12-19, 2022-12-19, 20~
$ ChamberSN         <fct> 3131, 3131, 3131, 3131, 3131, 3131, 3131, 3131, 3131, 3131, 3131, 3131, 313~
$ ElectrometerUsed  <fct> 92579, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
$ ElectrometerRange <fct> Medium, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ TdegC             <dbl> 23.7, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 2~
$ PhPa              <dbl> 1003.8, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ GA                <fct> 180, 180, 180, 180, 180, 180, 180, 180, 180, 180, 180, 180, 180, 180, 180, ~
$ V1                <fct> -200, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, -~
$ NDW               <dbl> 83300000, 83300000, 83300000, 83300000, 83300000, 83300000, 83300000, 83300~
$ TPC               <dbl> 1.022155, 1.022155, 1.022155, 1.022155, 1.022155, 1.022155, 1.022155, 1.022~
$ Energy            <fct> 240, 230, 220, 210, 200, 190, 180, 170, 160, 150, 140, 130, 120, 110, 100, ~
$ R1                <dbl> 6.573, 6.560, 6.552, 6.543, 6.531, 6.531, 6.530, 6.531, 6.545, 6.566, 6.599~
$ R2                <dbl> 6.580, 6.561, 6.553, 6.546, 6.530, 6.521, 6.525, 6.531, 6.544, 6.567, 6.597~
$ R3                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ R4                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ R5                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ Avg               <dbl> 6.577, 6.561, 6.553, 6.545, 6.531, 6.526, 6.528, 6.531, 6.545, 6.567, 6.598~
$ range             <dbl> 0.11, 0.02, 0.02, 0.05, 0.02, 0.15, 0.08, 0.00, 0.02, 0.02, 0.03, 0.03, 0.0~
$ Gy                <dbl> 0.6184, 0.6169, 0.6162, 0.6154, 0.6141, 0.6137, 0.6138, 0.6141, 0.6154, 0.6~
$ Diff              <dbl> -0.2355, -0.1972, -0.1698, -0.0948, -0.1698, -0.1366, -0.0901, -0.1057, -0.~
$ Comments          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
> OutputG4raw = read_csv("OutputG4.txt", col_types = list(
+     MeasuredBy = col_character(),
+     Date = col_date( format = "%d/%m/%Y" ) ,
+     ChamberSN = col_factor(levels=c("3131","3126","3128","3132")),
+     ElectrometerUsed = col_factor(levels=c("92579","92578","92581","92580")),
+     ElectrometerRange = col_factor(levels=c("Medium","Low","High")),
+     TdegC = col_double(),
+     PhPa = col_double(),
+     GA = col_factor(levels=c("0","90","270","180")),
+     V1 = col_factor(levels=c("200","-200","0")),
+     NDW = col_double(),
+     TPC = col_double(),
+     Energy = col_factor(levels = c("70","80","90","100","110","120","130","140","150","160","170","180","190","200","210","220","230","240")),
+     R1 =col_double(),
+     R2 =col_double(),
+     R3 =col_double(),
+     R4 =col_double(),
+     R5 =col_double(),
+     Avg =col_double(),
+     range =col_double(),
+     Gy =col_double(),
+     Diff =col_double(),
+     Comments =col_character()
+ ))
                                                                                                                                          
> glimpse(OutputG4raw)
Rows: 1,980
Columns: 22
$ MeasuredBy        <chr> "JW", "JW", "JW", "JW", "JW", "JW", "JW", "JW", "JW", "JW", "JW", "JW", "JW~
$ Date              <date> 2023-01-06, 2023-01-06, 2023-01-06, 2023-01-06, 2023-01-06, 2023-01-06, 20~
$ ChamberSN         <fct> 3131, 3131, 3131, 3131, 3131, 3131, 3131, 3131, 3131, 3131, 3131, 3131, 313~
$ ElectrometerUsed  <fct> 92579, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
$ ElectrometerRange <fct> Medium, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ TdegC             <dbl> 22.6, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 2~
$ PhPa              <dbl> 1012.4, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ GA                <fct> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 270, 270, 270, 270, 2~
$ V1                <fct> -200, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, -~
$ NDW               <dbl> 83300000, 83300000, 83300000, 83300000, 83300000, 83300000, 83300000, 83300~
$ TPC               <dbl> 1.009716, 1.009716, 1.009716, 1.009716, 1.009716, 1.009716, 1.009716, 1.009~
$ Energy            <fct> 240, 230, 220, 210, 200, 190, 180, 170, 160, 150, 140, 130, 120, 110, 100, ~
$ R1                <dbl> 6.689, 6.678, 6.667, 6.656, 6.650, 6.642, 6.635, 6.636, 6.650, 6.668, 6.707~
$ R2                <dbl> 6.701, 6.680, 6.682, 6.664, 6.653, 6.647, 6.638, 6.641, 6.657, 6.665, 6.706~
$ R3                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ R4                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ R5                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ Avg               <dbl> 6.695, 6.679, 6.675, 6.660, 6.652, 6.645, 6.637, 6.639, 6.654, 6.667, 6.707~
$ range             <dbl> 0.18, 0.03, 0.22, 0.12, 0.05, 0.08, 0.05, 0.08, 0.11, 0.05, 0.01, 0.15, 0.0~
$ Gy                <dbl> 0.6219, 0.6204, 0.6200, 0.6187, 0.6179, 0.6172, 0.6165, 0.6167, 0.6180, 0.6~
$ Diff              <dbl> 0.1909, 0.2193, 0.3610, 0.3802, 0.3937, 0.4246, 0.3332, 0.2844, 0.4252, 0.4~
$ Comments          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "AT~
> prep_g1 = first_col(OutputG1raw,as.factor(1),var="Gantry")
> prep_g2 = first_col(OutputG2raw,as.factor(1),var="Gantry")
> prep_g3 = first_col(OutputG3raw,as.factor(1),var="Gantry")
> prep_g4 = first_col(OutputG4raw,as.factor(1),var="Gantry")
> 
> prep_g1 = first_col(OutputG1raw,as.factor(1),var="Gantry")
> prep_g2 = first_col(OutputG2raw,as.factor(2),var="Gantry")
> prep_g3 = first_col(OutputG3raw,as.factor(3),var="Gantry")
> prep_g4 = first_col(OutputG4raw,as.factor(4),var="Gantry")
> 
> prepAllG = bind_rows(prep_g1,prep_g2,prep_g3,prep_g4)
> 
> glimpse(prepAllG)
Rows: 7,380
Columns: 23
$ Gantry            <fct> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ~
$ MeasuredBy        <chr> "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG~
$ Date              <date> 2023-01-02, 2023-01-02, 2023-01-02, 2023-01-02, 2023-01-02, 2023-01-02, 20~
$ ChamberSN         <fct> 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 313~
$ ElectrometerUsed  <fct> 92579, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
$ ElectrometerRange <fct> Medium, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ TdegC             <dbl> 23.9, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 2~
$ PhPa              <dbl> 1018.9, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ GA                <fct> 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, ~
$ V1                <fct> -200, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, -~
$ NDW               <dbl> 83700000, 83700000, 83700000, 83700000, 83700000, 83700000, 83700000, 83700~
$ TPC               <dbl> 1.007685, 1.007685, 1.007685, 1.007685, 1.007685, 1.007685, 1.007685, 1.007~
$ Energy            <fct> 240, 230, 220, 210, 200, 190, 180, 170, 160, 150, 140, 130, 120, 110, 100, ~
$ R1                <dbl> 6.645, 6.627, 6.616, 6.608, 6.596, 6.584, 6.578, 6.593, 6.600, 6.615, 6.647~
$ R2                <dbl> 6.638, 6.627, 6.619, 6.598, 6.594, 6.589, 6.584, 6.588, 6.600, 6.619, 6.639~
$ R3                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ R4                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ R5                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ Avg               <dbl> 6.642, 6.627, 6.618, 6.603, 6.595, 6.587, 6.581, 6.591, 6.600, 6.617, 6.643~
$ range             <dbl> 0.11, 0.00, 0.05, 0.15, 0.03, 0.08, 0.09, 0.08, 0.00, 0.06, 0.12, 0.04, 0.0~
$ Gy                <dbl> 0.6186, 0.6173, 0.6164, 0.6151, 0.6143, 0.6135, 0.6130, 0.6139, 0.6148, 0.6~
$ Diff              <dbl> -0.3334, -0.2845, -0.2194, -0.2022, -0.1823, -0.1752, -0.2292, -0.1639, -0.~
$ Comments          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
> which(duplicated(prepAllG))
[1] 4423
> glimpse(prepAllG[4423,])
Rows: 1
Columns: 23
$ Gantry            <fct> 3
$ MeasuredBy        <chr> "SC"
$ Date              <date> 2022-09-19
$ ChamberSN         <fct> 3131
$ ElectrometerUsed  <fct> NA
$ ElectrometerRange <fct> NA
$ TdegC             <dbl> NA
$ PhPa              <dbl> NA
$ GA                <fct> 180
$ V1                <fct> NA
$ NDW               <dbl> 83300000
$ TPC               <dbl> 1.003461
$ Energy            <fct> 120
$ R1                <dbl> 6.872
$ R2                <dbl> NA
$ R3                <dbl> NA
$ R4                <dbl> NA
$ R5                <dbl> NA
$ Avg               <dbl> 6.872
$ range             <dbl> 0
$ Gy                <dbl> 0.6344
$ Diff              <dbl> 0.3732
$ Comments          <chr> NA
> glimpse(prepAllG[4404,])
Rows: 1
Columns: 23
$ Gantry            <fct> 3
$ MeasuredBy        <chr> "SC"
$ Date              <date> 2022-09-19
$ ChamberSN         <fct> 3131
$ ElectrometerUsed  <fct> NA
$ ElectrometerRange <fct> NA
$ TdegC             <dbl> NA
$ PhPa              <dbl> NA
$ GA                <fct> 180
$ V1                <fct> NA
$ NDW               <dbl> 83300000
$ TPC               <dbl> 1.003461
$ Energy            <fct> 130
$ R1                <dbl> 6.798
$ R2                <dbl> NA
$ R3                <dbl> NA
$ R4                <dbl> NA
$ R5                <dbl> NA
$ Avg               <dbl> 6.798
$ range             <dbl> 0
$ Gy                <dbl> 0.6276
$ Diff              <dbl> 0.3691
$ Comments          <chr> NA
> glimpse(prepAllG[4423,])
Rows: 1
Columns: 23
$ Gantry            <fct> 3
$ MeasuredBy        <chr> "SC"
$ Date              <date> 2022-09-19
$ ChamberSN         <fct> 3131
$ ElectrometerUsed  <fct> NA
$ ElectrometerRange <fct> NA
$ TdegC             <dbl> NA
$ PhPa              <dbl> NA
$ GA                <fct> 180
$ V1                <fct> NA
$ NDW               <dbl> 83300000
$ TPC               <dbl> 1.003461
$ Energy            <fct> 120
$ R1                <dbl> 6.872
$ R2                <dbl> NA
$ R3                <dbl> NA
$ R4                <dbl> NA
$ R5                <dbl> NA
$ Avg               <dbl> 6.872
$ range             <dbl> 0
$ Gy                <dbl> 0.6344
$ Diff              <dbl> 0.3732
$ Comments          <chr> NA
> glimpse(prepAllG[4405,])
Rows: 1
Columns: 23
$ Gantry            <fct> 3
$ MeasuredBy        <chr> "SC"
$ Date              <date> 2022-09-19
$ ChamberSN         <fct> 3131
$ ElectrometerUsed  <fct> NA
$ ElectrometerRange <fct> NA
$ TdegC             <dbl> NA
$ PhPa              <dbl> NA
$ GA                <fct> 180
$ V1                <fct> NA
$ NDW               <dbl> 83300000
$ TPC               <dbl> 1.003461
$ Energy            <fct> 120
$ R1                <dbl> 6.872
$ R2                <dbl> NA
$ R3                <dbl> NA
$ R4                <dbl> NA
$ R5                <dbl> NA
$ Avg               <dbl> 6.872
$ range             <dbl> 0
$ Gy                <dbl> 0.6344
$ Diff              <dbl> 0.3732
$ Comments          <chr> NA
> glimpse(prepAllG[4423,])
Rows: 1
Columns: 23
$ Gantry            <fct> 3
$ MeasuredBy        <chr> "SC"
$ Date              <date> 2022-09-19
$ ChamberSN         <fct> 3131
$ ElectrometerUsed  <fct> NA
$ ElectrometerRange <fct> NA
$ TdegC             <dbl> NA
$ PhPa              <dbl> NA
$ GA                <fct> 180
$ V1                <fct> NA
$ NDW               <dbl> 83300000
$ TPC               <dbl> 1.003461
$ Energy            <fct> 120
$ R1                <dbl> 6.872
$ R2                <dbl> NA
$ R3                <dbl> NA
$ R4                <dbl> NA
$ R5                <dbl> NA
$ Avg               <dbl> 6.872
$ range             <dbl> 0
$ Gy                <dbl> 0.6344
$ Diff              <dbl> 0.3732
$ Comments          <chr> NA
>  == glimpse(prepAllG[4405,])
Error: unexpected '==' in " =="
> glimpse(prepAllG[4423,]) +
+  == glimpse(prepAllG[4405,])
Error: unexpected '==' in:
"glimpse(prepAllG[4423,]) +
 =="
> glimpse(prepAllG[4423,]) == glimpse(prepAllG[4405,])
Rows: 1
Columns: 23
$ Gantry            <fct> 3
$ MeasuredBy        <chr> "SC"
$ Date              <date> 2022-09-19
$ ChamberSN         <fct> 3131
$ ElectrometerUsed  <fct> NA
$ ElectrometerRange <fct> NA
$ TdegC             <dbl> NA
$ PhPa              <dbl> NA
$ GA                <fct> 180
$ V1                <fct> NA
$ NDW               <dbl> 83300000
$ TPC               <dbl> 1.003461
$ Energy            <fct> 120
$ R1                <dbl> 6.872
$ R2                <dbl> NA
$ R3                <dbl> NA
$ R4                <dbl> NA
$ R5                <dbl> NA
$ Avg               <dbl> 6.872
$ range             <dbl> 0
$ Gy                <dbl> 0.6344
$ Diff              <dbl> 0.3732
$ Comments          <chr> NA
Rows: 1
Columns: 23
$ Gantry            <fct> 3
$ MeasuredBy        <chr> "SC"
$ Date              <date> 2022-09-19
$ ChamberSN         <fct> 3131
$ ElectrometerUsed  <fct> NA
$ ElectrometerRange <fct> NA
$ TdegC             <dbl> NA
$ PhPa              <dbl> NA
$ GA                <fct> 180
$ V1                <fct> NA
$ NDW               <dbl> 83300000
$ TPC               <dbl> 1.003461
$ Energy            <fct> 120
$ R1                <dbl> 6.872
$ R2                <dbl> NA
$ R3                <dbl> NA
$ R4                <dbl> NA
$ R5                <dbl> NA
$ Avg               <dbl> 6.872
$ range             <dbl> 0
$ Gy                <dbl> 0.6344
$ Diff              <dbl> 0.3732
$ Comments          <chr> NA
     Gantry MeasuredBy Date ChamberSN ElectrometerUsed ElectrometerRange TdegC PhPa   GA V1  NDW  TPC
[1,]   TRUE       TRUE TRUE      TRUE               NA                NA    NA   NA TRUE NA TRUE TRUE
     Energy   R1 R2 R3 R4 R5  Avg range   Gy Diff Comments
[1,]   TRUE TRUE NA NA NA NA TRUE  TRUE TRUE TRUE       NA
> write_excel_csv( prepAllG, "Rreview/OutputGallxl3.csv", na = "NA", append = FALSE, col_names = TRUE, delim = ",", quote = "none", escape = c("double", "backslash", "none"), eol = "\n", num_threads = readr_threads(), progress = show_progress() )
Error: Cannot open file for writing:
* 'C:/Users/alemoore/Documents/DoseCons/OutputConsistency/Rreview/Rreview/OutputGallxl3.csv'
> write_excel_csv( prepAllG, "OutputGallxl3.csv", na = "NA", append = FALSE, col_names = TRUE, delim = ",", quote = "none", escape = c("double", "backslash", "none"), eol = "\n", num_threads = readr_threads(), progress = show_progress() )
                                                                                                     
> 
> install.packages("tidymodels")
WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:

https://cran.rstudio.com/bin/windows/Rtools/
Installing package into ‘C:/Users/alemoore/AppData/Local/R/win-library/4.2’
(as ‘lib’ is unspecified)
also installing the dependencies ‘conflicted’, ‘infer’, ‘modeldata’, ‘workflowsets’

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/conflicted_1.1.0.zip'
Content type 'application/zip' length 50430 bytes (49 KB)
downloaded 49 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/infer_1.0.4.zip'
Content type 'application/zip' length 2241003 bytes (2.1 MB)
downloaded 2.1 MB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/modeldata_1.0.1.zip'
Content type 'application/zip' length 4243443 bytes (4.0 MB)
downloaded 4.0 MB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/workflowsets_1.0.0.zip'
Content type 'application/zip' length 2799236 bytes (2.7 MB)
downloaded 2.7 MB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/tidymodels_1.0.0.zip'
Content type 'application/zip' length 116811 bytes (114 KB)
downloaded 114 KB

package ‘conflicted’ successfully unpacked and MD5 sums checked
package ‘infer’ successfully unpacked and MD5 sums checked
package ‘modeldata’ successfully unpacked and MD5 sums checked
package ‘workflowsets’ successfully unpacked and MD5 sums checked
package ‘tidymodels’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\alemoore\AppData\Local\Temp\RtmpuaWmel\downloaded_packages
> library(tidymodels)
-- Attaching packages ------------------------------------------------------------- tidymodels 1.0.0 --
v broom        1.0.2     v rsample      1.1.1
v dials        1.1.0     v tune         1.0.1
v infer        1.0.4     v workflows    1.1.2
v modeldata    1.0.1     v workflowsets 1.0.0
v parsnip      1.0.3     v yardstick    1.1.0
v recipes      1.0.3     
-- Conflicts ---------------------------------------------------------------- tidymodels_conflicts() --
x scales::discard() masks purrr::discard()
x dplyr::filter()   masks stats::filter()
x recipes::fixed()  masks stringr::fixed()
x dplyr::lag()      masks stats::lag()
x yardstick::spec() masks readr::spec()
x recipes::step()   masks stats::step()
* Use tidymodels_prefer() to resolve common conflicts.
> tidymodels_prefer()
> glimpse(prepAllG)
Rows: 7,380
Columns: 23
$ Gantry            <fct> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ~
$ MeasuredBy        <chr> "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG", "AG~
$ Date              <date> 2023-01-02, 2023-01-02, 2023-01-02, 2023-01-02, 2023-01-02, 2023-01-02, 20~
$ ChamberSN         <fct> 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 3132, 313~
$ ElectrometerUsed  <fct> 92579, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
$ ElectrometerRange <fct> Medium, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ TdegC             <dbl> 23.9, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 2~
$ PhPa              <dbl> 1018.9, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ GA                <fct> 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, 270, ~
$ V1                <fct> -200, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, -~
$ NDW               <dbl> 83700000, 83700000, 83700000, 83700000, 83700000, 83700000, 83700000, 83700~
$ TPC               <dbl> 1.007685, 1.007685, 1.007685, 1.007685, 1.007685, 1.007685, 1.007685, 1.007~
$ Energy            <fct> 240, 230, 220, 210, 200, 190, 180, 170, 160, 150, 140, 130, 120, 110, 100, ~
$ R1                <dbl> 6.645, 6.627, 6.616, 6.608, 6.596, 6.584, 6.578, 6.593, 6.600, 6.615, 6.647~
$ R2                <dbl> 6.638, 6.627, 6.619, 6.598, 6.594, 6.589, 6.584, 6.588, 6.600, 6.619, 6.639~
$ R3                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ R4                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ R5                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ Avg               <dbl> 6.642, 6.627, 6.618, 6.603, 6.595, 6.587, 6.581, 6.591, 6.600, 6.617, 6.643~
$ range             <dbl> 0.11, 0.00, 0.05, 0.15, 0.03, 0.08, 0.09, 0.08, 0.00, 0.06, 0.12, 0.04, 0.0~
$ Gy                <dbl> 0.6186, 0.6173, 0.6164, 0.6151, 0.6143, 0.6135, 0.6130, 0.6139, 0.6148, 0.6~
$ Diff              <dbl> -0.3334, -0.2845, -0.2194, -0.2022, -0.1823, -0.1752, -0.2292, -0.1639, -0.~
$ Comments          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
> ggplot
function (data = NULL, mapping = aes(), ..., environment = parent.frame()) 
{
    UseMethod("ggplot")
}
<bytecode: 0x000001f7d32ad010>
<environment: namespace:ggplot2>
> ggplot2
Error: object 'ggplot2' not found
> ggplot2
Error: object 'ggplot2' not found
> prepAllG %>% ggplot(aes(Gy,Date))
> prepAllG %>% ggplot(aes(Gy,Date)) +
+   geom_line(col = palette_light()[1]) +
+   geom_point(col = palette_light()[1])
Error in palette_light() : could not find function "palette_light"
> install.packages("tidyquant")
WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:

https://cran.rstudio.com/bin/windows/Rtools/
Installing package into ‘C:/Users/alemoore/AppData/Local/R/win-library/4.2’
(as ‘lib’ is unspecified)
also installing the dependencies ‘PerformanceAnalytics’, ‘riingo’, ‘alphavantager’

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/PerformanceAnalytics_2.0.4.zip'
Content type 'application/zip' length 3118171 bytes (3.0 MB)
downloaded 3.0 MB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/riingo_0.3.1.zip'
Content type 'application/zip' length 120688 bytes (117 KB)
downloaded 117 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/alphavantager_0.1.2.zip'
Content type 'application/zip' length 22961 bytes (22 KB)
downloaded 22 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/tidyquant_1.0.6.zip'
Content type 'application/zip' length 3741638 bytes (3.6 MB)
downloaded 3.6 MB

package ‘PerformanceAnalytics’ successfully unpacked and MD5 sums checked
package ‘riingo’ successfully unpacked and MD5 sums checked
package ‘alphavantager’ successfully unpacked and MD5 sums checked
package ‘tidyquant’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\alemoore\AppData\Local\Temp\RtmpuaWmel\downloaded_packages
> library(tidyquant)
Loading required package: lubridate
Loading required package: timechange

Attaching package: ‘lubridate’

The following objects are masked from ‘package:base’:

    date, intersect, setdiff, union

Loading required package: PerformanceAnalytics
Loading required package: xts
Loading required package: zoo

Attaching package: ‘zoo’

The following objects are masked from ‘package:base’:

    as.Date, as.Date.numeric


Attaching package: ‘xts’

The following objects are masked from ‘package:dplyr’:

    first, last


Attaching package: ‘PerformanceAnalytics’

The following object is masked from ‘package:graphics’:

    legend

Loading required package: quantmod
Loading required package: TTR

Attaching package: ‘TTR’

The following object is masked from ‘package:dials’:

    momentum

Registered S3 method overwritten by 'quantmod':
  method            from
  as.zoo.data.frame zoo 
> prepAllG %>% ggplot(aes(Gy,Date)) +
+   geom_line(col = palette_light()[1]) +
+   geom_point(col = palette_light()[1])
Warning messages:
1: Removed 280 rows containing missing values (`geom_line()`). 
2: Removed 280 rows containing missing values (`geom_point()`). 
> prepAllG[,"Energy==100"] %>% ggplot(aes(Gy,Date)) +
+   geom_line(col = palette_light()[1]) +
+   geom_point(col = palette_light()[1])
Error in `prepAllG[, "Energy==100"]`:
! Can't subset columns that don't exist.
x Column `Energy==100` doesn't exist.
Run `rlang::last_error()` to see where the error occurred.
> rlang::last_error()
<error/vctrs_error_subscript_oob>
Error in `prepAllG[, "Energy==100"]`:
! Can't subset columns that don't exist.
x Column `Energy==100` doesn't exist.
---
Backtrace:
 1. prepAllG[, "Energy==100"] %>% ggplot(aes(Gy, Date))
 4. tibble:::`[.tbl_df`(prepAllG, , "Energy==100")
Run `rlang::last_trace()` to see the full context.
> devtools::install_github("business-science/tibbletime")
Error in loadNamespace(x) : there is no package called ‘devtools’
> install.packages("devtools")
WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:

https://cran.rstudio.com/bin/windows/Rtools/
Installing package into ‘C:/Users/alemoore/AppData/Local/R/win-library/4.2’
(as ‘lib’ is unspecified)
also installing the dependencies ‘credentials’, ‘gitcreds’, ‘ini’, ‘systemfonts’, ‘textshaping’, ‘gert’, ‘gh’, ‘downlit’, ‘ragg’, ‘xopen’, ‘usethis’, ‘pkgdown’, ‘profvis’, ‘rcmdcheck’, ‘rversions’, ‘sessioninfo’, ‘urlchecker’


  There is a binary version available but the source version is later:
     binary source needs_compilation
ragg  1.2.4  1.2.5              TRUE

  Binaries will be installed
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/credentials_1.3.2.zip'
Content type 'application/zip' length 174040 bytes (169 KB)
downloaded 169 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/gitcreds_0.1.2.zip'
Content type 'application/zip' length 99447 bytes (97 KB)
downloaded 97 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/ini_0.3.1.zip'
Content type 'application/zip' length 15801 bytes (15 KB)
downloaded 15 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/systemfonts_1.0.4.zip'
Content type 'application/zip' length 1042740 bytes (1018 KB)
downloaded 1018 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/textshaping_0.3.6.zip'
Content type 'application/zip' length 1021257 bytes (997 KB)
downloaded 997 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/gert_1.9.2.zip'
Content type 'application/zip' length 2714345 bytes (2.6 MB)
downloaded 2.6 MB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/gh_1.3.1.zip'
Content type 'application/zip' length 97804 bytes (95 KB)
downloaded 95 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/downlit_0.4.2.zip'
Content type 'application/zip' length 113537 bytes (110 KB)
downloaded 110 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/ragg_1.2.4.zip'
Content type 'application/zip' length 1299228 bytes (1.2 MB)
downloaded 1.2 MB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/xopen_1.0.0.zip'
Content type 'application/zip' length 24824 bytes (24 KB)
downloaded 24 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/usethis_2.1.6.zip'
Content type 'application/zip' length 818199 bytes (799 KB)
downloaded 799 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/pkgdown_2.0.7.zip'
Content type 'application/zip' length 800689 bytes (781 KB)
downloaded 781 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/profvis_0.3.7.zip'
Content type 'application/zip' length 186189 bytes (181 KB)
downloaded 181 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/rcmdcheck_1.4.0.zip'
Content type 'application/zip' length 170735 bytes (166 KB)
downloaded 166 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/rversions_2.1.2.zip'
Content type 'application/zip' length 67342 bytes (65 KB)
downloaded 65 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/sessioninfo_1.2.2.zip'
Content type 'application/zip' length 186163 bytes (181 KB)
downloaded 181 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/urlchecker_1.0.1.zip'
Content type 'application/zip' length 36295 bytes (35 KB)
downloaded 35 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/devtools_2.4.5.zip'
Content type 'application/zip' length 429169 bytes (419 KB)
downloaded 419 KB

package ‘credentials’ successfully unpacked and MD5 sums checked
package ‘gitcreds’ successfully unpacked and MD5 sums checked
package ‘ini’ successfully unpacked and MD5 sums checked
package ‘systemfonts’ successfully unpacked and MD5 sums checked
package ‘textshaping’ successfully unpacked and MD5 sums checked
package ‘gert’ successfully unpacked and MD5 sums checked
package ‘gh’ successfully unpacked and MD5 sums checked
package ‘downlit’ successfully unpacked and MD5 sums checked
package ‘ragg’ successfully unpacked and MD5 sums checked
package ‘xopen’ successfully unpacked and MD5 sums checked
package ‘usethis’ successfully unpacked and MD5 sums checked
package ‘pkgdown’ successfully unpacked and MD5 sums checked
package ‘profvis’ successfully unpacked and MD5 sums checked
package ‘rcmdcheck’ successfully unpacked and MD5 sums checked
package ‘rversions’ successfully unpacked and MD5 sums checked
package ‘sessioninfo’ successfully unpacked and MD5 sums checked
package ‘urlchecker’ successfully unpacked and MD5 sums checked
package ‘devtools’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\alemoore\AppData\Local\Temp\RtmpuaWmel\downloaded_packages
> devtools::install_github("business-science/tibbletime")
WARNING: Rtools is required to build R packages, but is not currently installed.

Please download and install Rtools 4.2 from https://cran.r-project.org/bin/windows/Rtools/ or https://www.r-project.org/nosvn/winutf8/ucrt3/.
Downloading GitHub repo business-science/tibbletime@HEAD
WARNING: Rtools is required to build R packages, but is not currently installed.

Please download and install Rtools 4.2 from https://cran.r-project.org/bin/windows/Rtools/ or https://www.r-project.org/nosvn/winutf8/ucrt3/.
WARNING: Rtools is required to build R packages, but is not currently installed.

Please download and install Rtools 4.2 from https://cran.r-project.org/bin/windows/Rtools/ or https://www.r-project.org/nosvn/winutf8/ucrt3/.
trying URL 'https://cran.rstudio.com/bin/windows/Rtools/rtools42/files/rtools42-5355-5357.exe'
Content type 'application/x-msdownload' length 482123824 bytes (459.8 MB)
downloaded 459.8 MB

Error: Failed to install 'tibbletime' from GitHub:
  Could not find tools necessary to compile a package
Call `pkgbuild::check_build_tools(debug = TRUE)` to diagnose the problem.
> devtools::install_github("business-science/tibbletime")
Downloading GitHub repo business-science/tibbletime@HEAD
These packages have more recent versions available.
It is recommended to update all of them.
Which would you like to update?

1: All                               
2: CRAN packages only                
3: None                              
4: cli        (3.5.0 -> 3.6.0) [CRAN]
5: timechange (0.1.1 -> 0.2.0) [CRAN]
6: purrr      (1.0.0 -> 1.0.1) [CRAN]

Enter one or more numbers, or an empty line to skip updates: 1
cli        (3.5.0 -> 3.6.0) [CRAN]
timechange (0.1.1 -> 0.2.0) [CRAN]
purrr      (1.0.0 -> 1.0.1) [CRAN]
Installing 3 packages: cli, timechange, purrr
Warning: packages ‘timechange’, ‘purrr’ are in use and will not be installed
Installing package into ‘C:/Users/alemoore/AppData/Local/R/win-library/4.2’
(as ‘lib’ is unspecified)
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/cli_3.6.0.zip'
Content type 'application/zip' length 1299125 bytes (1.2 MB)
downloaded 1.2 MB

package ‘cli’ successfully unpacked and MD5 sums checked
Warning: cannot remove prior installation of package ‘cli’
Warning: restored ‘cli’

The downloaded binary packages are in
	C:\Users\alemoore\AppData\Local\Temp\RtmpuaWmel\downloaded_packages
-- R CMD build ------------------------------------------------------------------------
v  checking for file 'C:\Users\alemoore\AppData\Local\Temp\RtmpuaWmel\remotes5ed430125ab9\business-science-tibbletime-482002a/DESCRIPTION' (390ms)
-  preparing 'tibbletime':
v  checking DESCRIPTION meta-information ... 
-  cleaning src
-  checking for LF line-endings in source and make files and shell scripts
-  checking for empty or unneeded directories
-  building 'tibbletime_0.1.7.9000.tar.gz'
   
Installing package into ‘C:/Users/alemoore/AppData/Local/R/win-library/4.2’
(as ‘lib’ is unspecified)
* installing *source* package 'tibbletime' ...
** using staged installation
** libs
g++ -std=gnu++11  -I"C:/PROGRA~1/R/R-42~1.2/include" -DNDEBUG  -I'C:/Users/alemoore/AppData/Local/R/win-library/4.2/Rcpp/include'   -I"c:/rtools42/x86_64-w64-mingw32.static.posix/include"  -I../inst/include   -O2 -Wall  -mfpmath=sse -msse2 -mstackrealign  -c RcppExports.cpp -o RcppExports.o
/bin/sh: line 1: g++: command not found
make: *** [C:/PROGRA~1/R/R-42~1.2/etc/x64/Makeconf:260: RcppExports.o] Error 127
ERROR: compilation failed for package 'tibbletime'
* removing 'C:/Users/alemoore/AppData/Local/R/win-library/4.2/tibbletime'
Warning messages:
1: In file.copy(savedcopy, lib, recursive = TRUE) :
  problem copying C:\Users\alemoore\AppData\Local\R\win-library\4.2\00LOCK\cli\libs\x64\cli.dll to C:\Users\alemoore\AppData\Local\R\win-library\4.2\cli\libs\x64\cli.dll: Permission denied
2: In i.p(...) :
  installation of package ‘C:/Users/alemoore/AppData/Local/Temp/RtmpuaWmel/file5ed463a23574/tibbletime_0.1.7.9000.tar.gz’ had non-zero exit status
> devtools::install_github("business-science/tibbletime")
Downloading GitHub repo business-science/tibbletime@HEAD
These packages have more recent versions available.
It is recommended to update all of them.
Which would you like to update?

1: All                               
2: CRAN packages only                
3: None                              
4: cli        (3.5.0 -> 3.6.0) [CRAN]
5: timechange (0.1.1 -> 0.2.0) [CRAN]
6: purrr      (1.0.0 -> 1.0.1) [CRAN]

Enter one or more numbers, or an empty line to skip updates: 5 6
timechange (0.1.1 -> 0.2.0) [CRAN]
purrr      (1.0.0 -> 1.0.1) [CRAN]
Installing 2 packages: timechange, purrr
Warning: packages ‘timechange’, ‘purrr’ are in use and will not be installed
-- R CMD build ------------------------------------------------------------------------
v  checking for file 'C:\Users\alemoore\AppData\Local\Temp\RtmpuaWmel\remotes5ed4571b7b87\business-science-tibbletime-482002a/DESCRIPTION' (452ms)
-  preparing 'tibbletime':
v  checking DESCRIPTION meta-information ... 
-  cleaning src
-  checking for LF line-endings in source and make files and shell scripts
-  checking for empty or unneeded directories
-  building 'tibbletime_0.1.7.9000.tar.gz'
   
Installing package into ‘C:/Users/alemoore/AppData/Local/R/win-library/4.2’
(as ‘lib’ is unspecified)
* installing *source* package 'tibbletime' ...
** using staged installation
** libs
g++ -std=gnu++11  -I"C:/PROGRA~1/R/R-42~1.2/include" -DNDEBUG  -I'C:/Users/alemoore/AppData/Local/R/win-library/4.2/Rcpp/include'   -I"c:/rtools42/x86_64-w64-mingw32.static.posix/include"  -I../inst/include   -O2 -Wall  -mfpmath=sse -msse2 -mstackrealign  -c RcppExports.cpp -o RcppExports.o
/bin/sh: line 1: g++: command not found
make: *** [C:/PROGRA~1/R/R-42~1.2/etc/x64/Makeconf:260: RcppExports.o] Error 127
ERROR: compilation failed for package 'tibbletime'
* removing 'C:/Users/alemoore/AppData/Local/R/win-library/4.2/tibbletime'
Warning message:
In i.p(...) :
  installation of package ‘C:/Users/alemoore/AppData/Local/Temp/RtmpuaWmel/file5ed45b8c3b11/tibbletime_0.1.7.9000.tar.gz’ had non-zero exit status
> prepAllG %>%  select(Energy==70) + ggplot(aes(Gy,Date)) +
+   geom_line(col = palette_light()[1]) +
+   geom_point(col = palette_light()[1])
Error in `select()`:
! Problem while evaluating `Energy == 70`.
Run `rlang::last_error()` to see where the error occurred.
> rlang::last_error()
<error/rlang_error>
Error in `select()`:
! Problem while evaluating `Energy == 70`.
---
Backtrace:
  1. prepAllG %>% select(Energy == 70)
  3. dplyr:::select.data.frame(., Energy == 70)
  6. tidyselect::eval_select(expr(c(...)), .data)
  7. tidyselect:::eval_select_impl(...)
 11. tidyselect:::vars_select_eval(...)
 12. tidyselect:::walk_data_tree(expr, data_mask, context_mask)
 13. tidyselect:::eval_c(expr, data_mask, context_mask)
 14. tidyselect:::reduce_sels(node, data_mask, context_mask, init = init)
 15. tidyselect:::walk_data_tree(new, data_mask, context_mask)
 16. tidyselect:::eval_context(expr, context_mask, call = error_call)
 24. rlang::eval_tidy(as_quosure(expr, env), context_mask)
Run `rlang::last_trace()` to see the full context.
> filter(prepAllG$Gy, Energy=="70")
Error in UseMethod("filter") : 
  no applicable method for 'filter' applied to an object of class "c('double', 'numeric')"
> filter(prepAllG, Energy=="70")
# A tibble: 410 x 23
   Gantry MeasuredBy Date       Chambe~1 Elect~2 Elect~3 TdegC  PhPa GA    V1       NDW
   <fct>  <chr>      <date>     <fct>    <fct>   <fct>   <dbl> <dbl> <fct> <fct>  <dbl>
 1 1      AG         2023-01-02 3132     NA      NA         NA    NA 270   NA    8.37e7
 2 1      AG         2023-01-02 3132     NA      NA         NA    NA 90    NA    8.37e7
 3 1      AG         2023-01-02 3132     NA      NA         NA    NA 180   NA    8.37e7
 4 1      AG         2023-01-02 3132     NA      NA         NA    NA 0     NA    8.37e7
 5 1      Agr        2022-12-06 3128     NA      NA         NA    NA 90    NA    8.36e7
 6 1      AGr        2022-12-06 3128     NA      NA         NA    NA 180   NA    8.36e7
 7 1      VR         2022-12-06 3128     NA      NA         NA    NA 180   NA    8.36e7
 8 1      VR         2022-12-06 3128     NA      NA         NA    NA 270   NA    8.36e7
 9 1      VR         2022-12-06 3128     NA      NA         NA    NA 0     NA    8.36e7
10 1      TNC        2022-11-08 3132     NA      NA         NA    NA 180   NA    8.37e7
# ... with 400 more rows, 12 more variables: TPC <dbl>, Energy <fct>, R1 <dbl>,
#   R2 <dbl>, R3 <dbl>, R4 <dbl>, R5 <dbl>, Avg <dbl>, range <dbl>, Gy <dbl>,
#   Diff <dbl>, Comments <chr>, and abbreviated variable names 1: ChamberSN,
#   2: ElectrometerUsed, 3: ElectrometerRange
# i Use `print(n = ...)` to see more rows, and `colnames()` to see all variable names
> prepAllG %>%  filter(prepAllG, Energy=="70") + ggplot(aes(Gy,Date)) +
+   geom_line(col = palette_light()[1]) +
+   geom_point(col = palette_light()[1])
Error in `filter()`:
! Problem while computing `..1 = prepAllG`.
x Input `..1$Gantry` must be a logical vector, not a factor<f1f23>.
Run `rlang::last_error()` to see where the error occurred.
> prepAllG %>%  filter(prepAllG, Energy==70) + ggplot(aes(Gy,Date)) +
+   geom_line(col = palette_light()[1]) +
+   geom_point(col = palette_light()[1])
Error in `filter()`:
! Problem while computing `..1 = prepAllG`.
x Input `..1$Gantry` must be a logical vector, not a factor<f1f23>.
Run `rlang::last_error()` to see where the error occurred.