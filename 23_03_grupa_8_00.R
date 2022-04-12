library(tidyverse)
library(sjPlot)
library(PogromcyDanych)
library(expss) # to jest nowy pakiet 

# wizualizacja i analiza zależności między dwiema zmiennymi 

# zaczniemy od zmiennych nominalnych 

dane_diagnoza <- PogromcyDanych::diagnoza # przypisanie

# jedna zmienna 
ggplot(data = dane_diagnoza, mapping = aes(x = eduk4_2013)) + 
  geom_bar() +
  coord_flip()

# a teraz dwa pytania = dwie zmienne 

ggplot(data = dane_diagnoza,
       mapping = aes(x = eduk4_2013, fill = plec)) + 
  geom_bar() +
  coord_flip()

# inny układ słupków
# tzw. pozycja "dodge" - słupki obok siebie

ggplot(data = dane_diagnoza,
       mapping = aes(x = eduk4_2013, fill = plec)) + 
  geom_bar(position = "dodge") +
  coord_flip()

# słupki skumulowane do 100% - pozycja "fill"

ggplot(data = dane_diagnoza,
       mapping = aes(x = eduk4_2013, fill = plec)) + 
  geom_bar(position = "fill") +
  coord_flip()

# wykres skumulowany ponownie,
# lepsze pokazanie, jak poziom wykształcenia
# zależy od płci

## poziom wykształcenia = zmienna zależna 
## płeć = zmienna niezależna 

ggplot(data = dane_diagnoza,
       mapping = aes(x = plec, fill = eduk4_2013)) + 
  geom_bar(position = "fill") +
  coord_flip()

# tabele częstości i tabele krzyżowe

# częstości jednej zmiennej 
table(dane_diagnoza$eduk4_2013, useNA = "always")

sjmisc::frq(dane_diagnoza$eduk4_2013)

# tabela częstości dwóch zmiennych 

table(dane_diagnoza$eduk4_2013,
      dane_diagnoza$plec,
      useNA = "always")

tabelka_eduk_plec <- table(dane_diagnoza$eduk4_2013,
      dane_diagnoza$plec,
      useNA = "always")

prop.table(tabelka_eduk_plec, margin = 2)

# elegancka tabela krzyżowa 
# z częstościami i % 

dane_diagnoza %>% 
  if_na("NA") %>% 
  tab_cells(eduk4_2013) %>% 
  tab_cols(plec, total()) %>% 
  tab_stat_cases() %>% 
  tab_stat_cpct() %>% 
  tab_pivot(stat_position = "inside_columns")

# zadanie 

# proszę pokazać w dowolny sposób
# jak odpowiedzi na pyt. "co jest ważniejsze w życiu" - zmienna gp29 
# zależą od płci badanych 







