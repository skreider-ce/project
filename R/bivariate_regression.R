# Program: bivariate_regression.R
# Author:  Yolanda Munoz Maldonado
# Date:    01/30/2025
# Purpose: function to run bivariate regression of one outcome
#          against a list of covariates and generate a table with
#          the coefficient, SE, and p-value
#----------------------------------------------------------------

# loading libraries

library("dplyr")
library("officer")
library("glue")


#' Title bivariate_table
#' Function that runs bivariate regressions of one outcome agains a list of covariates, and
#' generates a table with the beta coefficient, standard error, and p-values.
#' Requires the libraries dplyr, officer, glue and flextable.
#' @param data clean data frame that includes the outcome and the covariates for the bivarate regression.
#' @param covariates list of covariates.To be  included in a linear regression model as independet variable.
#' @param outcome outcome of interest in the linear regression model
#' @param digits number of digits for the estimated parameters
#'
#' @return
#' @export
#'
#' @examples
bivariate_table <- function(data,covariates,outcome, digits)
{



  results <- data.frame(Covariate = character(),
                        Beta = numeric(),
                        Std_Error = numeric(),
                        P_Value = numeric(),
                        stringsAsFactors = FALSE)

  for (covariate in covariates) {
    formula <- as.formula(paste(outcome, "~", covariate))
    model <- lm(formula, data = data)
    summary_model <- summary(model)
    coefs <- summary_model$coefficients

    # Extract the beta coefficient, standard error, and p-value for the covariate
    beta <- coefs[2, "Estimate"]
    std_error <- coefs[2, "Std. Error"]
    p_value <- coefs[2, "Pr(>|t|)"]

    # Append the results to the data frame
    results <- rbind(results, data.frame(Covariate = covariate,
                                         Beta = beta,
                                         Std_Error = std_error,
                                         P_Value = p_value, stringsAsFactors = FALSE))
  }

  # Create a flextable object
  ft <- flextable(results)

  # Format the numeric columns to show the specified number of digits
  ft <- colformat_num(ft, j = c("Beta", "Std_Error", "P_Value"), digits = digits, na_str = "NA", big.mark = "", decimal.mark = ".")

  # Adjust the number of digits strictly
  ft <- compose(ft, j = "Beta", value = as_paragraph(as_chunk(sprintf(paste0("%.", digits, "f"), Beta))))
  ft <- compose(ft, j = "Std_Error", value = as_paragraph(as_chunk(sprintf(paste0("%.", digits, "f"), Std_Error))))
  ft <- compose(ft, j = "P_Value", value = as_paragraph(as_chunk(sprintf(paste0("%.", digits, "f"), P_Value))))


  return(ft)

}

