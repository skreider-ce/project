#' Initialize the project
#'
#' @export
#'
#' @examples
#' #project.initialize()
project.initialize <- function(){

  # Request explicit working directory assignment
  working_directory_result <- project.set_working_directory()

  # If no working directory assignment Then output a warning and do nothing
  if(is.null(working_directory_result)){
    warning("No working directory selected. Please run project.initialize again and set a valid working directory.")

  } else{
    # Set the working directory to be the current (recently assigned) working directory
    .wd = getwd()

    # Create a .gitignore file
    project.create_gitignore(.wd)

    # Add these default items to the .gitignore file
    project.add_to_gitignore(c(".Rproj.user"
                               ,".Rhistory"
                               ,".RData"
                               ,".Ruserdata"
                               ,"config.R"), .wd)
  }
}
