library(tidyverse)
library(PogromcyDanych)
library(sjPlot)

# library() ładuje potrzebne funkcje i dane z pakietów 

View(PogromcyDanych::diagnoza)
View(PogromcyDanych::diagnozaDict)
?diagnoza
?library

# drugi poziom wtajemniczenia programistycznego...
# tum dum dum dum!!!!!

# przypisujemy dane do zmiennej

dane_diagnoza <- diagnoza

str(dane_diagnoza)

summary(dane_diagnoza)

sjPlot::view_df(x = dane_diagnoza, show.frq = TRUE, show.prc = TRUE,
                show.na = TRUE)

# wizualizacji i analiza jednej zmiennej nominalnej 

table(dane_diagnoza$plec)

ggplot(data = dane_diagnoza, mapping = aes(x = plec)) + 
  geom_bar()

ggplot(data = dane_diagnoza, mapping = aes(x = gp3, fill = gp3)) + 
  geom_bar() + 
  coord_flip()

ggplot(dane_diagnoza, aes(plec)) + geom_bar()

# zadanie: proszę zrobić wykres słupkowy dla zmiennej eduk4_2013 
# proszę na Teamsach przesłać mi obrazek oraz kod 

