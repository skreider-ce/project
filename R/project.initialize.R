project.initialize <- function(){
  # Set application directory for the app to be run
  appDir <- system.file("myapp", package = "corproject")
  if (appDir == "") {
    stop("Could not find myapp. Try re-installing `corproject`.", call. = FALSE)
  }

  ui <- source(file.path(appDir, "ui.R"))$value
  server <- source(file.path(appDir, "server.R"))$value

  shiny::runGadget(ui, server ,viewer = shiny::paneViewer())  # Run the UI in RStudio Viewer pane
}
