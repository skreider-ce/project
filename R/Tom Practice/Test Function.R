
#' Test Function: Saving for R or Stata
#'
#' @param data Any dataset we want to save
#' @param path File path or directory
#' @param file_type Specify 'rds' or 'dta'
#'
#' @return The saved file
#' @export
#'
#' @importFrom haven
#'
#' @examples below

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
#test_function(data,"example.rds",file_type = "rds")
# Save as Stata DTA
#test_function(data,"example.dta",file_type = "dta")

