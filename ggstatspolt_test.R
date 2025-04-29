# install.packages("ggstatsplot")
library(ggstatsplot)

library(PogromcyDanych)

ggstatsplot::ggbarstats(data = diagnoza, x = gp3, y = plec) + 
  coord_flip()

ggstatsplot::grouped_ggbarstats(data = diagnoza, x = gp3, y = plec, 
                                grouping.var = eduk4_2013)

ggstatsplot::ggscatterstats(diagnoza, gp60, gp61)


ggplot(diagnoza, aes(x = gp60, colour = plec)) + geom_density() + 
  scale_x_continuous(breaks = seq(from = 0, to = 300, by = 10))

by(data = diagnoza$gp60, INDICES = diagnoza$plec, FUN = summary)
