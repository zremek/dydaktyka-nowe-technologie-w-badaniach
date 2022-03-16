library(sjPlot)
library(tidyverse)
library(PogromcyDanych)

# View pozwala otworzyć dane w widoku tabelki 
View(PogromcyDanych::diagnoza)
View(PogromcyDanych::diagnozaDict)

# jak podsumować zbiór danych?
dim(diagnoza)
summary(diagnoza)

# przypisujemy wartość do zmiennej 

dane_diagnoza <- diagnoza
cena <- 100 
podatek <- 20

cena - podatek

# wizualizacja i analiza jednej zmiennej nominalnej 

table(dane_diagnoza$plec, useNA = "always")

prop.table(table(dane_diagnoza$plec, useNA = "always"))

table(dane_diagnoza$eduk4_2013, useNA = "always")

ggplot(data = dane_diagnoza,
       mapping = aes(x = eduk4_2013, fill = eduk4_2013)) +
  geom_bar() + 
  coord_flip()

ggplot(data = dane_diagnoza,
       mapping = aes(x = eduk4_2013, fill = plec)) +
  geom_bar() + 
  coord_flip()

# robimy elegancką tabelę

sjPlot::plot_frq(dane_diagnoza %>% select(eduk4_2013))

sjmisc::frq(dane_diagnoza %>% select(eduk4_2013, plec, gp3), out = "viewer")

# skrót do %>% to Ctrl + Shift + M 

# jeszcze jeden wykres i potem zadanie dla Państwa 

ggplot(data = dane_diagnoza, mapping = aes(x = status9_2013)) + 
  geom_bar() + 
  coord_flip()

# zadanie - proszę wykonać wykres słupkowy dla województwa zamieszkania
# proszę w czacie na Teamsach wysłać obrazek
# oraz kod, którym wygenerowano wykres 

# jak szukać pomocy? 

?diagnoza 

?library


