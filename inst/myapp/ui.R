#' ui The interactive ui for project initialization
#'
#' @importFrom miniUI miniPage gadgetTitleBar miniContentPanel
#' @importFrom shinyjs useShinyjs
#' @importFrom shiny uiOutput verbatimTextOutput actionButton
ui <- function(){
  miniUI::miniPage(
    miniUI::gadgetTitleBar("Select Working Directory and File"),
    miniUI::miniContentPanel(
      shinyjs::useShinyjs(),  # Initialize shinyjs
      shiny::uiOutput("directory_ui"),
      shiny::verbatimTextOutput("wd_text"),
      shiny::uiOutput("file_folder_ui"),
      shiny::actionButton("run_code", "Run Code", disabled = TRUE)
    )
  )
}
