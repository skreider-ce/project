#' project.initialize Initialize the project
#'
#' @param .wd  The base working directory of the project. This should be where the .gitignore file lives (DEFAULT is getwd())
#'
#' @export
#'
#' @examples
#' project.initialize(getwd())
project.initialize <- function(.wd = getwd()){
  project.create_gitignore(.wd)
}
