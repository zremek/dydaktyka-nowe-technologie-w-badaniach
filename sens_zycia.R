# 0. Zasady zaliczenia: Nowe technologie w badaniach społecznych ####
# kolokwium 6. kwietnia 2022

# Proszę przygotować działający skrypt w R, 
# wykonując kolejne zadania. 
# Skrypt ma działać w kolejności "z góry na dół" -
# od pierwszej linii kodu do ostatniej.

# Proszę nie zmieniać przygotowanych przeze mnie 
# treści ani układu zadań (w komentarzach). 

# Proszę zwrócić uwagę, jaki wynik należy przedstawić. 

# Pracujemy na danych z "Diagnozy Społecznej", pakiet PogromcyDanych.

# Powodzenia! RŻ

########## Zadania ###########################################

# install.packages("tidyverse")
# install.packages("PogromcyDanych")

library(tidyverse)
library(PogromcyDanych)

## 1. Proszę sprawdzić trendy wyszukiwania w wyszukiwarce Google ####
# dla R jako "język programowania" i SPSS jako "oprogramowanie"
# na całym świecie, ostatnie 12 miesięcy, za pomocą Google Trends.

# Wynik 1: proszę w komentarzu podać działający link do Google Trends,
# z uzyskanymi wynikami. Przykład: 
# https://trends.google.pl/trends/explore?date=now%207-d&geo=PL&q=%2Fg%2F11j4ffrt4k,%2Fg%2F11jwjh2txd 
# Odpowiedź
# https://trends.google.pl/trends/explore?q=%2Fm%2F0212jm,%2Fm%2F018fh1



## 2. Proszę obliczyć statystyki opisowe #### 
# dla pytania "Jaki jest Pana wzrost?".
# Interesują nas: minimum, maksimum, mediana, 1. i 3. kwartyl, średnia
# arytmetyczna i liczba braków danych. 


dane_diagnoza <- PogromcyDanych::diagnoza
slownik_diagnoza <- PogromcyDanych::diagnozaDict

summary(dane_diagnoza$gp60)

# Wynik 2: proszę użyć jednej funkcji, wynik jej działania 
# zawierający wszystkie wymagane statystyki proszę przypisać 
# za pomocą <- do nazwy "wynik_1".

Wynik_1 <- summary(dane_diagnoza$gp60)


## 3. Proszę przedstawić częstości odpowiedzi na pytanie #### 
# "lubię kupować"

# Wynik 3: proszę zaprezentować dane w tabeli i przypisać tabelę do 
# nazwy "wynik_2".

table(dane_diagnoza$gp54_05, useNA = 'always') 

wynik_2 <- table(dane_diagnoza$gp54_05, useNA = 'always') 


## 4. Proszę przedstawić zależność za pomocą wykresu pudełkowego ####
# zmienna zależna: Ile przeciętnie godzin w tygodniu Pani / Pan pracuje,
# zmienna niezależna: płeć. 

# Wynik 4: proszę przypisać wykres do nazwy "wynik_4"


ggplot(data = dane_diagnoza,
       mapping = aes(x=gp113, y=plec )) +
  geom_boxplot()

wynik_4 <- ggplot(data = dane_diagnoza,
                  mapping = aes(y=gp113, x=plec )) +
  geom_boxplot()


## 5. Proszę przedstawić zależność za pomocą dowolnego wykresu ####
# interesuje nas to, czy odpowiedzi na pytanie "życie ma sens"
# zależą od poziomu wykształcenia badanych. 

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


# Wynik 5: za pomocą polecenia ggsave() proszę zapisać wykres do pliku .jpg
# pod nazwą "wynik_5.jpg". 

ggsave("Wynik_5.jpg")


# Jak przesłać swoją pracę? ##############################################

# Proszę o przesłanie do mnie na czacie MS Teams 
# pliku skryptu w formacie .R, 
# nazwa: imię_nazwisko_kolokwium_0604.R 

# Dziękuję! 
