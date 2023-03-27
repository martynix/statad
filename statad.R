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

#Utworzenie wektora liczb odpowiadających kolumnom które mają zotać usunięte
#Począwszy od 3 kolumny, co druga zawiera same wartości NULL
colrm <- seq(from = 3, to = 93, by = 2)
colrm <- as.vector(colrm)
zarobki <- zarobki[,-colrm]

#Uporządkowanie nazw ramki danych
colnames(zarobki) <- zarobki[1,]
zarobki <- zarobki[-1,]
rownames(zarobki) <- zarobki[,1]
zarobki <- zarobki[,-1]

#Podział na lata bez miesięcy
z2010 <- as.data.frame(zarobki[1:12,])
z2010 <- cbind("Miesiąc" = c("styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec", 
                  "lipiec", "sierpień", "wrzesień", "październik", "listopad", "grudzień"), z2010)
z2011 <- as.data.frame(zarobki[13:24,])
z2011 <- cbind("Miesiąc" = c("styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec", 
                             "lipiec", "sierpień", "wrzesień", "październik", "listopad", "grudzień"), z2011)
z2012 <- as.data.frame(zarobki[25:36,])
z2012 <- cbind("Miesiąc" = c("styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec", 
                             "lipiec", "sierpień", "wrzesień", "październik", "listopad", "grudzień"), z2012)
z2013 <- as.data.frame(zarobki[37:48,])
z2013 <- cbind("Miesiąc" = c("styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec", 
                             "lipiec", "sierpień", "wrzesień", "październik", "listopad", "grudzień"), z2013)
z2014 <- as.data.frame(zarobki[49:60,])
z2014 <- cbind("Miesiąc" = c("styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec", 
                             "lipiec", "sierpień", "wrzesień", "październik", "listopad", "grudzień"), z2014)
z2015 <- as.data.frame(zarobki[61:72,])
z2015 <- cbind("Miesiąc" = c("styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec", 
                             "lipiec", "sierpień", "wrzesień", "październik", "listopad", "grudzień"), z2015)
z2016 <- as.data.frame(zarobki[73:84,])
z2016 <- cbind("Miesiąc" = c("styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec", 
                             "lipiec", "sierpień", "wrzesień", "październik", "listopad", "grudzień"), z2016)
z2017 <- as.data.frame(zarobki[85:96,])
z2017 <- cbind("Miesiąc" = c("styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec", 
                             "lipiec", "sierpień", "wrzesień", "październik", "listopad", "grudzień"), z2017)
z2018 <- as.data.frame(zarobki[97:108,])
z2018 <- cbind("Miesiąc" = c("styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec", 
                             "lipiec", "sierpień", "wrzesień", "październik", "listopad", "grudzień"), z2018)
z2019 <- as.data.frame(zarobki[109:120,])
z2019 <- cbind("Miesiąc" = c("styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec", 
                             "lipiec", "sierpień", "wrzesień", "październik", "listopad", "grudzień"), z2019)
z2020 <- as.data.frame(zarobki[121:132,])
z2020 <- cbind("Miesiąc" = c("styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec", 
                             "lipiec", "sierpień", "wrzesień", "październik", "listopad", "grudzień"), z2020)
z2021 <- as.data.frame(zarobki[133:144,])
z2021 <- cbind("Miesiąc" = c("styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec", 
                             "lipiec", "sierpień", "wrzesień", "październik", "listopad", "grudzień"), z2021)
z2022 <- as.data.frame(zarobki[145:156,])
z2022 <- cbind("Miesiąc" = c("styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec", 
                             "lipiec", "sierpień", "wrzesień", "październik", "listopad", "grudzień"), z2022)
z2023 <- as.data.frame(zarobki[157:158,])
z2023 <- cbind("Miesiąc" = c("styczeń", "luty"), z2023)

#GRAFICZNA PREZENTACJA DANYCH
#Zarobki ogolem
install.packages("ggplot")
library(ggplot2)
ggplot(z2010, aes(x=z2010$Miesiąc, y=z2010$`
Ogółem
Grand total`)) +
  geom_line()

plot(z2010$`
Ogółem
Grand total`)

#Wybieram 3 cechy (kolumny), na podstawie których wyznaczę podstawowe parametry opisowe
xValue <- 1:10
yValue <- cumsum(rnorm(10))
data <- data.frame(xValue,yValue)
ggplot(data, aes(x=xValue, y=yValue)) +
  geom_line()
