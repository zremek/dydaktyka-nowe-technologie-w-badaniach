# pomysł na zajęcia 2023:
# zacząć bez pakietów i bez RStudio, tylko base R wg. fastR
# https://github.com/matloff/fasteR 
# na pierwszych zajęciach zrobić ręcznie prostą ramkę danych, 
# może z książki Statystyka dla Socjologów
# uwaga na typ danych jak robię cbind! sprawdzić 

# do przećwiczenia klasyka na kwartecie Anscombe'a
#  data("anscombe", package = "datasets")

##-- now some "magic" to do the 4 regressions in a loop:
ff <- y ~ x
mods <- setNames(as.list(1:4), paste0("lm", 1:4))
for(i in 1:4) {
  ff[2:3] <- lapply(paste0(c("y","x"), i), as.name)
  ## or   ff[[2]] <- as.name(paste0("y", i))
  ##      ff[[3]] <- as.name(paste0("x", i))
  mods[[i]] <- lmi <- lm(ff, data = anscombe)
  print(anova(lmi))
}

## See how close they are (numerically!)
sapply(mods, coef)
lapply(mods, function(fm) coef(summary(fm)))

## Now, do what you should have done in the first place: PLOTS
op <- par(mfrow = c(2, 2), mar = 0.1 + c(4,4,1,1), oma =  c(0, 0, 2, 0))
for (i in 1:4) {
  ff[2:3] <- lapply(paste0(c("y","x"), i), as.name)
  plot(ff, data = anscombe, col = "red", pch = 21, bg = "orange", cex = 1.2,
       xlim = c(3, 19), ylim = c(3, 13))
  abline(mods[[i]], col = "blue")
}
mtext("Anscombe's 4 Regression data sets", outer = TRUE, cex = 1.5)
par(op)


# następnie tidyverse i dane gss_cat
library(tidyverse)
forcats::gss_cat %>% glimpse()
## programowanie jest dla wszystkich o ile znają angielski :) 
# potem PogromcyDanych

# pokazać wczytywanie danych z pliku csv i zapis do csv oraz RData 

# na przedostatnich zajęciach zrobić połączenie zdobytych umiejętności
# pobrać dane z gtrends i zrobić piękny wykres liniowy 
# https://www.datacareer.de/blog/accessing-google-trends-with-r-a-example-with-gtrendsr/ 
# https://trends.google.com/trends/explore?date=today%205-y&q=%2Fm%2F0rls8,%2Fm%2F04xm_,%2Fm%2F01hk3m,%2Fm%2F09j84
# https://trends.google.com/trends/api/widgetdata/multiline/csv?req=%7B%22time%22%3A%222018-03-08%202023-03-08%22%2C%22resolution%22%3A%22WEEK%22%2C%22locale%22%3A%22pl%22%2C%22comparisonItem%22%3A%5B%7B%22geo%22%3A%7B%7D%2C%22complexKeywordsRestriction%22%3A%7B%22keyword%22%3A%5B%7B%22type%22%3A%22ENTITY%22%2C%22value%22%3A%22%2Fm%2F0rls8%22%7D%5D%7D%7D%2C%7B%22geo%22%3A%7B%7D%2C%22complexKeywordsRestriction%22%3A%7B%22keyword%22%3A%5B%7B%22type%22%3A%22ENTITY%22%2C%22value%22%3A%22%2Fm%2F04xm_%22%7D%5D%7D%7D%2C%7B%22geo%22%3A%7B%7D%2C%22complexKeywordsRestriction%22%3A%7B%22keyword%22%3A%5B%7B%22type%22%3A%22ENTITY%22%2C%22value%22%3A%22%2Fm%2F01hk3m%22%7D%5D%7D%7D%2C%7B%22geo%22%3A%7B%7D%2C%22complexKeywordsRestriction%22%3A%7B%22keyword%22%3A%5B%7B%22type%22%3A%22ENTITY%22%2C%22value%22%3A%22%2Fm%2F09j84%22%7D%5D%7D%7D%5D%2C%22requestOptions%22%3A%7B%22property%22%3A%22%22%2C%22backend%22%3A%22IZG%22%2C%22category%22%3A0%7D%2C%22userConfig%22%3A%7B%22userType%22%3A%22USER_TYPE_LEGIT_USER%22%7D%7D&token=APP6_UEAAAAAZAnJLoY0xyIiFChdYLvCshxiZcNhiHM2&tz=-60 to ściąga csv 

library(PogromcyDanych)
dane_diagnoza <- PogromcyDanych::diagnoza

t1 <- table(dane_diagnoza$gp29, dane_diagnoza$plec, useNA = "always")
prop.table(t1, margin = 2)

prop.table(
  table(dane_diagnoza$gp29,  # zmienna zależna
        dane_diagnoza$plec), # zmienna niezależna 
  margin = 2)

barplot(t1)
barplot(prop.table(t1, margin = 2))

# pakiet ggplot - zestaw narzędzi do tworzenia wykresów 

ggplot(data = dane_diagnoza) + 
  geom_bar(mapping = aes(x = plec))

ggplot(data = dane_diagnoza) + 
  geom_bar(mapping = aes(x = gp29))

ggplot(data = dane_diagnoza) + 
  geom_bar(mapping = aes(x = plec, fill = gp29)) + 
  coord_flip() # kolumny na sobie 

ggplot(data = dane_diagnoza) + 
  geom_bar(mapping = aes(x = plec, fill = gp29),
           position = "dodge") + # kolumy obok siebie
  coord_flip()

ggplot(data = dane_diagnoza) + 
  geom_bar(mapping = aes(x = plec, fill = gp29),
           position = "fill") + # wykres skumulowany 100% 
  coord_flip()

# jak odfiltrować NAs - dplyr 

dane_diagnoza %>% filter(!is.na(plec), 
                         !is.na(gp29)) %>% 
  ggplot() + 
  geom_bar(mapping = aes(x = plec, fill = gp29), position = "fill") + 
  coord_flip()

# lub najpierw select 

dane_diagnoza %>% select(plec, gp29) %>% na.omit() %>% 
  ggplot() + 
  geom_bar(mapping = aes(x = plec, fill = gp29), position = "fill") + 
  coord_flip()

!is.na(c(1, 2, NA, 4, 5)) # jak działa filtr 

c(1, 2, NA, 4, 5)[!is.na(c(1, 2, NA, 4, 5))]

ggplot(data = na.omit(dane_diagnoza)) + # usuwa całość NA
  geom_bar(mapping = aes(x = plec, fill = gp29), position = "fill") + 
  coord_flip()

# na koniec pokazać Jamovi i Requal
