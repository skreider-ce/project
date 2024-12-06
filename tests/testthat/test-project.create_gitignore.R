test_that("project.create_gitignore creates a .gitignore file if one does not already exist", {
  # Create a temporary directory
  temp_dir <- tempdir()

  # Define the path to the .gitignore file in the temporary directory
  gitignore_path <- glue("{temp_dir}/.gitignore")

  # Ensure the .gitignore file does not exist
  if (file.exists(gitignore_path)) {
    file.remove(gitignore_path)
  }

  # Run the function
  suppressMessages(project.create_gitignore(temp_dir))

  # Check if the .gitignore file was created
  expect_true(file.exists(gitignore_path))
})

test_that("project.create_gitignore does not create a .gitignore file if one already exists", {
  # Create a temporary directory
  temp_dir <- tempdir()

  # Define the path to the .gitignore file in the temporary directory
  gitignore_path <- glue("{temp_dir}/.gitignore")

  # Ensure the .gitignore file exists
  if (!file.exists(gitignore_path)) {
    file.create(gitignore_path)
  }

  # Get the modification time of the existing .gitignore file
  original_mod_time <- file.info(gitignore_path)$mtime

  # Run the function
  suppressMessages(project.create_gitignore(temp_dir))

  # Check if the .gitignore file exists and was not modified
  expect_true(file.exists(gitignore_path))
  expect_equal(file.info(gitignore_path)$mtime, original_mod_time)
})
