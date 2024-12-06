#' project.remove_from_gitignore Remove a character string or vector entry to the .gitignore file
#'
#' @param gitignore_removals A character string or character vector of items to remove from the .gitignore file
#' @param .wd The base working directory of the project. This should contain the .gitignore file being updated (DEFAULT is getwd())
#'
#' @export
#'
#' @importFrom glue glue
#'
#' @examples
#' # For a .gitignore file in the current working directory
#' wd = getwd()
#' if(file.exists(glue::glue("{wd}/.gitignore"))){
#'   project.remove_from_gitignore("config.R")
#' }
project.remove_from_gitignore <- function(gitignore_removals, .wd = getwd()){

  # Check if input parameter is a character string or vector
  if(!is.character(gitignore_removals)) {
    warning("'gitignore_removals' must be a character string or vector")

  } else{

    # Assign path to .gitignore file
    gitignore_path <- glue::glue("{.wd}/.gitignore")

    # Read contents of .gitignore file
    new_contents <- readLines(gitignore_path)

    # Loop through entries and remove them from the .gitignore file
    for(gitignore_entry in gitignore_removals){

      # Check if target_file is in .gitignore
      if (!(gitignore_entry %in% new_contents)) {
        message(glue::glue("'{gitignore_entry}' is not in .gitignore."))

      } else {

        # Append target_file to .gitignore
        new_contents <- new_contents[new_contents != gitignore_entry]
        message(glue::glue("'{gitignore_entry}' was removed from .gitignore."))
      }
      writeLines(new_contents, gitignore_path)
    }
  }
}
