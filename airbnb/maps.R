


library(ggmap)

source("model.R")

# need to set up Google API
# map = get_map("London", zoom = 12)
# saveRDS(map, "data/map.rds")

map = readRDS("data/map.rds")
ggmap(map)

ggmap(map) +
  geom_point(data = listings, aes(longitude, latitude))

ggmap(map) +
  geom_density_2d(data = listings %>% 
                    filter(room_type %in% c("Entire home/apt", "Private room")),
                  aes(x = longitude, y = latitude, colour = room_type),
                  bins = 20)



ggmap(map) +
  geom_point(data = listings %>% 
               # sample_n(100) %>% 
               filter(room_type %in% c("Entire home/apt", "Private room")),
             aes(x = longitude, y = latitude, colour = room_type),
             size = 0.5,
             alpha = 0.1)



g = ggmap(map) +
  geom_point(data = listings %>%  
               # sample_n(100) %>%
               filter(room_type %in% c("Entire home/apt", "Private room")) %>%
               group_by(room_type) %>%
               mutate(price = pmin(price, quantile(price, 0.97, na.rm = TRUE)),
                      index = price / max(price, na.rm = TRUE)) %>% 
               arrange(index) %>% 
               identity,
             aes(x = longitude, y = latitude,
                 colour = index),
             size = 2,
             shape = 16,
             alpha = 0.2) +
  facet_wrap(~ room_type) +
  scale_colour_gradientn("Price Index", colours = ezplot::ez_jet(100)) +
  theme_minimal(base_size = 18)
  # theme(axis.text = element_blank(),
  #       axis.ticks = element_blank()) +
  # theme(legend.position = "none")
g

ezplot::ez_png(g, "price_map.png", height = 500, width = 1000)
