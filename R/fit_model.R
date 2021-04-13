library(tidyverse)
library(RcppRoll)

dataset <- read_csv("cache/prov_data.csv")

fit <- lm(cases ~ tests - 1, 
          data = dataset)

saveRDS(fit, "cache/model-fit.rds")