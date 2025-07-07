library("dplyr")
library("officer")
library("glue")
library("haven")

read_dataset <- function(ds_url){
  print(ds_url)
  temp_ds <- readRDS(ds_url)
  return(temp_ds)
}

url <- "C:/Users/MelissaEliot/Corrona LLC/Biostat Data Files - Registry Data/AD/monthly/2025/2025-01-03/exvisit_2025-01-03.RDS"

AD_data <- read_dataset(url)

summarize_dataset<- function(dataset){
  temp_summary_table<- base::summary(dataset)

  return(temp_summary_table)
}

summary_table <- summarize_dataset(AD_data)
