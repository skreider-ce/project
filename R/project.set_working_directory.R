#' An Rstudio interactive UI to set your working directory
#'
#' @export
#'
#' @return NULL if cancelled or directory not selected; the URL of the directory is selected
#'
#' @examples
#' project.set_working_directory()
project.set_working_directory <- function() {
  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Select your Working directory", right = NULL)
    ,miniUI::miniContentPanel(
      shiny::div(style = "padding: 10px; background-color: #f0f0f0; border-bottom: 1px solid #ccc;",
                 "Please choose the BASE folder of the project you are working on")
      ,shiny::actionButton("select", "Select Directory")
      ,shiny::verbatimTextOutput("selected_dir")
      ,shiny::actionButton("done", "Done")
    )
  )

  server <- function(input, output, session) {
    selected_dir <- shiny::reactiveVal(NULL)
    result <- shiny::reactiveVal(NULL)

    shiny::observeEvent(input$select, {
      selected_dir(svDialogs::dlg_dir()$res)
      output$selected_dir <- shiny::renderText({
        selected_dir()
      })
    })

    shiny::observeEvent(input$done, {
      if (!is.null(selected_dir())) {
        setwd(selected_dir())
        result(selected_dir())
        message(glue::glue("Selected working directory: {getwd()}"))
      } else {
        result(NULL)
        message("No directory selected.")
      }

      shiny::stopApp(result())
    })

    shiny::observeEvent(input$cancel, {
      selected_dir(NULL)
      result(NULL)
      message("No directory selected.")
      shiny::stopApp(result())
    })
  }

  shiny::runGadget(ui, server, viewer = shiny::paneViewer())
}
