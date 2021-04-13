library(tidyverse)

# Data downloaded from SK's COVID dashboard
# https://dashboard.saskatchewan.ca/health-wellness
data_cases <- read_csv("data-raw/cases.csv")
data_tests <- read_csv("data-raw/tests.csv")

# Data is broken down by region
# We want to look at provincial results
data_cases <- data_cases %>% 
    group_by(Date) %>% 
    summarise(cases = sum(`New Cases`, na.rm = TRUE),
              deaths = sum(Deaths, na.rm = TRUE))

data_tests <- data_tests %>% 
    group_by(Date) %>% 
    summarise(tests = sum(`New Tests`, na.rm = TRUE))

data_full <- inner_join(data_cases,
                        data_tests,
                        by = "Date")

write_csv(data_full,
          "cache/prov_data.csv")
