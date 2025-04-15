# install.packages("ggstatsplot")
library(ggstatsplot)

library(PogromcyDanych)

ggstatsplot::ggbarstats(data = diagnoza, x = gp3, y = plec) + 
  coord_flip()

ggstatsplot::grouped_ggbarstats(data = diagnoza, x = gp3, y = plec, 
                                grouping.var = eduk4_2013)

ggstatsplot::ggscatterstats(diagnoza, gp60, gp61)
