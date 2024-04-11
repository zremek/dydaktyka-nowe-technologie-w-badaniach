library(tidyverse)
library(PogromcyDanych)

# ładowanie danych #### 

dane_diagnoza <- PogromcyDanych::diagnoza

słownik_diagnoza <- PogromcyDanych::diagnozaDict


# filtrowanie #### 

# znajdźmy respondentów, dla których liczba lat nauki
# jest wyższa niż wiek 


dane_błąd <- dane_diagnoza %>% # ctrl + shift + M daje %>% 
  filter(lata_nauki_2013 > wiek2013) %>% 
  select(imie_2011, lata_nauki_2013, wiek2013)

# zapis danych do pliku #### 

write_csv(x = dane_błąd, file = "dane_błąd_nauka_wiek.csv")


# podsumowywanie jednej zmiennej #### 

## tabela częstości ####

table(dane_diagnoza$gp3)

## wykres słupkowy #### 

barplot(table(dane_diagnoza$gp3))

table(dane_diagnoza$gp3) %>% barplot() # "rurka" zamiast funkcji w funkcji

ggplot(data = dane_diagnoza, mapping = aes(x = gp3)) + 
  geom_bar() + # rodzaj wykresu - słupkowy
  coord_flip() # obrót osi 

## statystyki opisowe #### 

summary(dane_diagnoza$lata_nauki_2013)

## histogram #### 

hist(dane_diagnoza$lata_nauki_2013)

ggplot(data = dane_diagnoza,
       mapping = aes(x = lata_nauki_2013)) + 
  geom_histogram()

# jak szukać pomocy?
?geom_histogram

# współzmienność #### 

## tabela krzyżowa #### 

table(dane_diagnoza$gp3,  # zmienna w wierszach - zależna
      dane_diagnoza$plec) # w kolumach - niezależna 

prop.table(
  table(dane_diagnoza$gp3,
        dane_diagnoza$plec), 
  margin = 2 # 2 oznacza % w kolumnach 
) * 100       # mnożymy przez 100 dla czytelności

## wykres słupkowy dwóch zmiennych #### 

ggplot(data = dane_diagnoza, 
       mapping = aes(x = plec,      # zmienna niezależna
                     fill = gp3)) + # zależna 
  geom_bar() # domyślnie słupki z liczbami bezwzględnymi 


ggplot(data = dane_diagnoza, 
       mapping = aes(x = plec,      # zmienna niezależna
                     fill = gp3)) + # zależna 
  geom_bar(position = "fill") # słupki skumulowane do 100% 


## wykres pudełko-wąsy czyli boxplot #### 

# służy do analizy współzmienności
# zmiennej kategorialnej i numerycznej 

ggplot(data = dane_diagnoza, 
       mapping = aes(x = gp3,               # z. kategorialna (raczej niezależna)
                     y = lata_nauki_2013)) + # numeryczna (zależna)
  geom_boxplot() + 
  coord_flip()


## wykres punktowy - rozrzutu #### 

ggplot(data = dane_diagnoza, 
       mapping = aes(x = wiek2013,           # z. niezależna
                     y = lata_nauki_2013)) + # zależna  
  geom_point()

# wykres punktowy służy do badania współzmienności
# dwu zmiennych numerycznych 




















