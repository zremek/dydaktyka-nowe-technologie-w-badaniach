h 892+1
555-444

# to jest komentarz
# możemy pisać sobie notatki
# które nie są poleceniami dla komputera :) 

# a teraz Pingwiny...

install.packages("palmerpenguins")
install.packages("tidyverse")
library(palmerpenguins)
library(tidyverse)

pingwiny <- palmerpenguins::penguins

ggplot(
  data = pingwiny, 
  mapping = aes(x = flipper_length_mm, 
                y = body_mass_g)) + 
    geom_point(aes(color = species)) + 
  labs(
    title = "Masa ciała a długość płetwy pingwinów",
    x = "Długość płetwy [mm]", 
    y = "Masa ciała [g]", 
    color = "Gatunek", 
    caption = "opracował Remigiusz Żulicki"
  )


