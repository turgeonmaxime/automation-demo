library(tidyverse)
library(RcppRoll)

dataset <- read_csv("cache/prov_data.csv")

dataset %>%
    arrange(Date) %>% 
    mutate(roll_avg7 = roll_mean(cases, n = 7,
                                 fill = NA,
                                 align = "right")) %>% 
    ggplot(aes(x = Date,
               y = cases)) +
    geom_line(colour = "grey60") +
    geom_line(aes(y = roll_avg7), colour = "blue") +
    theme_minimal() +
    theme(legend.title = element_blank(),
          plot.subtitle = element_text(face = "italic")) +
    xlab("") + ylab("Daily Cases") +
    labs(title = paste0("Daily COVID-19 cases"),
         subtitle = "Blue: 7-day average.",
         caption = paste("Data downloaded from",
                         "https://dashboard.saskatchewan.ca/health-wellness"))

ggsave("figures/daily-cases-7day-avg.png",
       width = 6, height = 3) # Specified in inches by default
