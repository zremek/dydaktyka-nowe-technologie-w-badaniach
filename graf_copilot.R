# Instalacja i załadowanie potrzebnych pakietów
if (!require("visNetwork")) install.packages("visNetwork")
library("visNetwork")

# Definicja danych
categories <- c("Ilościowe", "Jakościowe", "Bezpośredni kontakt", "Pośredni kontakt")
techniques <- list(
  c("Sondaż", "Eksperyment"),
  c("Wywiad pogłębiony", "Grupowy wywiad zogniskowany", "Obserwacja"),
  c("Sondaż", "Wywiad pogłębiony", "Grupowy wywiad zogniskowany", "Obserwacja"),
  c("Analiza treści", "Analiza danych zastanych")
)

# Tworzenie listy wierzchołków i krawędzi
nodes <- data.frame(id = c(categories, unlist(techniques)), label = c(categories, unlist(techniques)))
edges <- do.call(rbind, lapply(1:length(categories), function(i) {
  data.frame(from = categories[i], to = techniques[[i]])
}))

# Tworzenie grafu
visNetwork(nodes, edges) %>% visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE)

# kod z copilota daje błąd: Error in visNetwork(nodes, edges) : nodes must have unique ids

nodes_fix <- nodes[c(1:9, 14:15), ] # po tej poprawce działa, nawet fajne

visNetwork(nodes_fix, edges) %>% visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE)
