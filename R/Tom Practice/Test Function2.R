
#' Function to create a plot/distribution figure for any continuous variable
#'
#' @param dataframe Data that will be used to plot
#' @param var Variable that you want to plot
#' @param bins Number of bins in the plot
#' @param xlim Set the limit on the x-axis. Default is no limit
#'
#' @return A plot/distribution of the given variable
#' @export
#'
#' @importFrom ggplot2
#'
#' @examples Below


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
#plot_distribution(data, "bmi", bins = 20, xlim = c(10, 50))
#plot_distribution(data, "age")
#plot_distribution(data, "age",bins = 20, xlim=c(18,85))
