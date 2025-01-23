#------------------------------------------------------------------------------
# Program: function_to_test.R
# Date:    January 22, 2025
# Author:  Marie Gurrola
# Purpose: Create function for Bernice to test
#------------------------------------------------------------------------------
# load packages
library(tidyverse)
library(glue)

# Date parameters --------------------------------------------------------
tdy_month     <- lubridate::month(Sys.Date(), label = TRUE, abbr = TRUE)
tdy_month_num <- sprintf("%02d", lubridate::month(Sys.Date()))
tdy_yr        <- lubridate::year(Sys.Date())

frz_dt <- glue("{tdy_yr}-{tdy_month_num}-01")

# Use lubridate to extract  year
frz_yr    <- lubridate::as_date(frz_dt) %>% lubridate::year(.)


# Set Directories ---------------------------------------------------------
# Registry data should be imported directly from its source
sharepoint_dir <- "~/../../Corrona LLC"
sharepoint_ibd <- glue::glue("{sharepoint_dir}/Biostat Data Files - IBD/monthly/{frz_yr}/{frz_dt}/Analytic Data")


# Prepare data ------------------------------------------------------------


# load ibd visit data
ibd_visits <- base::readRDS(glue("{sharepoint_ibd}/IBD_Analytic_file_{frz_dt}.rds")) %>%
  # keep only UC and CD
  filter(dx_ibd %in% c(1, 5)) %>%
  mutate(
    # convert IBD diagnosis to factor
    dx_ibd = haven::as_factor(dx_ibd),
    # drop indeterminate colitis -- has 0 counts and not typically reported
    dx_ibd = forcats::fct_drop(dx_ibd)
  )

# create a function to produce counts across a vector of IBD visit variables stratified by ibd dx

#' Title Tabulate variables into a data frame
#'
#' @param df - data frame
#' @param variables - vector
#'
#' @return A data frame with counts for a vector
#' @export
#'
#' @examples
#'
count_function <- function(df,
                           variables){

  for(i in variables){

    # create a temp data frame to store results from within function environment
    # only create once; will be created for first var name in vector
    if(i == dplyr::first(ibd_variables)){temp_df <- data.frame()}


    temp <- df %>%
      # The !! is used to unquote an expression, and sym() is used to convert a
      # string into a symbol (which can then be used as a variable name or column name).
      janitor::tabyl(dx_ibd, !!sym(i)) %>%
      as.data.frame() %>%
      # create a new variable that stores variable that is being tabulated
      dplyr::mutate(var_name = i)

    # bind new results to temp_df
    temp_df <- temp_df %>%
      bind_rows(temp)
    }
  return(temp_df)
  }


# ibd visit variables to tabulate
ibd_variables <- c("sex",
                   "hx_inf_sepsis",
                   "hx_comor_chf"
)

ibd_counts <- count_function(df         = ibd_visits,
                             variables = ibd_variables)





