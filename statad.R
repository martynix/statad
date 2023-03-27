getwd()
setwd("C:/Users/marty/Desktop/GITHUB/statad")

#Instalacja pakietu do wczytywania tabeli z pliku Excela
install.packages("readxl")
library("readxl")

#Przeciętne miesięczne wynagrodzenia brutto w sektorze przedsiębiorstw
zarobki <- read_excel("tabl19.xlsx")
str(zarobki)
zarobki <- as.data.frame(zarobki)
zarobki <- zarobki[-(c(1,2,3,5)),]
zarobki[,49]

#Utworzenie wektora liczb odpowiadających kolumnom które mają zotać usunięte
#Począwszy od 3 kolumny, co druga zawiera same wartości NULL
colrm <- seq(from = 3, to = 93, by = 2)
colrm <- as.vector(colrm)
zarobki <- zarobki[,-colrm]

#Uporządkowanie nazw ramki danych
colnames(zarobki) <- zarobki[1,]
cn<-colnames(zarobki)             
cn[1] <- "okresy"
colnames(zarobki) <- cn
