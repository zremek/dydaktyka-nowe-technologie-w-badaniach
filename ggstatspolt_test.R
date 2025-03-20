# install.packages("ggstatsplot")
library(ggstatsplot)

library(PogromcyDanych)

ggstatsplot::ggbarstats(data = diagnoza, x = gp3, y = plec)

ggstatsplot::ggscatterstats(diagnoza, gp60, gp61)
