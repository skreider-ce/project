
setwd("C:/Users/ThomasEckmann/Documents/GitHub/corproject/R/Tom Practice/")
data <- read_dta("C:/Users/ThomasEckmann/Corrona LLC/Biostat Data Files - PsO/monthly/2025/2025-01-10/exvisit_2025-01-10.dta")


# Save function
library(haven)

#' Test Function: Saving for R or Stata
#'
#' @param data Data that you want to save
#' @param path File path or directory
#' @param file_type Specify 'rds' or 'dta'
#'
#' @return
#' @export
#'
#' @examples

test_function <- function(data, path, file_type = "rds") {
  # Check file type
  if(!file_type %in% c("rds", "dta")) {
    stop("Not supported. Use 'rds' or 'dta'.")
  }
  # Save rds
  if(file_type == "rds") {
    saveRDS(data, file = path)
  }
  # Save dta
  if(file_type == "dta") {
    write_dta(data, path)
  }
}

# Example usage:

# Save as RDS
test_function(data,"example.rds",file_type = "rds")
# Save as Stata DTA
test_function(data,"example.dta",file_type = "dta")

