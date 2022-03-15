# spotkanie 4. 

# Analiza danych sondażowych w języku GNU R część 1. 

# 3. Wizualizacja i analiza jednej zmiennej ilościowej 
# 4. Statystyki opisowe jednej zmiennej ilościowej

# 1. Zapoznanie ze środowiskiem GNU R i RStudio #### 

# ładujemy potrzebne pakiety - gotowe funkcje i dane 
library(tidyverse)
library(PogromcyDanych)
library(sjPlot)

# oglądamy dane w widoku tabelkowym
View(PogromcyDanych::diagnoza)
View(PogromcyDanych::diagnozaDict)

# przypisujemy dane do zmiennych (patrz panel "Environment")
dane_diagnoza <- diagnoza
slownik_diagnoza <- diagnozaDict

### aby uzyskać "<-" wciśnij Alt/Option + - (znak minus)

# oglądamy dane 
dim(dane_diagnoza) # ile wierszy i ile kolumn
str(dane_diagnoza) # struktura zbioru, typy danych
summary(dane_diagnoza) # statystyki opisowe wszystkich zmiennych

# wygodna funkcja do podsumowania danych sondażowych z pakietu sjPlot
sjPlot::view_df(x = dane_diagnoza, show.frq = TRUE, show.prc = TRUE,
                show.na = TRUE)

# 2. Wizualizacja i analiza jednej zmiennej nominalnej lub porządkowej ####

# skupmy się na zmiennych: 
## plec - płeć
## eduk4_2013 - Poziom wykształcenia:4 kategorie 2013
## gp3 - p3 Jak ocenia Pan swoje cale dotychczasowe zycie

# wykresy słupkowe z pakietu ggplot, części tidyverse
# lektura: https://r4ds.had.co.nz/data-visualisation.html#statistical-transformations 

ggplot(data = dane_diagnoza, mapping = aes(x = plec)) + 
  geom_bar()

ggplot(data = dane_diagnoza, mapping = aes(x = eduk4_2013)) + 
  geom_bar() + 
  coord_flip() # przekręcamy wykres dla czytelności 

ggplot(dane_diagnoza, aes(gp3)) + geom_bar() + 
  coord_flip()

# czy ten wykres może być ładniejszy? tak! 

wykres_gp3 <- ggplot(dane_diagnoza, aes(gp3))
wykres_gp3 + geom_bar(aes(fill = gp3)) + coord_flip() # kolorowe kategorie
wykres_gp3 + geom_bar(aes(fill = gp3)) + coord_polar() # kolor i tzw. coxcomb

wykres_gp3 + geom_bar(aes(fill = gp3)) + coord_flip() + # podpisy 
  labs(title = "Jak ocenia Pan/i swoje całe dotychczasowe życie?",
       caption = "źródło: Diagnoza Społeczna 2013", 
       x = "",
       y = "liczebność [n = 38 461]") + 
  guides(fill = "none") + 
  theme_minimal() # zmieniamy styl całego wykresu 

# tabelki częstości 

table(dane_diagnoza$plec)
prop.table(table(dane_diagnoza$plec))
table(dane_diagnoza$plec, useNA = "always")

# estetyczne i informatywne tabelki z pakietu sjmisc 
sjmisc::frq(dane_diagnoza %>% # wybór zmiennych z select()
              select(plec, eduk4_2013, gp3), out = "viewer")

# by uzyskać "%>%" (pipe operator) użyj Ctrl/Cmd + Shift + M  

# 3. Wizualizacja i analiza jednej zmiennej ilościowej #### 

# skupmy się na:
## gp64 - Pana wlasny (osobisty) dochod miesieczny netto (na reke)
## gp113 - p113 Ile przecietnie godzin w tygodniu Pan pracuje

summary(dane_diagnoza$gp64)
summary(dane_diagnoza$gp113)

mean(dane_diagnoza$gp64) # nie działa?
mean(dane_diagnoza$gp64, na.rm = TRUE)
median(dane_diagnoza$gp64, na.rm = TRUE)

summary(dane_diagnoza %>% select(gp64, gp113))

ggplot(dane_diagnoza, aes(gp64)) + geom_histogram()
ggplot(dane_diagnoza, aes(gp113)) + geom_histogram()

wykres_gp113 <- ggplot(dane_diagnoza, aes(gp113))
wykres_gp113 + geom_density()

