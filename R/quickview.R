#' Quickly view a variable with `id` and `visitdate`
#'
#' @param df A data set containing `id` and `visitdate`. If it doesn't contain those variables, it will only view the `key` variable.
#' @param key A character string of the name of the variable in `df` to view.
#' @returns Opens a View() window.
#' @import dplyr
#' @export




quickview <- function(df, key) {
  # Ensure that key is a character string
  key <- as.character(key)

  # Check if 'id' and 'visitdate' columns are present in the dataframe
  if (all(c("id", "visitdate") %in% names(df))) {
    # Select columns that include 'id', 'visitdate', and any column containing the key
    selected_columns <- df %>%
      select(id, visitdate, contains(key))
  } else {
    # Select only the column containing the key
    selected_columns <- df %>%
      select(contains(key))
  }

  # View the selected columns in a viewer window
  View(selected_columns)
}
