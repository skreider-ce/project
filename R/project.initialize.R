#' project.initialize Initialize the project
#'
#' @param .wd  The base working directory of the project. This should be where the .gitignore file lives (DEFAULT is getwd())
#'
#' @export
#'
#' @examples
#' project.initialize(getwd())
project.initialize <- function(.wd = getwd()){

  # Create a .gitignore file
  project.create_gitignore(.wd)

  # Add these default items to the .gitignore file
  project.add_to_gitignore(c(".Rproj.user"
                             ,".Rhistory"
                             ,".RData"
                             ,".Ruserdata"
                             ,"config.R"), .wd)
}
