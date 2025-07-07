#-----------------------------------------------------------
# Program: practice_functions.R
# Author:  Yolanda Munoz Maldonado
# Date:    01/22/2025
# Purpose: Simple functions and best practices
#-----------------------------------------------------------

# loading libraries

install.packages("dplyr")
install.packages("officer")
install.packages("glue")

library(dplyr)
library(officer)
library(glue)


read_dataset <- function(ds_url){
  temp_ds = base::readRDS(ds_url)
  return(temp_ds)
}

visit_data <- read_dataset("C:/Users/munozmy/Corrona LLC/Biostat Data Files - Registry Data/AD/monthly/2025/2025-01-03/exvisit_2025-01-03.rds")
comor_data <- read_dataset("C:/Users/munozmy/Corrona LLC/Biostat Data Files - Registry Data/AD/monthly/2025/2025-01-03/excomorinf_2025-01-03.rds")

summarize_dataset<- function(dataset){
  temp_summary_table<- base::summary(dataset)
  return(temp_summary_table)
}

library(haven)
table1 = summarize_dataset(visit_data)



