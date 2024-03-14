333+222

install.packages("tidyverse")
install.packages("palmerpenguins")

library(tidyverse)
library(palmerpenguins)

pingwiny <- palmerpenguins::penguins







# to będzie później :) 
ggplot(data = pingwiny, 
       mapping = aes(x = flipper_length_mm, 
                     y = body_mass_g)) + 
  geom_point()

# na razie nie działa w sali T201 :(
# ... ale w domku powinno działać!!! 


################


# pierwszy wykres - funkcja plot()
plot(pingwiny$flipper_length_mm, 
     pingwiny$body_mass_g)


# pierwsze podsumowanie - funkcja summary()

summary(pingwiny)

# pierwsza tabela - funkcja table()

table(pingwiny$species) # raczej do częstości
# zmiennej kategorialnej 

table(pingwiny$flipper_length_mm)
# a nie do liczbowej

table(pingwiny$island)

prop.table(table(pingwiny$island))

płeć_pingwiny <- table(pingwiny$sex)

płeć_pingwiny

prop.table(płeć_pingwiny)

# zadanie: 

# proszę przygotować tabelę częstości
# z danych pingwiny
# kolumna dotycząca gatunku pingwina
# jedną linię kodu - rozwiązanie
# proszę przesłać mi na czacie MS Teams 




