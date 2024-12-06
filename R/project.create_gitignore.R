#' project.create_gitignore Initialize a .gitignore file in the given working directory if it does not already exist
#'
#' @param .wd The base working directory of the project. This should be where the .gitignore file lives (DEFAULT is getwd())
#'
#' @export
#'
#' @importFrom glue glue
#'
#' @examples
#' # For a .gitignore file in the current working directory
#' wd = getwd()
#' project.create_gitignore(wd)
project.create_gitignore <- function(.wd = getwd()){
  # Define the supposed path to the .gitignore file
  gitignore_path <- glue::glue("{.wd}/.gitignore")

  # Check if .gitignore file already exists
  if(file.exists(gitignore_path)){
    message(glue::glue(".gitignore file already exists in {.wd}"))

  } else{
    # Create the file in the given working directory
    file.create(gitignore_path)
    message(glue::glue(".gitignore file created in {.wd}"))

  }
}
