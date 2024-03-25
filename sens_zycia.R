

# install.packages("tidyverse")
# install.packages("PogromcyDanych")

library(tidyverse)
library(PogromcyDanych)

dane_diagnoza <- PogromcyDanych::diagnoza

z2 <- dane_diagnoza

dim(na.omit(z2))

ggplot(data = z2,
       mapping = aes(x = eduk4_2013, fill = gp54_02)) +
  geom_bar(position = "fill") + 
  coord_flip() + 
  labs(title = "Sens życia a wykształcenie")


ggplot(data = z2 %>% select(eduk4_2013, gp54_02) %>% na.omit(),
       mapping = aes(x = eduk4_2013, fill = gp54_02)) +
  geom_bar(position = "fill") + 
  coord_flip() + 
  labs(title = "Sens życia a wykształcenie", 
       subtitle = "braki danych usunięte na obu zmiennych")

ggplot(data = z2 %>% filter(!is.na(eduk4_2013)),
       mapping = aes(x = eduk4_2013, fill = gp54_02)) +
  geom_bar(position = "fill") + 
  coord_flip() + 
  labs(title = "Sens życia a wykształcenie", 
       subtitle = "braki danych usunięte na wykształceniu")

ggplot(data = z2 %>% filter(!is.na(gp54_02)),
       mapping = aes(x = eduk4_2013, fill = gp54_02)) +
  geom_bar(position = "fill") + 
  coord_flip() + 
  labs(title = "Sens życia a wykształcenie", 
       subtitle = "braki danych usunięte na pyt. o sens życia")

chisq.test(x = z2$eduk4_2013, y = z2$gp54_02)

library(sjPlot)

sjPlot::tab_xtab(z2$eduk4_2013,
                 z2$gp54_02)


# https://strengejacke.github.io/sjPlot/reference/sjplot.html

sjtab(data = z2 %>% filter(eduk4_2013 != "BD/ND/FALA"), 
       eduk4_2013, 
       gp54_02, 
       fun = "xtab")

# trzeba zdropować jeden level

# sjtab(data = z2, 
#       gp54_02,
#       forcats::fct_drop(z2$eduk4_2013, only = "BD/ND/FALA"), 
#       fun = "xtab") # nie działa


sjPlot::tab_xtab(z2$gp54_02, 
                 fct_drop(z2$eduk4_2013),
                 show.col.prc = TRUE)


