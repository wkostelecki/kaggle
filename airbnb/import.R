
library(readr)
library(wtils)


listings = read_csv("data/london/listings.csv", # 80,946 rows
                    col_types = cols(
                      id = col_double(),
                      name = col_character(),
                      host_id = col_double(),
                      host_name = col_character(),
                      neighbourhood_group = col_logical(),
                      neighbourhood = col_character(),
                      latitude = col_double(),
                      longitude = col_double(),
                      room_type = col_character(),
                      price = col_double(),
                      minimum_nights = col_double(),
                      number_of_reviews = col_double(),
                      last_review = col_date(format = ""),
                      reviews_per_month = col_double(),
                      calculated_host_listings_count = col_double(),
                      availability_365 = col_double()
                    ))

calendar = read_csv("data/london/calendar.csv", # 29,480,812 rows
         n_max = 1000000,
         col_types = cols(
           listing_id = col_integer(),
           date = col_date(format = ""),
           available = col_logical(),
           price = col_character(),
           adjusted_price = col_character(),
           minimum_nights = col_integer(),
           maximum_nights = col_integer()
         ))





reviews = read_csv("data/london/reviews.csv",  # 1300708 rows
                   col_types = cols(
                     listing_id = col_double(),
                     date = col_date(format = "")
                   ))

neighbourhoods = read_csv("data/london/neighbourhoods.csv",
                          col_types = cols(
                            neighbourhood_group = col_logical(),
                            neighbourhood = col_character()
                          ))
