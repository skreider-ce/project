#' Takes dataset and gives us mean value between two variables
#'
#' @param data Any input dataset
#' @param var1 Name of the first variable
#' @param var2 Name of the second variable
#'
#' @return the variable mean
#' @export
#' @importFrom dplyr summarise
#' @examples
library(dplyr)
my_new_function_bernice <- function(data, var1, var2) {
  data %>%
    summarise(
      mean_var1 = mean({{var1}}, na.rm = TRUE),
      mean_var2 = mean({{var2}}, na.rm = TRUE)
    ) %>%
    return()
}

