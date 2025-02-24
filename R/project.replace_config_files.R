#' Take in an input_folder with folders that contain config.R files - searches through final_folder and if the subfolder exists then copies config.R to the subfolder in the final_folder
#'
#' Function partially written with help from Gene.AI
#'
#' @param input_folder The folder that contains subfolders with the currently existing config.R files
#' @param final_folder The folder that contains the subfolders that you want to copy the config.R files to
#'
#' @export
#'
#' @importFrom fs dir_ls path_file file_exists file_copy
project.replace_config_files <- function(input_folder, final_folder) {

  # Function to find and copy config.R files
  process_folder <- function(input_subfolder, final_subfolder) {
    # List all subdirectories in the input subfolder
    subfolders <- fs::dir_ls(input_subfolder, type = "directory", recurse = FALSE)

    for (subfolder in subfolders) {
      subfolder_name <- fs::path_file(subfolder)
      corresponding_final_subfolder <- file.path(final_subfolder, subfolder_name)

      if (fs::dir_exists(corresponding_final_subfolder)) {
        # If the corresponding subfolder exists in the final folder
        config_file <- file.path(subfolder, "config.R")

        if (fs::file_exists(config_file)) {
          # If config.R exists in the input subfolder
          target_config_file <- file.path(corresponding_final_subfolder, "config.R")

          if (!fs::file_exists(target_config_file)) {
            # If config.R does not exist in the final subfolder, copy it
            fs::file_copy(config_file, target_config_file)
          } else {
            # If config.R already exists in the final subfolder, print a message
            message("config.R in '", corresponding_final_subfolder, "' was not overwritten.")
          }
        }

        # Recursively process the subfolders
        process_folder(subfolder, corresponding_final_subfolder)
      }
    }
  }

  # Start processing from the input folder
  process_folder(input_folder, final_folder)
}
