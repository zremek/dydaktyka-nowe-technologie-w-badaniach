library(tidyverse)
library(PogromcyDanych)

# analiza jednej zmiennej ilościowej
# czyli statystyki opisowe

dane_diagnoza <- PogromcyDanych::diagnoza
slownik_diagnoza <- PogromcyDanych::diagnozaDict

# statystyki opisowe
summary(dane_diagnoza$lata_nauki_2013)

# histogram, czyli wykres rozkładu zmiennej ilosciowej

ggplot(data = dane_diagnoza, mapping = aes(x = lata_nauki_2013)) + 
  geom_histogram()

# histogram w podziale na zmienną grupującą
# tzw. zmienną niezależną - nominalną 

ggplot(data = dane_diagnoza, 
       mapping = aes(x = lata_nauki_2013, fill = plec)) + 
  geom_histogram()

# statystyki opisowe w podziale na zmienną grupującą 

by(data = dane_diagnoza$lata_nauki_2013, 
   INDICES = dane_diagnoza$plec,
   FUN = summary)

# wykres skrzynkowy - 
# wygodny sposób pokazania zmiennej ilościowej w podziale
# na grupy 

ggplot(data = dane_diagnoza, 
       mapping = aes(x = plec, y = lata_nauki_2013)) +
  geom_boxplot()

ggplot(data = dane_diagnoza, 
       mapping = aes(x = eduk4_2013, y = lata_nauki_2013)) +
  geom_boxplot() + 
  coord_flip()


ggplot(data = dane_diagnoza, 
       mapping = aes(x = eduk4_2013, y = gp64)) +
  geom_boxplot() + 
  coord_flip()

ggplot(data = dane_diagnoza %>% filter(gp64 < 10000), 
       mapping = aes(x = eduk4_2013, y = gp64)) +
  geom_boxplot() + 
  coord_flip()

# proszę za pomocą wykresu skrzynkowego pokazać zależność
# między dochodami a płcią 

ggsave("zarobki_vs_wykszt.jpg")

