prep_g1 = first_col(OutputG1raw,as.factor(1),var="Gantry")
write_excel_csv( prepAllG, "Rreview/OutputGallxl2.csv", na = "NA", append = FALSE, col_names = TRUE, delim = ",", quote = "none", escape = c("double", "backslash", "none"), eol = "\n", num_threads = readr_threads(), progress = show_progress() )


