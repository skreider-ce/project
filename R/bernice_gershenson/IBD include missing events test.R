#------------------------------------------------------------------------------
# Program: merge_ibd_include/exclude_events.R
# Date:    January 24, 2025
# Author:  Bernice Gershenson
# Purpose: Create function to generate event discrepancies between prior and current include/exclude lists for ASRs
#------------------------------------------------------------------------------

# load packages
library(tidyverse, warn.conflicts = FALSE) # Recommended packages for data manipulation
library(arsenal)                           # Recommended package for creating tables
library(tidycoRe)                          # Internal package for CorEvitas helper functions, styles, templates
library(lubridate)                         # Recommended package for manipulating dates
library(broom)                             # Recommended package for tidying regression model tables
library(glue)                              # Recommended package for concatenating strings
library(haven)  # Recommended package for importing datasets from SAS, STATA, others
library(janitor)
library(sjlabelled)
library(openxlsx)
library(officedown)
library(officer)
library(flextable)
library(knitr)
library(dplyr)
library("tidylog", warn.conflicts = FALSE)

# Date parameters --------------------------------------------------------
tdy_month     <- lubridate::month(Sys.Date(), label = TRUE, abbr = TRUE)
tdy_month_num <- sprintf("%02d", lubridate::month(Sys.Date()))
tdy_yr        <- lubridate::year(Sys.Date())

frz_dt <- glue("{tdy_yr}-{tdy_month_num}-03")

# Use lubridate to extract  year
frz_yr    <- lubridate::as_date(frz_dt) %>% lubridate::year(.)


# Set Directories ---------------------------------------------------------
# Registry data should be imported directly from its source
sharepoint_dir <- "~/../../Corrona LLC"
sharepoint_ad <- glue::glue("{sharepoint_dir}/Biostat Data Files - AD/monthly/{frz_yr}/{frz_dt}")

# load ibd visit data
ibd_prior <- base::readRDS(glue("{sharepoint_ad}/exvisit_{frz_dt}.rds"))
ibd_current <- base::readRDS(glue("{sharepoint_ad}/exvisit_{frz_dt}.rds"))
#view(ibd_current)


# Function: merge_ibd_events
# Purpose:  Merge IBD prior and current datasets, and generate an Excel file
#           with three sheets: Only Prior Events, Only New Events, and Merged Events.

# Parameters:
#   prior_data   - Data frame containing prior IBD events
#   current_data - Data frame containing current IBD events
#   id_col       - Character string specifying the unique identifier column
#   output_file  - Character string specifying the output Excel file path
#'
#Returns:
  #   Saves an Excel file with three sheets:
  #     1. "Only Prior Events" - Events found only in the prior dataset
  #     2. "Only New Events"   - Events found only in the current dataset
  #     3. "Merged Events"     - Events found in both datasets
  #
  # Example Usage:
  #   merge_ibd_events(prior_df, current_df, "EventID", "IBD_Events.xlsx")
  #
  # Dependencies:
  #   Requires dplyr, openxlsx, and tidyverse.

merge_ibd_events <- function(prior_file, current_file, sheet_name, id_cols, output_file = "IBD_Events.xlsx") {

  # Load necessary library
  library(dplyr)

  # Load datasets
  prior_data <- read_excel(prior_file, sheet = sheet_name)
  current_data <- read_excel(current_file, sheet = sheet_name)

  # Add flag columns
  prior_data$prior <- 1
  current_data$current <- 1

  # Filter for included events
  prior_data <- prior_data %>% filter(include == 1)
  current_data <- current_data %>% filter(include == 1)

  # Validate that ID columns exist in both datasets
  missing_cols <- setdiff(id_cols, colnames(prior_data))
  if (length(missing_cols) > 0) {
    stop(glue("Error: Columns {paste(missing_cols, collapse=', ')} not found in prior dataset."))
  }

  missing_cols <- setdiff(id_cols, colnames(current_data))
  if (length(missing_cols) > 0) {
    stop(glue("Error: Columns {paste(missing_cols, collapse=', ')} not found in current dataset."))
  }

  # Identify event categories
  only_prior <- anti_join(prior_data, current_data, by = id_cols)    # Events only in prior dataset
  only_new <- anti_join(current_data, prior_data, by = id_cols)      # Events only in current dataset
  merged_events <- inner_join(prior_data, current_data, by = id_cols, suffix = c("_prior", "_current")) # Events in both

  # Write results to an Excel file with three sheets
  write.xlsx(
    list(
      "Only Prior Events" = only_prior,
      "Only New Events" = only_new,
      "Merged Events" = merged_events
    ),
    file = output_file
  )

  message(glue("Excel file has been saved as: {output_file}"))
}

#------------------------------------------------------------------------------
# Example Test
#------------------------------------------------------------------------------
# Uncomment and modify paths as needed to test the function:
 merge_ibd_events(
   "C:/Users/bgershenson/Corrona LLC/Biostat Data Files - Biostat PV/IBD/_Pfizer/Tofacitinib PASS/PASS/ASR/Analysis/Folder Bernice/Include exclude code/folder/include_exclude_20240503.xlsx",
   "C:/Users/bgershenson/Corrona LLC/Biostat Data Files - Biostat PV/IBD/_Pfizer/Tofacitinib PASS/PASS/ASR/Analysis/Folder Bernice/Include exclude code/folder/include_exclude_20240802.xlsx",
   "all events",
   c("id", "eventdate", "eventtypespecify"),
   "IBD_Merged.xlsx")



