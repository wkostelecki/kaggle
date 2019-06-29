library(ggplot2)
library(dplyr)
library(lubridate)
library(tidymodels)

source("import.R")

calendar %>% 
  group_by(listing_id, month = month(date)) %>%
  summarize(price = n_distinct(price), 
            adjusted_price = n_distinct(adjusted_price)) %>% 
  ggplot() +
  geom_boxplot(aes(factor(month, labels = month.abb), price)) +
  scale_y_log10()



calendar = calendar %>% 
  mutate(price2 = as.numeric(gsub("^\\$|,", "", price)),
         adjusted_price2 = as.numeric(gsub("^\\$|,", "", adjusted_price)),
         discount2 = 1 - (adjusted_price2 / price2))



calendar = calendar %>% 
  group_by(listing_id) %>% 
  mutate(nprice2 = price2 / max(price2)) %>% 
  ungroup


# calendar %>% filter(nprice2 == min(nprice2))
# calendar %>% filter(listing_id == 49970)



listings = listings %>% 
  mutate(price = ifelse(price == 0, NA, price)) %>% 
  mutate(intercept = 1)

model = lm(log(price) ~ -1 + intercept:neighbourhood + intercept:room_type + intercept:cut(calculated_host_listings_count, 5) + intercept:cut(availability_365, 5), 
           data = listings)

listings = listings %>% 
  modelr::add_residuals(model)
