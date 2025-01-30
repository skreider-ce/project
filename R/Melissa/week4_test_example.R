#######################
# week 4 test example
#######################

library("roxygen2")
library("WeightIt")
library("arsenal")
library("dplyr")
library("tidyr")

# function
source("./R/Melissa/week4_test_function.R")

# use sample PsO data
cohort <- readRDS("./R/Melissa/data/example_data.RDS")

# list of balance covariates
balance_covs <- c( "bmi_3cat",
                   "pso_duration_cat_reduced",
                   "bionaive",
                   "bsa_cat_bl",
                   "iga_new_bl",
                   "DLQI_cat_bl",
                   "any_hard_to_treat",
                   "age",
                   "female_male",
                   "race_white",
                   "pasi_cat_bl",
                   "pt_itch_bl",
                   "psa_curr_past")

# set seed for reproducible results
set.seed(14380)

test <- cov_bal(data = cohort,
                covs = balance_covs,
                strata = "drugkey",
                remove_na = TRUE,
                method = "glm",
                estimand = "ATE",
                stabilize = TRUE)

summary(test$Weights)
summary(test$ps)


test_ebal <- cov_bal(data = cohort,
                covs = balance_covs,
                strata = "drugkey",
                remove_na = TRUE,
                method = "ebal",
                estimand = "ATE",
                stabilize = TRUE)

summary(test_ebal$Weights)

# cbps plus change around parameters
test_cbps <- cov_bal(data = cohort,
                     covs = balance_covs,
                     strata = "drugkey",
                     remove_na = FALSE,
                     method = "cbps",
                     estimand = "ATT",
                     stabilize = FALSE)

summary(test_cbps$Weights)
summary(test_cbps$ps)
