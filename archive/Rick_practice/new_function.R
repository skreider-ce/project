library(dplyr)
library(officer)
library(glue)
library(haven)

#read datasets function
read_dataset <- function(ds_url){
  print(ds_url)
  temp_ds = base::readRDS(ds_url)
  
  return(temp_ds)
}

analysis_dataset = read_dataset("C:/Users/olsonr/Corrona LLC/Biostat Data Files - AD/monthly/2025/2025-01-03/exinstances_2025-01-03.rds")


#summarize dataset function
summarize_dataset<- function(dataset){
  temp_summary_table<- base::summary(dataset)
  
  return(temp_summary_table)
}

summary_table <- summarize_dataset(analysis_dataset)
