#------------------------------------------------------------------------------
# Program: function_to_test.R
# Date:    January 24, 2025
# Author:  Bernice Gershenson
# Purpose: Create function for Marie to test
#------------------------------------------------------------------------------

# load packages
library(tidyverse)
library(glue)
library(janitor)
library(lubridate)
library(haven)

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
ad_visits <- base::readRDS(glue("{sharepoint_ad}/exvisit_{frz_dt}.rds"))
#view(ad_visits)

str(ad_visits$height_ft)
str(ad_visits$age)


#' Calculate Correlation Between Two Variables
#'
#' This function calculates the correlation between two columns in a given data frame.
#'
#' @param data A data frame containing the variables to be analyzed.
#' @param var1 A column name in the data frame for the first variable.
#' @param var2 A column name in the data frame for the second variable.
#'
#' @return A numeric value representing the correlation between `var1` and `var2`.
#' @examples
#' # Sample usage:
#' calculate_correlation(ad_visits, height ft, age)
#'
#' @import dplyr
#' @export
calculate_correlation <- function(data, var1, var2) {
  # Load necessary library
  library(dplyr)

  # Calculate correlation
  correlation_result <- data %>%
    select({{ var1 }}, {{ var2 }}) %>%
    cor(use = "complete.obs")

  return(correlation_result)
}

# Test the function with a sample dataset (AD visits, height ft versus age)
result <- calculate_correlation(ad_visits, "height_ft", "age")
print(result)




