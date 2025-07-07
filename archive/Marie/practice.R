library(dplyr)
library(officer)
library(glue)
library(haven)


# Date parameters ----
tdy_month     <- lubridate::month(Sys.Date(), label = TRUE, abbr = TRUE)
tdy_month_num <- sprintf("%02d", lubridate::month(Sys.Date()))
tdy_yr        <- lubridate::year(Sys.Date())

frz_dt <- glue("{tdy_yr}-{tdy_month_num}-01")

# Use lubridate to extract  year
frz_yr    <- lubridate::as_date(frz_dt) %>% lubridate::year(.)


# Set Directories ----
# Registry data should be imported directly from its source
sharepoint_dir <- "~/../../Corrona LLC"
sharepoint_nmo <- glue("{sharepoint_dir}/Biostat Data Files - NMO/monthly/{frz_yr}/{frz_dt}/Analytic Data")

read_dataset <- function(ds_name){

    base::readRDS(glue::glue("{sharepoint_nmo}/{ds_name}_{frz_dt}.rds"))

}

analysis_dataset <- read_dataset("exdrugexp")

summarize_dataset<- function(dataset){
  temp_summary_table<- base::summary(dataset)

  return(temp_summary_table)
}

analysis_dataset_summary <- summarize_dataset(analysis_dataset)


output_word_file <- function(summary_data, outp_folder_url){
  print(outp_folder_url)
  temp_doc <- officer::read_docx() |>
    officer::body_add_par("Summary Table", style = "heading 1") |>
    officer::body_add_table(as.data.frame(summary_data))

  print(temp_doc, target = glue::glue("{outp_folder_url}/summary_table.docx"))
}

output_word_file(analysis_dataset_summary, "./R/Marie")
