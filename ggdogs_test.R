# https://github.com/R-CoderDotCom/ggdogs
# https://r-charts.com/ 
library(tidyverse) # ggplot2 jest częścią tidyverse

# install.packages("remotes")
# remotes::install_github("R-CoderDotCom/ggdogs@main")
library(ggdogs)

grid <- expand.grid(1:5, 5:1)

df <- data.frame(x = grid[, 1],
                 y = grid[, 2],
                 image = c("doge", "doge_strong", "chihuahua", "eyes", "gabe",
                           "glasses", "tail", "surprised", "thisisfine", "hearing",
                           "pug", "ears", "husky","husky_2", "chilaquil", "santa",
                           "bryan", "vinny", "jake", "lucy", "puppie", "goofy",
                           "snoopy", "scooby", "suspicious"))

ggplot(df) +
  geom_dog(aes(x, y, dog = image), size = 3) +
  geom_label(aes(x, y - 0.25, label = image), size = 4) +
  xlim(c(0.25, 5.5)) + 
  ylim(c(0.25, 5.5))

library(PogromcyDanych)
View(PogromcyDanych::diagnozaDict)

ggplot(data = PogromcyDanych::diagnoza, 
       aes(x = gp64, y = gp113, dog = "glasses")) + 
  geom_dog()

