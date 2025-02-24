#' Searches through a base folder and looks for config.R files - if found - creates an identical folder name in the output folder and copies the config.R file there
#'
#' Function partially written with help from Gene.AI
#'
#' @param base_folder The folder that contains subfolders to search through
#' @param output_folder The folder to store the results in
#'
#' @export
#'
#' @importFrom fs is_dir path_file dir_ls dir_create file_copy
project.extract_config_files <- function(base_folder, output_folder) {

  # Function to recursively search and copy config.R files
  process_folder <- function(current_folder, relative_path) {
    # List all files and directories in the current folder
    contents <- fs::dir_ls(current_folder, recurse = FALSE)

    for (item in contents) {
      if (fs::is_dir(item)) {
        # If item is a directory, process it recursively
        new_relative_path <- file.path(relative_path, fs::path_file(item))
        process_folder(item, new_relative_path)
      } else if (fs::path_file(item) == "config.R") {
        # If item is config.R, copy it to the corresponding output folder
        target_folder <- file.path(output_folder, relative_path)
        fs::dir_create(target_folder)
        fs::file_copy(item, file.path(target_folder, "config.R"))
      }
    }
  }

  # Start processing from the base folder
  process_folder(base_folder, "")
}
