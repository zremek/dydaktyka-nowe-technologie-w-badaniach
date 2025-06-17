library(PogromcyDanych)
library(sjPlot)

d <- diagnoza

z1 <- "https://web.archive.org/web/20220104185343/http://smarterpoland.pl/index.php/2021/12/plebiscyt-na-najgorszy-wykres-roku-2021/"


z2 <- PogromcyDanych::diagnoza


z3 <- summary(z2$gp60)

z4 <- table(z2$gp54_05, useNA = "always")


z5 <- ggplot(data = z2, mapping = aes(x = gp113, y = plec )) + geom_boxplot()


z6 <- ggplot(data = z2, mapping = aes(x = eduk4_2013, fill = gp54_02)) + geom_bar(position = "fill") + coord_flip() +   labs(title = "Sens życia a wykształcenie")


z7 <- tab_xtab(z2$gp54_02, z2$plec, show.col.prc = TRUE, show.na = TRUE)

#sapply(list(z1, z3, z4, z5, z6, z7), print)

sessionInfo()

Sys.getpid()

Sys.time()



