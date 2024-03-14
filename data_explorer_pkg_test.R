# https://cran.r-project.org/web/packages/DataExplorer/vignettes/dataexplorer-intro.html 

# na przedostatnie zajęcia

# install.packages("DataExplorer")
# install.packages("PogromcyDanych")

library(DataExplorer)
library(PogromcyDanych)

s <- PogromcyDanych::diagnoza

introduce(s)
plot_intro(s)
plot_missing(s)
plot_bar(s)
plot_bar(s, with = "wiek2013") # nie wiem do czego to

?plot_bar # with daje sumy zmiennej numerycznej

plot_bar(s, by = "plec")

plot_bar(s, by = "plec", by_position = "dodge")

plot_histogram(s)
plot_histogram(s, by = "plec") # nie działa

plot_qq(s)

plot_qq(s, by = "plec")

plot_correlation(s)
plot_correlation(na.omit(s), maxcat = 5)

plot_boxplot(s, by = "plec")
plot_boxplot(s, by = "wiek2013") # automatyczne breaks

plot_scatterplot(s, by = "wiek2013", sampled_rows = 1000)

create_report(s)
