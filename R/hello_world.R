#' hello_world
#'
#' @param your_name The name to be displayed (default is ExampleNameium)
#'
#' @export
hello_world <- function(your_name = "ExampleNameium"){
  print(glue::glue("HELLO {your_name}!"))
}
