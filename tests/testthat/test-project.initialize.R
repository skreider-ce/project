test_that("project.initialize creates a .gitignore file with default entries", {
  temp_dir <- tempdir()
  gitignore_path <- glue("{temp_dir}/.gitignore")

  # Ensure the .gitignore file does not exist initially
  if (file.exists(gitignore_path)) {
    file.remove(gitignore_path)
  }

  # Run the function
  suppressMessages(project.initialize(temp_dir))

  # Check if the .gitignore file was created
  expect_true(file.exists(gitignore_path))

  # Read the contents of the .gitignore file
  gitignore_contents <- readLines(gitignore_path)

  # Check if the default entries were added
  expected_entries <- c(".Rproj.user", ".Rhistory", ".RData", ".Ruserdata", "config.R")
  for (entry in expected_entries) {
    expect_true(entry %in% gitignore_contents)
  }
})
