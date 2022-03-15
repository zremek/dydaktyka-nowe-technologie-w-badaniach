# spotkanie 4. 

# Analiza danych sondażowych w języku GNU R część 1. 

# 1. Zapoznanie ze środowiskiem GNU R i RStudio #### 

# ładujemy potrzebne pakiety - gotowe funkcje i dane 
library(tidyverse)
library(PogromcyDanych)
library(sjPlot)

# oglądamy dane w widoku tabelkowym
View(PogromcyDanych::diagnoza)
View(PogromcyDanych::diagnozaDict)

# pomoc (panel "Help" w RStudio)
?diagnoza

# przypisujemy dane do zmiennych (widzimy je w panelu "Environment")
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
## gp3 - p3 Jak ocenia Pan/i swoje cale dotychczasowe zycie

# wykresy słupkowe z pakietu ggplot, części tidyverse
# lektura: https://r4ds.had.co.nz/data-visualisation.html#statistical-transformations 

ggplot(data = dane_diagnoza, mapping = aes(x = plec)) + 
  geom_bar()

ggplot(data = dane_diagnoza, mapping = aes(x = eduk4_2013)) + 
  geom_bar() + 
  coord_flip() # przekręcamy wykres dla czytelności 

# możemy uprościć zapis argumentów funkcji, opuścić część przed "=" 
ggplot(dane_diagnoza, aes(gp3)) + geom_bar() + 
  coord_flip()

# czy wykres słupkowy może być bardziej estetyczny? tak! 

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
## gp64 - Pani/a wlasny (osobisty) dochod miesieczny netto (na reke)
## gp113 - p113 Ile przecietnie godzin w tygodniu Pan pracuje

ggplot(dane_diagnoza, aes(gp64)) + geom_histogram()
ggplot(dane_diagnoza, aes(gp113)) + geom_histogram()

wykres_gp113 <- ggplot(dane_diagnoza, aes(gp113))

# customisacja histogramu
?geom_histogram

wykres_gp113 + geom_histogram(colour = "white", binwidth = 10)

# podejrzyjmy konkretne wartości
dane_diagnoza %>% 
  select(imie_2011, gp113) %>% 
  filter(gp113 > 80) %>% 
  arrange(-gp113)
  
# tabelka 
table(dane_diagnoza$gp113 > 80)

# gęstość zamiast częstości 
wykres_gp113 + geom_density()

# 4. Statystyki opisowe jednej zmiennej ilościowej #### 

summary(dane_diagnoza$gp64)
summary(dane_diagnoza$gp113)

mean(dane_diagnoza$gp64) # nie działa?
mean(dane_diagnoza$gp64, na.rm = TRUE)
median(dane_diagnoza$gp64, na.rm = TRUE)
median(dane_diagnoza$gp113, na.rm = TRUE)

summary(select(dane_diagnoza, gp64, gp113))

dane_diagnoza %>% # inny zapis, wynik jak w linii 118 
  select(gp64, gp113) %>% 
  summary()

# średnia i mediana na histogramie
md_gp64 <- median(dane_diagnoza$gp64, na.rm = TRUE)
me_gp64 <- mean(dane_diagnoza$gp64, na.rm = TRUE)

ggplot(dane_diagnoza, aes(gp64)) + 
  geom_histogram(binwidth = 1000, fill = "gray", colour = "black") +
  geom_vline(xintercept = md_gp64,      # dodajemy linię
             colour = "blue") +
  annotate("text",                        # dodajemy tekst
           x = 20000,
           y = 8000,
           label = paste("Mediana =", md_gp64),
           colour = "blue",
           size = 5) +
  geom_vline(xintercept = me_gp64,      # dodajemy linię
             colour = "orange") +
  annotate("text",                        # dodajemy tekst
           x = 20000,
           y = 7000,
           label = paste("Średnia =", round(me_gp64, 2)),
           colour = "orange",
           size = 5) + 
  theme_minimal()

# odchylenie standardowe - standard deviation 
sd(dane_diagnoza$gp64, na.rm = TRUE)

# odchylenie standardowe oznacza rozrzut, rozproszenie wartości zmiennej
# odpowiada na pytanie: o ile średnio wartości są oddalone od średniej? 

# pomocnik wizualny w zrozumieniu sd 
# https://www.geogebra.org/m/qvuejma7 

# zadanie ##### 
# proszę przedstawić na wykresie rozkład zmiennej "status społeczno-zawodowy" 
