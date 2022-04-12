library(tidyverse)
library(sjPlot)
library(PogromcyDanych)
library(expss) # to jest nowy pakiet, trzeba będzie zainstalować 

# wizualizacja i analiza zależności między dwiema zmiennymi 

# zaczniemy od zmiennych nominalnych 

# przypisujemy dane do obiektu 

dane_diagnoza <- PogromcyDanych::diagnoza

# najpierw pokażemy jedną zmienną 

ggplot(data = dane_diagnoza, mapping = aes(x = eduk4_2013)) + 
  geom_bar() + 
  coord_flip()

# dodamy drugą zmienną 

ggplot(data = dane_diagnoza,
       mapping = aes(x = eduk4_2013, fill = plec)) + 
  geom_bar() + 
  coord_flip()

# słupki obok siebie - pozycja "dodge"

ggplot(data = dane_diagnoza,
       mapping = aes(x = eduk4_2013, fill = plec)) + 
  geom_bar(position = "dodge") + 
  coord_flip()

# skumulowany 100% - pozycja "fill" 


ggplot(data = dane_diagnoza,
       mapping = aes(x = eduk4_2013, fill = plec)) + 
  geom_bar(position = "fill") + 
  coord_flip()

# przestawimy zmienne, 
# aby pokazać, że 
# poziom wykształcenia jest zmienną zależną 
# a płeć jest zmienną niezależną 

ggplot(data = dane_diagnoza,
       mapping = aes(x = plec, fill = eduk4_2013)) + 
  geom_bar(position = "fill") + 
  coord_flip()

# tabele 

# częstość jednej zmiennej 

table(dane_diagnoza$eduk4_2013, useNA = "always")

# tabela dwóch zmiennych

table(dane_diagnoza$eduk4_2013, dane_diagnoza$plec,
      useNA = "always")

tabelka <- table(dane_diagnoza$eduk4_2013, dane_diagnoza$plec,
      useNA = "always")

tabelka

prop.table(tabelka, margin = 2)

# elegancka tabelka z pakietu expss 

expss_output_viewer()

dane_diagnoza %>% 
  tab_cells(eduk4_2013) %>% 
  tab_cols(plec) %>% 
  tab_stat_cases() %>%
  tab_stat_cpct() %>% 
  tab_pivot(stat_position = "inside_columns")

# proszę pokazać w dowolny sposób
# jak odpowiedzi na pytanie gp29 zależą
# od płci badanych 


