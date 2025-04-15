library(tidyverse)
library(rnaturalearth)
library(sf)

kraje <- ne_countries()

ggplot(data = kraje, mapping = aes(x = income_grp, fill = economy)) +
  geom_bar()

ggplot(data = kraje, aes(fill = income_grp)) +
  geom_sf() + 
  geom_text(aes(x = label_x, y = label_y, label = name),
            check_overlap = TRUE) + 
  theme_minimal()

kraje %>% count(economy) # nie działa

table(kraje$continent)
