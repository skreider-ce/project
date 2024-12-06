#' info Print information about the available functions in this package
#'
#' @export
#'
#' @importFrom glue glue
#'
#' @examples
#' corproject::info()
info <- function(){
  function_list <- list(
    "project.add_to_gitignore" = "Add a character string or character vector of items to the .gitignore file"
    ,"project.remove_from_gitignore" = "Remove a character string or character vector of items from the .gitignore file"
    ,"project.initialize" = "Initialize the project"
    ,"project.create_gitignore" = "Create a .gitignore file"
  )

  # Determine the maximum length of the function names
  max_length <- max(nchar(names(function_list)))

  message("The following functions are available in the corproject package:")
  message("Type ?<function_name> in the console to see more information about the function\n")

  for (func in names(function_list)) {
    # Format the function name to be of equal length by padding with spaces
    formatted_func <- format(func, width = max_length)
    message(glue::glue("{formatted_func} | {function_list[[func]]}"))
  }
}
