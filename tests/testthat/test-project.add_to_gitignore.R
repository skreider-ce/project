test_that("Given a single character string, the character string is added to the .gitignore file", {
  temp_dir <- tempdir()
  gitignore_path <- glue("{temp_dir}/.gitignore")

  # Ensure the .gitignore file does not exist initially
  if (file.exists(gitignore_path)) {
    file.remove(gitignore_path)
  }

  # Create an empty .gitignore file
  file.create(gitignore_path)

  # Add a single character string
  suppressMessages(project.add_to_gitignore("config.R", temp_dir))

  # Read the contents of the .gitignore file
  gitignore_contents <- readLines(gitignore_path)

  # Check if the string was added
  expect_true("config.R" %in% gitignore_contents)
})

test_that("Given a character vector, each element of the character vector is added to the .gitignore file", {
  temp_dir <- tempdir()
  gitignore_path <- glue("{temp_dir}/.gitignore")

  # Ensure the .gitignore file does not exist initially
  if (file.exists(gitignore_path)) {
    file.remove(gitignore_path)
  }

  # Create an empty .gitignore file
  file.create(gitignore_path)

  # Add a character vector
  suppressMessages(project.add_to_gitignore(c("config.R", "data/"), temp_dir))

  # Read the contents of the .gitignore file
  gitignore_contents <- readLines(gitignore_path)

  # Check if the strings were added
  expect_true("config.R" %in% gitignore_contents)
  expect_true("data/" %in% gitignore_contents)
})

test_that("Given a numeric value, the number is not added to .gitignore and the warning is expected", {
  temp_dir <- tempdir()
  gitignore_path <- glue("{temp_dir}/.gitignore")

  # Ensure the .gitignore file does not exist initially
  if (file.exists(gitignore_path)) {
    file.remove(gitignore_path)
  }

  # Create an empty .gitignore file
  file.create(gitignore_path)

  # Add a numeric value and expect a warning
  expect_warning(suppressMessages(project.add_to_gitignore(123, temp_dir), "'gitignore_additions' must be a character string or vector"))

  # Read the contents of the .gitignore file
  gitignore_contents <- readLines(gitignore_path)

  # Check if the number was not added
  expect_false("123" %in% gitignore_contents)
})

test_that("Given a numeric vector, the numbers are not added to .gitignore and the warning is expected", {
  temp_dir <- tempdir()
  gitignore_path <- glue("{temp_dir}/.gitignore")

  # Ensure the .gitignore file does not exist initially
  if (file.exists(gitignore_path)) {
    file.remove(gitignore_path)
  }

  # Create an empty .gitignore file
  file.create(gitignore_path)

  # Add a numeric vector and expect a warning
  expect_warning(suppressMessages(project.add_to_gitignore(c(123, 456), temp_dir), "'gitignore_additions' must be a character string or vector"))

  # Read the contents of the .gitignore file
  gitignore_contents <- readLines(gitignore_path)

  # Check if the numbers were not added
  expect_false("123" %in% gitignore_contents)
  expect_false("456" %in% gitignore_contents)
})
