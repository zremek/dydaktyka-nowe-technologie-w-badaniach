# Instalacja i załadowanie potrzebnych pakietów
if (!require("dendextend")) install.packages("dendextend")
library("dendextend")

# Definicja danych
categories <- c("Ilościowe", "Jakościowe", "Bezpośredni kontakt", "Pośredni kontakt")
techniques <- list(
  c("Sondaż", "Eksperyment"),
  c("Wywiad pogłębiony", "Grupowy wywiad zogniskowany", "Obserwacja"),
  c("Sondaż", "Wywiad pogłębiony", "Grupowy wywiad zogniskowany", "Obserwacja"),
  c("Analiza treści", "Analiza danych zastanych")
)

# Tworzenie listy par (kategoria, technika)
pairs <- unlist(lapply(1:length(categories), function(i) {
  lapply(techniques[[i]], function(technique) {
    paste(categories[i], technique, sep = "-")
  })
}))

# Tworzenie dendrogramu
dend <- as.dendrogram(hclust(dist(pairs))) # to daje błąd
plot(dend, main = "Techniki badań socjologicznych")



## poniżej kod z drugiej iteracji copilota, gdy dałem botowi info o błędzie 

# Instalacja i załadowanie potrzebnych pakietów
# if (!require("dendextend")) install.packages("dendextend")
# library("dendextend")

# Definicja danych
categories <- c("Ilościowe", "Jakościowe", "Bezpośredni kontakt", "Pośredni kontakt")
techniques <- list(
  c("Sondaż (Ilościowe)", "Eksperyment (Ilościowe)"),
  c("Wywiad pogłębiony (Jakościowe)", "Grupowy wywiad zogniskowany (Jakościowe)", "Obserwacja (Jakościowe)"),
  c("Sondaż (Bezpośredni kontakt)", "Wywiad pogłębiony (Bezpośredni kontakt)", "Grupowy wywiad zogniskowany (Bezpośredni kontakt)", "Obserwacja (Bezpośredni kontakt)"),
  c("Analiza treści (Pośredni kontakt)", "Analiza danych zastanych (Pośredni kontakt)")
)

# Tworzenie listy par (kategoria, technika)
pairs <- unlist(lapply(1:length(categories), function(i) {
  lapply(techniques[[i]], function(technique) {
    paste(categories[i], technique, sep = "-")
  })
}))

# Tworzenie dendrogramu
dend <- as.dendrogram(hclust(dist(pairs))) # dalej błąd 

plot(dend, main = "Techniki badań socjologicznych")


### kolejna poprawka z copilot 


# Instalacja i załadowanie potrzebnych pakietów
# if (!require("dendextend")) install.packages("dendextend")
# library("dendextend")

# Definicja danych
categories <- c("Ilościowe", "Jakościowe", "Bezpośredni kontakt", "Pośredni kontakt")
techniques <- list(
  c("Sondaż (Ilościowe)", "Eksperyment (Ilościowe)"),
  c("Wywiad pogłębiony (Jakościowe)", "Grupowy wywiad zogniskowany (Jakościowe)", "Obserwacja (Jakościowe)"),
  c("Sondaż (Bezpośredni kontakt)", "Wywiad pogłębiony (Bezpośredni kontakt)", "Grupowy wywiad zogniskowany (Bezpośredni kontakt)", "Obserwacja (Bezpośredni kontakt)"),
  c("Analiza treści (Pośredni kontakt)", "Analiza danych zastanych (Pośredni kontakt)")
)

# Tworzenie listy par (kategoria, technika)
pairs <- unlist(lapply(1:length(categories), function(i) {
  lapply(techniques[[i]], function(technique) {
    paste(categories[i], technique, sep = "-")
  })
}))

# Tworzenie macierzy odległości
dist_matrix <- matrix(1, nrow = length(pairs), ncol = length(pairs))
diag(dist_matrix) <- 0

# Tworzenie dendrogramu
dend <- as.dendrogram(hclust(as.dist(dist_matrix)))
plot(dend, main = "Techniki badań socjologicznych")


# bez sensu, nie ma nazw technik :) 

