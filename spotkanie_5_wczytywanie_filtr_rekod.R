library(tidyverse)
library(haven) # wczytywanie formatu .sav
library(readxl) # j.w. plików Excel


# 1.	Wczytywanie danych w popularnych formatach do środowiska R ####

## plik .csv

gtrends <- read_csv(file = "multiTimeline(2).csv", 
           skip = 2) # omijamy dwa pierwsze wiersze

summary(gtrends)

### poprawmy nazwy zmiennych

summary(gtrends$`Pierre Bourdieu: (Cały świat)`) # nazwa zawiera m.in spacje

pattern <- ": \\(Cały świat\\)"

names(gtrends) <- tolower( # tylko małe litery
  str_remove(string = names(gtrends), pattern = pattern)) # usuń fragment

names(gtrends) <- str_replace(string = names(gtrends), # zamień
                              pattern = " ", # spację
                              replacement = "_") # na tzw. podłogę

summary(gtrends$pierre_bourdieu)

# plik .xlsx

urbanpop_1 <- read_xlsx(path = "urbanpop.xlsx", sheet = 1) # pierwszy arkusz
urbanpop_2 <- read_xlsx(path = "urbanpop.xlsx", sheet = 2) # drugi
urbanpop_3 <- read_xlsx(path = "urbanpop.xlsx", sheet = 3) # trzeci

urbanpop <- bind_cols(urbanpop_1,
                      urbanpop_2[, -1],
                      urbanpop_3[, -1], ) # sklejamy dane

urbanpop_long <- pivot_longer(data = urbanpop, # przechodzimy do postaci "długiej"
                              cols = !country,
                              names_to = "year",
                              values_to = "urban_population")

urbanpop_long <- mutate(urbanpop_long, # zapisujemy rok jako datę
                        year = as.Date(paste(year, "01", "01", sep = "-")))

ggplot(data = filter(urbanpop_long, country == "Poland"), # tylko Polska
       mapping = aes(x = year,
                     y = urban_population)) +
  geom_line() # wykres liniowy

# plik .sav czyli format IBM SPSS

papierosy_pochp <- read_sav("papierosy_pochp.sav")

summary(papierosy_pochp) # zmienne kategorialne są na razie jako liczby...
# ... z etykietami

head(papierosy_pochp)

papierosy <- haven::as_factor(papierosy_pochp)

table(papierosy_pochp$w1_kaszel,
      papierosy_pochp$wiek_przedzial)

table(papierosy$w1_kaszel,
      papierosy$wiek_przedzial)

# 2.	Filtrowanie ####

# filtrowanie to wybór wierszy ze zbioru danych

# sposób "tradycyjny" z [] - tylko osoby w wieku 18 - 24 lata: 

papierosy[papierosy$wiek_przedzial == "18 - 24 lata", ]

# sposób wygodniejszy z pakietem tidyverse, filter()

filter(papierosy, wiek_przedzial == "18 - 24 lata")

# ten sam wynik z operatorem pipe, wygodniejszy zapis
papierosy %>% filter(wiek_przedzial == "18 - 24 lata") 

papierosy %>% filter(wiek_przedzial == "18 - 24 lata", # tylko ta kategoria
                     w1_pap_dzien > 30) # i więcej niż 30 papierosów

papierosy %>% filter(between(w1_pap_dzien, 10, 15)) # między 10 a 15

gtrends %>% 
  filter(between(tydzień,
                 left = as.Date("2022-01-01"),
                 right = as.Date("2022-12-31"))) # działa także dla dat :)

papierosy %>% filter(wiek_przedzial == "35 - 54 lata", 
                     w1_kaszel == "tak", 
                     w2_kaszel == "tak")

# 3.	Wybór zmiennych ####

# sposób tradycyjny z []

papierosy[, 1] # pierwsza zmienna
papierosy[, -1] # bez pierwszej
papierosy[, 2:4] # od drugiej do czwartej

# sposób z tidyverse, select()

papierosy %>% select(w1_pap_dzien) # jedna zmienna o wskazanej nazwie

papierosy %>%
  select(w1_pap_dzien, w2_pap_dzien) %>% # dwie j.w.
  summary() # a następnie podsumowanie

papierosy %>% 
  select(starts_with("w1")) # wybierz zmienne z nazwami zaczynającymi się od w1

papierosy %>% 
  select_if(is.factor) # wybierz tylko zmienne kategorialne

# 4.	Rekodowanie i zmienne pochodne #### 

## najwygodniejszą opcją jest użycie funkcji mutate() z pakietu tidyverse

# rekodowanie to zmiana kategorii zmiennej
 
table(papierosy$wiek_przedzial) # podgląd kategorii

papierosy <- papierosy %>% mutate(
  wiek_2 = fct_recode( # funkcja rekodująca
    .f = wiek_przedzial, # zmienna źródłowa
    "18 - 34 lata" = "18 - 24 lata", # nowa kategoria = stara kategoria
    "18 - 34 lata" = "25 - 34 lata"
    )
  )

## oglądamy wynik naszego rekodu
ggplot(data = papierosy,
       mapping = aes(x = wiek_2, fill = wiek_przedzial)) +
  geom_bar()


# zmienne pochodne to zmienne obliczone na podstawie już istniejących

papierosy %>% mutate(
  roznica_pap_dzien = w2_pap_dzien - w1_pap_dzien) %>% # odejmujemy 
  select(contains("pap_dzien")) # wybieramy zmienne zawierające "pap_dzien"


papierosy <- papierosy %>% mutate(
  kaszel_zmiana = paste(w1_kaszel, w2_kaszel, sep = "_") # sklejamy wartości
)

table(papierosy$kaszel_zmiana) # podsumowujemy zmienną pochodną 

# !!! zadanie samodzielne: #####

# proszę z danych urbanpop w postaci długiej odfiltrować tylko Szwajcarię,
# zaś odfiltrowany zbiór danych zapisać jako obiekt o nazwie
# szwajcaria_urbanpop
# 
# kod z rozwiązaniem proszę przesłać mi na czacie MS Teams



