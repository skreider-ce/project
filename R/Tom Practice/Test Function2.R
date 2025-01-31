# test function2

setwd("C:/Users/ThomasEckmann/Documents/GitHub/corproject/R/Tom Practice/")
data <- read_dta("C:/Users/ThomasEckmann/Corrona LLC/Biostat Data Files - PsO/monthly/2025/2025-01-10/exvisit_2025-01-10.dta")



# Distribution function
library(ggplot2)

plot_distribution <- function(dataframe, var, bins = 10, xlim = NULL) {
  # Check if the variable (var) exists
  if (!(var %in% colnames(dataframe))) {
    stop("Variable not found in the dataset. Please provide a valid variable name.")
  }
  # Check if the variable (var) is numeric
  if (!is.numeric(dataframe[[var]])) {
    stop("The selected variable is not numeric. Please choose a numeric variable.")
  }

  # Create the histogram
  p <- ggplot(dataframe, aes(x = .data[[var]])) +
    geom_histogram(bins = bins, fill = "steelblue", color = "black", alpha = 0.7) +
    labs(
      title = paste("Distribution of", var),
      x = var,
      y = "Frequency"
    ) +
    theme_minimal()

  # Apply x-axis limits if provided
  if (!is.null(xlim)) {
    p <- p + xlim(xlim[1], xlim[2])
  }

  print(p)
}

# Example usage:
plot_distribution(data, "bmi", bins = 20, xlim = c(10, 50))
plot_distribution(data, "age")
plot_distribution(data, "age",bins = 20, xlim=c(18,85))
