test_that("Given a character string is in .gitignore and given that single character string, the character string is removed from the gitignore file", {
  temp_dir <- tempdir()
  gitignore_path <- glue("{temp_dir}/.gitignore")

  # Create a .gitignore file with a single character string
  writeLines("config.R", gitignore_path)

  # Remove the character string
  suppressMessages(project.remove_from_gitignore("config.R", temp_dir))

  # Read the contents of the .gitignore file
  gitignore_contents <- readLines(gitignore_path)

  # Check if the string was removed
  expect_false("config.R" %in% gitignore_contents)
})

test_that("Given multiple character strings are in .gitignore and given those selections in a character vector, each element of the character vector is removed from the gitignore file", {
  temp_dir <- tempdir()
  gitignore_path <- glue("{temp_dir}/.gitignore")

  # Create a .gitignore file with multiple character strings
  writeLines(c("config.R", "temp/", "data/"), gitignore_path)

  # Remove the character vector
  suppressMessages(project.remove_from_gitignore(c("config.R", "data/"), temp_dir))

  # Read the contents of the .gitignore file
  gitignore_contents <- readLines(gitignore_path)

  # Check if the strings were removed
  expect_false("config.R" %in% gitignore_contents)
  expect_false("data/" %in% gitignore_contents)
  expect_true("temp/" %in% gitignore_contents)
})

test_that("Given multiple character strings are in .gitignore and given those selections plus some extra selections in a character vector, each element of the character vector is removed from the gitignore file, and messages are written for the character strings that were NOT removed from the file due to not being present", {
  temp_dir <- tempdir()
  gitignore_path <- glue("{temp_dir}/.gitignore")

  # Create a .gitignore file with multiple character strings
  writeLines(c("config.R", "data/", "temp/"), gitignore_path)

  # Capture messages
  suppressMessages(expect_message(project.remove_from_gitignore(c("config.R", "data/", "nonexistent"), temp_dir), "'nonexistent' is not in .gitignore."))

  # Read the contents of the .gitignore file
  gitignore_contents <- readLines(gitignore_path)

  # Check if the strings were removed
  expect_false("config.R" %in% gitignore_contents)
  expect_false("data/" %in% gitignore_contents)
  expect_true("temp/" %in% gitignore_contents)
})

test_that("Given a numeric value, the number is not removed from .gitignore and the warning is expected", {
  temp_dir <- tempdir()
  gitignore_path <- glue("{temp_dir}/.gitignore")

  # Create a .gitignore file with some content
  writeLines(c("config.R", "data/"), gitignore_path)

  # Add a numeric value and expect a warning
  expect_warning(suppressMessages(project.remove_from_gitignore(123, temp_dir), "'gitignore_removals' must be a character string or vector"))

  # Read the contents of the .gitignore file
  gitignore_contents <- readLines(gitignore_path)

  # Check if the content was not altered
  expect_true("config.R" %in% gitignore_contents)
  expect_true("data/" %in% gitignore_contents)
})

test_that("Given a numeric vector, the numbers are not removed from .gitignore and the warning is expected", {
  temp_dir <- tempdir()
  gitignore_path <- glue("{temp_dir}/.gitignore")

  # Create a .gitignore file with some content
  writeLines(c("config.R", "data/"), gitignore_path)

  # Add a numeric vector and expect a warning
  expect_warning(suppressMessages(project.remove_from_gitignore(c(123, 456), temp_dir), "'gitignore_removals' must be a character string or vector"))

  # Read the contents of the .gitignore file
  gitignore_contents <- readLines(gitignore_path)

  # Check if the content was not altered
  expect_true("config.R" %in% gitignore_contents)
  expect_true("data/" %in% gitignore_contents)
})
