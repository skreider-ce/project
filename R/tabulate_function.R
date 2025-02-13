#' @name tabulate_function
#' @title Tabulate variables into a single df
#'
#' @param df Any dataframe that contains variables to tabulate
#' @param variables Vector of variables available in the df to tabulate
#'
#' @return Dataframe with tabulations for each variable.
#' @export
#'
#' @import dplyr
#' @import janitor
#' @import rlang
#'
#' @importFrom janitor tabyl
#' @importFrom dplyr mutate select bind_rows
#' @importFrom rlang sym
#'
#' @examples
#' tabulate_function(df = iris, variables = c("Sepal.Length", "Sepal.Width"))



tabulate_function <- function(df,
                              variables){

  for(i in variables){

    # create a temp data frame to store results from within function environment
    # only create once; will be created for first var name in vector
    if(i == dplyr::first(variables)){temp_df <- data.frame()}


    temp <- df |>
      # The !! is used to unquote an expression, and sym() is used to convert a
      # string into a symbol (which can then be used as a variable name or column name).
      janitor::tabyl(!!rlang::sym(i)) |>
      as.data.frame() |>
      # create a new variable that stores variable that is being tabulated
      dplyr::mutate(var_name = i) |>
      dplyr::select(-all_of(i))

    # bind new results to temp_df
    temp_df <- temp_df |>
      dplyr::bind_rows(temp)
  }
  return(temp_df)
}
