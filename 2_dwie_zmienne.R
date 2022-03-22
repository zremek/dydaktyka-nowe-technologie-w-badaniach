library(tidyverse)
library(sjPlot)
library(PogromcyDanych)
library(expss)

# Wizualizacja i analiza zależności między dwiema zmiennymi nominalnymi #### 

# najpierw przypiszmy dane do obiektu (zmiennej w R)

dane_diagnoza <- PogromcyDanych::diagnoza

opis_diagnoza <- PogromcyDanych::diagnozaDict

# na wykresach słupkowych w ggplot możemy łatwo dodać podział na grupy
# dodając drugą zmienną do argumentu "fill = " w funkcji aes()

ggplot(data = dane_diagnoza, mapping = aes(x = eduk4_2013)) + # jedna zmienna
  geom_bar() + 
  coord_flip() # obracamy dla lepszej czytelności etykiet

ggplot(data = dane_diagnoza,
       mapping = aes(x = eduk4_2013, fill = plec)) + # dwie zmienne
  geom_bar() + 
  coord_flip()
# domyślnie słupki są ustawione na sobie (position = "stack")

# przypisanie do obiektu, dzięki temu zaoszczędzamy sobie pracy, 
# ponieważ nie trzeba kopiować tej części do kolejnych wersji wykresu

x_eduk_fill_plec <- ggplot(data = dane_diagnoza,
                           mapping = aes(x = eduk4_2013, fill = plec))

x_eduk_fill_plec + 
  geom_bar(position = "dodge") + # słupki obok siebie
  coord_flip()

x_eduk_fill_plec +
  geom_bar(position = "fill") + # słupki skumulowane do 100%
  coord_flip()

# odwróćmy konstrukcję wykresu
x_plec_fill_eduk <- ggplot(data = dane_diagnoza, 
                           mapping = aes(x = plec, fill = eduk4_2013)) # dwie zmienne
  
x_plec_fill_eduk +
  geom_bar(position = "stack") + # domyślne ułożenie słupków
  coord_flip()


x_plec_fill_eduk +
  geom_bar(position = "dodge") + 
  coord_flip()

# poniższa konstrukcja wykresu skumulowanego najbardziej czytelnie pokazuje,
# jak poziom wykształcenia zależy od płci

x_plec_fill_eduk +
  geom_bar(position = "fill") + 
  coord_flip()

# pomijamy liczebności bezwzględne, i każdą grupę zmiennej zależnej, 
# czyli płci, traktujemy jako 100%. Dzięki temu wyraźnie widzimy, że 
# np. wykszt. zasadnicze zawodowe/gimnazjum występowało częściej 
# u mężczyzn (około 30%) niż u kobiet (około 20%)

# inny, mało popularny typ wykresu, konstrukcja zbliżona do tabeli krzyżowej
ggplot(data = dane_diagnoza, 
       mapping = aes(x = plec, y = eduk4_2013)) + 
  geom_count() + 
  scale_size_area()

# klasyczny i bardzo czytelny sposób wizualizacji dwóch zmiennych nominalnych
# to tabele krzyżowe 

# najprostsza tabela

table(dane_diagnoza$eduk4_2013, dane_diagnoza$plec)

table(dane_diagnoza$eduk4_2013, dane_diagnoza$plec, useNA = "always") # wymuszamy pokazanie NA

tab_eduk_plec <- table(dane_diagnoza$eduk4_2013, dane_diagnoza$plec, useNA = "always")

prop.table(tab_eduk_plec, margin = 2) # tabela %, "margin = 2" oznacza % w kolumnach

prop.table(tab_eduk_plec, margin = 2) %>% round(digits = 2) # z zaokrągleniem

# elegancka tabela 



# Wizualizacja i analiza zależności między dwiema zmiennymi: nominalna vs. ilościowa #### 

## zmienną nominalną będziemy traktowali jako zmienną niezależną
## tzn. grupującą - za jej pomocą "kroimy" zmienną zależną 

## zmienna ilościowa jest zmienną zależną
## ta zmienna przechowuje wyniki pomiaru, który chcemy "pokroić" na grupy 

