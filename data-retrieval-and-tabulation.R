library(tidyverse)
source("gsheetlinks.R")
f1_data <- googlesheets4::read_sheet(gsheetslink,
                                     sheet = "Sheet1")
write_tsv(f1_data,
          file = "f1-data.tsv")

rev(sort(table(f1_data$Swear_Words_Category)))
