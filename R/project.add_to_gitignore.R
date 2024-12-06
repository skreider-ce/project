#' project.add_to_gitignore Add a character string or vector entry to the .gitignore file
#'
#' @param gitignore_additions A character string or character vector of items to add to the .gitignore file
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
#'   project.add_to_gitignore("config.R")
#' }
project.add_to_gitignore <- function(gitignore_additions, .wd = getwd()){

  # Check if input parameter is a character string or vector
  if(!is.character(gitignore_additions)) {
    warning("'gitignore_additions' must be a character string or vector")

  } else{

    # Assign path to .gitignore file
    gitignore_path <- glue::glue("{.wd}/.gitignore")

    # Read contents of .gitignore file
    gitignore_contents <- readLines(gitignore_path)

    # Loop through entries and add them to the .gitignore file
    for(gitignore_entry in gitignore_additions){

      # Check if target_file is in .gitignore
      if (gitignore_entry %in% gitignore_contents) {
        message(glue::glue("'{gitignore_entry}' is already in .gitignore."))

      } else {

        # Append target_file to .gitignore
        new_entry <- glue::glue("\\n{gitignore_entry}\\n")
        write(gitignore_entry, gitignore_path, append = TRUE)
        message(glue::glue("Added '{gitignore_entry}' to .gitignore."))
      }
    }
  }
}
