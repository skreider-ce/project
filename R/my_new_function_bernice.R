    #' @name my_new_function
    #' @title Takes dataset and gives us mean value between two variables
    #'
    #' @param data Any input data
    #' @param var1 Name of the first variable
    #' @param var2 Name of the second variable
    #'
    #' @return the variable mean
    #' @export
    #' @importFrom dplyr summarize %>%
    #' @examples
    #' project::my_new_function(cars, speed, dist)
my_new_function<- function(data, var1, var2) {
  data %>%
    summarize(
      mean_var1 = mean({{var1}}, na.rm = TRUE),
      mean_var2 = mean({{var2}}, na.rm = TRUE)
    ) %>%
    return()
}



