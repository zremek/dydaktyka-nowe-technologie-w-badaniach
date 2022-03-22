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

expss::cross_cases(data = dane_diagnoza,
                   cell_vars = eduk4_2013,
                   col_vars = plec) # liczebności bezwzględne - "cases"

expss::cross_cpct(data = dane_diagnoza, # liczebności względne tzn. % w kolumnach
                  cell_vars = eduk4_2013,
                  col_vars = plec, 
                  total_statistic = "u_cpct") 
# uwaga, domyślnie tylko ważne bez NA!

# tabela liczebności bezwzględnych i %, uwzględnia NA, bez pustych wierszy, 
# podsumowanie w wierszach i w kolumnach

expss_output_viewer() # pokazujemy tabelę w karcie "Viewer"

dane_diagnoza %>% # zaczynamy od zbioru danych
  if_na("NA") %>% # każemy pokazać NA jako "NA"
  tab_cells(eduk4_2013) %>% # zmienna zależna (wiersze)
  tab_cols(plec, total()) %>% # zmienna niezależna (kolumny) oraz podsumowanie w kolumnach
  tab_stat_cases(label = "n", total_statistic = "u_cases") %>% # obliczamy licz. bezwzgl., podajemy etykietę i rodzaj podsumowania
  tab_stat_cpct(label = "% kol.", total_statistic = "u_cpct") %>% # j.w. dla % 
  tab_pivot(stat_position = "inside_columns") %>% # sposób wyświetlenia liczebności bezwzgl. i %
  drop_rc() # każemy usunąć puste wiersze 

expss_output_default() # wracamy do domyślnego pokazania tabeli w konsoli 

# Wizualizacja i analiza zależności między dwiema zmiennymi: nominalna vs. ilościowa #### 

## zmienną nominalną będziemy traktowali jako zmienną niezależną
## tzn. grupującą - za jej pomocą "kroimy" zmienną zależną 

## zmienna ilościowa jest zmienną zależną
## ta zmienna przechowuje wyniki pomiaru, który chcemy "pokroić" na grupy 

# wykres skrzynkowy (boxplot), tzw. skrzynka-wąsy

ggplot(data = dane_diagnoza, mapping = aes(x = eduk4_2013, y = lata_nauki_2013)) +
  geom_boxplot()

# jak jest zbudowana skrzynka - https://www.spss-tutorials.com/boxplot-what-is-it/ 

# histogram z podziałem na grupy 
ggplot(data = dane_diagnoza, mapping = aes(x = lata_nauki_2013, fill = eduk4_2013)) +
  geom_histogram()

ggplot(data = dane_diagnoza, mapping = aes(x = lata_nauki_2013, fill = eduk4_2013)) +
  geom_histogram(position = "dodge")

# statystyki opisowe z podziałem na grupy 

# sposób najprostszy

by(data = dane_diagnoza$lata_nauki_2013,
   INDICES = dane_diagnoza$eduk4_2013,
   FUN = summary)

# sposób bardziej elegancki 

dane_diagnoza %>% # zaczynamy od danych
  group_by(eduk4_2013) %>% # wskazujemy zmienną niezależną - grupującą
  summarise(min = min(lata_nauki_2013, na.rm = TRUE), # wskazujemy kolejno jakie podsumowania liczymy - minimum
            med = median(lata_nauki_2013, na.rm = TRUE), # mediana
            mean = mean(lata_nauki_2013, na.rm = TRUE), # średnia arytmetyczna
            max = max(lata_nauki_2013, na.rm = TRUE), # maksimum
            n = n(), # tutaj liczymy częstość 
            NA_n = sum(is.na(lata_nauki_2013))) # częstość NA 

# Trzy zmienne? czemu nie :) #####

x_eduk_fill_plec + 
  geom_bar(position = "fill") + 
  coord_flip() +
  facet_wrap(ggplot2::vars(gp29)) # trzecia zmienna - podział wykresu na panele

ggplot(data = dane_diagnoza,
       mapping = aes(x = eduk4_2013, y = lata_nauki_2013, fill = gp29)) + # trzecia zmienna jako fill
  geom_boxplot() + 
  coord_flip()

# Cztery też są możliwe!
ggplot(data = dane_diagnoza %>% filter(!is.na(plec)), # filtrowanie - płeć bez NA 
       mapping = aes(x = eduk4_2013, y = lata_nauki_2013, fill = gp29)) + # trzecia zmienna jako fill
  geom_boxplot() + 
  coord_flip() + 
  facet_wrap(ggplot2::vars(plec)) # czwarta zmienna - podział wykresu na panele

# Przypadek specjalny - skala Likerta

# możemy wizualizować skale jak każdą zmienną nominalną

ggplot(data = dane_diagnoza, aes(x = gp54_01)) + 
  geom_bar()

ggplot(data = dane_diagnoza, aes(x = gp54_01, fill = plec)) + 
  geom_bar(position = "dodge") + 
  coord_flip()

# możemy skorzystać z specjalnej funkcji pakietu sjPlot

sjPlot::plot_likert(dane_diagnoza %>% 
                      select(gp54_01:gp54_10), # wybór zmiennych
                    cat.neutral = 4, # podajemy środek skali
                    values = "hide") # chowamy etykietki z słupków 

# Zadanie ####
# Proszę pokazać, jak odpowiedzi na pyt. "p29 Co jest wedlug Pana wazniejsze w zyciu?"
# zależą od płci osób uczestniczących w badaniu 
