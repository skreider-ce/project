# Program: checks.R
# Author:  Yolanda Munoz Maldonado
# Date:    01/30/2025
# Purpose: to check chuncks of code
#----------------------------------------------------------------


library(flextable)
# creating path for where the data is stored
cohort_path <- "C:/Users/munozmy/Corrona LLC/Biostat Data Files - Queries and Projects/RA/Subscriber/Abbvie/AbbVie 114/Data"
dir.exists(cohort_path)
# reading data
# the data set is the dataset used for AbbVie RA 114, cleaned for linear regression
cohort <- readRDS(glue::glue("{cohort_path}/change_cdai_data2.rds"))
names(cohort)[2000:2407]


class(cohort$change_cdai)


# list of covariates

covar_list <- c("base_age", "base_gender", "base_race_white", "base_bmi",
                "base_duration_ra","base_cdai","base_pt_pain")

summary(lm(change_cdai~base_age,data =  cohort) )

table1 <- bivariate_table(cohort, covar_list, "change_cdai", digits= 5)

