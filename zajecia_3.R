# to nie jest kod
# to jest komentarz
# służy do czytania przez ludzi
# a nie jest interpretowany przez komputer

table(moje_dane$gatunek_zwierze)

# zapiszemy tabelkę jako obiekt

tab_zwierze <- table(moje_dane$gatunek_zwierze)

# teraz robimy wykresy
# 1. wykres słupkowy

barplot(tab_zwierze)

# 2. histogram

hist(moje_dane$waga_zwierze)

?hist

# zainstalujemy nowy pakiet 

install.packages("PogromcyDanych") # raz i już

# ładujemy pakiet 

library(PogromcyDanych) # dla każdej sesji 

# jak dostać się do funkcji lub danych z pakietu
# zastosować :: 

graphics::hist(moje_dane$waga_zwierze)

PogromcyDanych::diagnoza

# Zadanie: 
# proszę zapisać ten zbiór danych
# jako obiekt dane_diagnoza 

dane_diagnoza <- PogromcyDanych::diagnoza

# podsumujemy na wykresie zmienną
# lata_nauki_2013

h <- hist(dane_diagnoza$lata_nauki_2013)

summary(h)
h$breaks
h$counts
