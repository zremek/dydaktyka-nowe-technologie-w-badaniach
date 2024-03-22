# przypomnimy sobie jak zrobić rozkład jednej zmiennej

library(PogromcyDanych)
library(tidyverse)

# jeżeli nie działa library
# zainstaluj pakiety :) 

# install.packages("tutaj idzie nazwa pakietu")

d <- PogromcyDanych::diagnoza

# przypominamy sobie podsumowanie jednej
# zmiennej kategorialnej 

table(d$plec)

barplot(table(d$plec))

ggplot(data = d,
       mapping = aes(x = plec)) + geom_bar()

# podsumowanie jednej zmiennej numerycznej
# przypomnienie

summary(d$wiek2013)

hist(d$wiek2013)

ggplot(data = d,
       mapping = aes(x = wiek2013)) +
  geom_histogram(binwidth = 5)

# teraz drugi poziom wtajemniczenia:
# analiza dwóch zmiennych
# "współzmienność" 

# pytanie: czy ludzie różnej płci
# są w podobny czy różnym wieku? 

# hipoteza: wiek zależy od płci
# wiek - zmienna zależna
# płeć - zmienna niezależna 

# najlepiej pokazać tę zależność
# wykresem pudełko-wąsy 

ggplot(data = d, 
       mapping = aes(x = plec,      # nie-zal
                     y = wiek2013)) + # zależna
  geom_boxplot()

# płeć to zmienna kategorialna
# a wiek numeryczna
# i do pokazania takej współzmienności
# służy wykres pudełko-wąsy

# pytanie: czy ludzie różnej płci
# podobnie oceniają swoje życie? 

# "jak Pan/Pani ocenia całe swoje 
# dotychczasowe życie?" 

barplot(table(d$gp3))

# tradycyjnie współzmienność
# dwu zmiennych kategorialnych 
# prezentujemy w tabeli krzyżowej 

prop.table(
table(d$gp3, 
      d$plec),
margin = 2)






























