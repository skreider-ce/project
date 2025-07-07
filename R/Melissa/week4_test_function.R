#' Covariate balancing function
#'
#' `cov_bal` runs a specified type of balancing on the data using WeightIt
#'
#' You enter your data set, preferred method of balancing,
#' covariates to balance on, groups that you want to balance,
#' and further arguments to specify how to do the balancing
#' @param data Data frame
#' @param covs Balance covariates - a vector of covariate names from data
#' @param strata Grouping variable
#' @param remove_na Logical, default is TRUE, remove missing values
#' @param method Balancing method: default = "glm". Other options are ebal and cbps
#' @param estimand Default is "ATE", can also use "ATT" or "ATC"
#' @param stabilize Logical, default is TRUE
#' @return data set with weights and propensity scores (if not using ebal)

cov_bal <- function(data,
                    covs,
                    strata,
                    remove_na = TRUE,
                    method = "glm",
                    estimand = "ATE",
                    stabilize = TRUE){


  # model
  f=arsenal::formulize(y=strata, x=covs)

  if(remove_na == TRUE){
    data <- data %>%
      select(c(all_of(strata), all_of(covs))) %>%
      drop_na()
  }

  W <- WeightIt::weightit(f,
                          data =data,
                          estimand = estimand,
                          method = method,
                          stabilize = stabilize)
  # get propensity score if not using ebal
  if(method!="ebal"){
    dat_out <-data %>% mutate(Weights = W$weights,
                              ps = W$ps)
  }else{
    dat_out <-data %>% mutate(Weights = W$weights)
  }
  return(dat_out)

}

