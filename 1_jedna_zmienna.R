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

# oglądamy dane 
dim(dane_diagnoza) # ile wierszy i ile kolumn
str(dane_diagnoza) # struktura zbioru, typy danych
summary(dane_diagnoza) # statystyki opisowe wszystkich zmiennych

# wygodna funkcja do podsumowania danych sondażowych z pakietu sjPlot
sjPlot::view_df(x = dane_diagnoza, show.frq = TRUE, show.prc = TRUE,
                show.na = TRUE)

# 2. Wizualizacja i analiza jednej zmiennej nominalnej lub porządkowej ####

# 
