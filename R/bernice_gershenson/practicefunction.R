install.packages("dplyr")
install.packages("officer")
install.packages("glue")
library(dplyr)
library(officer)
library(glue)
library(haven)

#Step1- to see if basic function works.
read_dataset <- function() {
  print("read_dataset")
}

read_dataset()

#step2
read_dataset <- function(ds_url) {
  print(ds_url)
}
analysis_dataset=read_dataset("url")
analysis_dataset=read_dataset("dsmadma")


#step3

read_dataset <- function(ds_url) {
  print(ds_url)
  temp_ds= base::readRDS(ds_url)

  return(temp_ds)
}
analysis_dataset=read_dataset("C:/Users/bgershenson/Corrona LLC/Biostat Data Files - AD/monthly/2025/2025-01-03/exvisit_2025-01-03.rds")
analysis_dataset=read_dataset("C:/Users/bgershenson/Corrona LLC/Biostat Data Files - AD/monthly/2025/2025-01-03/exinstances_2025-01-03.rds")

#step4

summarize_dataset<- function(dataset){
  temp_summary_table<- base::summary(dataset)

  return(temp_summary_table)
}

summary_table=summarize_dataset(analysis_dataset)



###Summarize all the steps above.



