#' server The server for the interactive ui
#'
#' @param input
#' @param output
#' @param session
#'
#' @importFrom shiny reactiveVal observeEvent renderUI actionButton verbatimTextOutput fileInput tagList renderText stopApp req observe
#' @importFrom svDialogs dlg_dir
server <- function(input, output, session) {
  folder <- shiny::reactiveVal()
  working_directory_set <- shiny::reactiveVal(FALSE)

  shiny::observeEvent(input$set_wd, {
    selected_dir <- svDialogs::dlg_dir()$res
    if (!is.null(selected_dir) && nzchar(selected_dir)) {
      setwd(selected_dir)
      working_directory_set(TRUE)
      print(paste("Working Directory:", selected_dir))
      output$wd_text <- shiny::renderText("")
      # create_support_files(selected_dir)
      # manage_gitignore_add(selected_dir)
    }
  })

  output$directory_ui <- shiny::renderUI({
    if (!working_directory_set()) {
      shiny::actionButton("set_wd", "Set Working Directory")
    }
  })

  output$file_folder_ui <- shiny::renderUI({
    if (working_directory_set()) {
      shiny::tagList(
        shiny::fileInput("file", "Choose a file", accept = c(".rds", "dta")),
        shiny::actionButton("folder", "Select Folder"),
        shiny::verbatimTextOutput("folder_text")
      )
    }
  })

  shiny::observeEvent(input$folder, {
    folder(svDialogs::dlg_dir()$res)  # Use svDialogs for folder selection
    output$folder_text <- shiny::renderText(folder())
  })

  shiny::observe({
    if (working_directory_set() && !is.null(input$file) && !is.null(folder())) {
      shinyjs::enable("run_code")
    } else {
      shinyjs::disable("run_code")
    }
  })

  shiny::observeEvent(input$run_code, {
    shiny::req(folder())
    shiny::req(input$file)
    # Here you can run any code using the selected file and folder
    print(paste("Folder:", folder()))
    print(paste("File:", input$file$datapath))
  })

  shiny::observeEvent(input$done, {
    shiny::stopApp()
  })
}
