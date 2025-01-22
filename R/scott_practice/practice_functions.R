install.packages("dplyr")
install("haven")
install.packages("glue")
install.packages("officer")
library(dplyr)
library(haven)
library(glue)
library(officer)


# Function to read in a dataset from a specified location
read_dataset <- function(ds_url){ # Input a direct URL to an R dataset

  # Print the URL to the R dataset to the console
  print(ds_url)

  # Create a temporary variable that reads in the dataset from the location and apply some formatting to factor variables
  temp_ds <- base::readRDS(ds_url) |>
    haven::as_factor()

  # Return the R dataset that was read in for use in the next step
  return(temp_ds)
}


analysis_dataset <- read_dataset("C:/Users/ScottKreider/OneD - Corrona LLC/Corrona LLC/Biostat Data Files - AD/monthly/2025/2025-01-03/exinstances_2025-01-03.rds")
analysis_dataset <- read_dataset("C:/Users/ScottKreider/OneD - Corrona LLC/Corrona LLC/Biostat Data Files - AD/monthly/2025/2025-01-03/exvisit_2025-01-03.rds")




# Function to summarize an input dataset
summarize_dataset <- function(dataset){ # Input an analytic dataset

  # Create a temporary variable to house the summary of the analytic file
  temp_summary <- base::summary(dataset)

  # Return the summary for use in the next step
  return(temp_summary)
}


summary_dataset <- summarize_dataset(analysis_dataset)




# Function to read in a summary dataset and output to a designated folder
output_to_word <- function(summary_data, outp_url){ # Input summary dataset and folder of output file

  # Print output folder URL to console
  print(outp_url)

  # Create a temporary Word doc and add a Summary Table heading and a table as the body
  temp_doc <- officer::read_docx() |>
    officer::body_add_par("Summary Table", style = "heading 1") |>
    officer::body_add_table(as.data.frame(summary_data))

  # Save the temporary Word doc in the designated location
  print(temp_doc, target = glue::glue("{outp_url}/summary_table.docx"))
}

output_to_word(summary_dataset, "C:/Users/ScottKreider/OneD - Corrona LLC/OneDrive - Corrona LLC/Desktop/")






# One parent function to run them all
# Ensure all the functions above are "created" and in the Environment on the top right as they will be "called" in this function
read_in_summarize_and_output_to_word <- function(ds_url, outp_folder_url){ # Input URL of analytic file and folder of output file
  # Read in the dataset
  temp_analysis_dataset <- read_dataset(ds_url)

  # Summarize the dataset
  temp_summary_table <- summarize_dataset(temp_analysis_dataset)

  # Output to word file
  output_to_word(temp_summary_table, outp_folder_url)
}





read_in_summarize_and_output_to_word(ds_url = "C:/Users/ScottKreider/OneD - Corrona LLC/Corrona LLC/Biostat Data Files - AD/monthly/2025/2025-01-03/exinstances_2025-01-03.rds"
                                     ,outp_folder_url = "C:/Users/ScottKreider/OneD - Corrona LLC/OneDrive - Corrona LLC/Desktop/")

read_in_summarize_and_output_to_word(ds_url = "C:/Users/ScottKreider/OneD - Corrona LLC/Corrona LLC/Biostat Data Files - AD/monthly/2025/2025-01-03/exvisit_2025-01-03.rds"
                                     ,outp_folder_url = "C:/Users/ScottKreider/OneD - Corrona LLC/OneDrive - Corrona LLC/Desktop/")
