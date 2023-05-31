getwd()
setwd("C:/Users/marty/Desktop/GITHUB/statad")

#Instalacja pakietu do wczytywania tabeli z pliku Excela
#install.packages("readxl")
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
zarobki <- zarobki[,-colrm] #pełna tabela

#Uporządkowanie nazw ramki danych
zarobki <- zarobki[-1,]
rownames(zarobki) <- seq(from = 1, to = 158, by = 1)
zarobki1 <- zarobki[,c(1,2,45,33)] #tabela z wybranymi kolumnami, na których przeprowadzono obliczenia
zarobki1$rok <- as.integer(substr(zarobki[,1], 1, 4))
colnames(zarobki1) <- c("Okres", "Ogółem", "Informacja/komunikacja", "Budownictwo", "rok")
#Obliczone parametry statystyki opisowej
str(zarobki1)

#zamiana wierszy z zarobkami na strukturę DOUBLE by można było na nich wykonać obliczenia
zarobki1[,2] <- as.double(zarobki1[,2])
zarobki1[,3] <- as.double(zarobki1[,3])
zarobki1[,4] <- as.double(zarobki1[,4])

#1.średnia
srednia1 <- mean(zarobki1[,2])
srednia2 <- mean(zarobki1[,3])
srednia3 <- mean(zarobki1[,4])

#2.odchylenie standardowe
ochdst1 <- sd(zarobki1[,2])
ochdst2 <- sd(zarobki1[,3])
ochdst3 <- sd(zarobki1[,4])

#3.mediana
mediana1 <- quantile(zarobki1[,2])
mediana1 <- mediana1[3]

mediana2 <- quantile(zarobki1[,3])
mediana2 <- mediana2[3]
mediana2

mediana3 <- quantile(zarobki1[,4])
mediana3 <- mediana3[3]
mediana3

#4.współczynnik zmienności
wsp1 <- ochdst1/srednia1*100
wsp2<- ochdst2/srednia2 
wsp3 <- ochdst3/srednia3
#Współczynnik zmienności:
#poniżej 25 proc. – bardzo mała zmienność,
#w granicach od 25 do 45 proc. – przeciętna zmienność,
#w granicach od 45 do 100 proc. – silna zmienność,
#powyżej 100 proc. – bardzo intensywna zmienność

#5.wariancja
war1 <- var(zarobki1[,2])
war2 <- var(zarobki1[,3])
war3 <- var(zarobki1[,4])

#6.dominanta
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

dom1 <- getmode(zarobki1[,2])
dom2 <- getmode(zarobki1[,3])
dom3 <- getmode(zarobki1[,4])

#Instalacja pakietu moments do obliczenia kurtozy i skośności
#install.packages("moments")
library("moments")

#7.kurtoza
k1 <- kurtosis(zarobki1[,2])
k2 <- kurtosis(zarobki1[,3])
k3 <- kurtosis(zarobki1[,4])

#8.skośność
sk1 <- skewness(zarobki1[,2])
sk2 <- skewness(zarobki1[,3])
sk3 <- skewness(zarobki1[,4])

#Ramka danych zawierająca obliczone parametry
param <- data.frame("średnia" = c(srednia1,srednia2,srednia3), "odchylenie standardowe"=c(ochdst1,ochdst2,ochdst3), "mediana"=c(mediana1,mediana2,mediana3), 
                    "współczynnik zmienności[%]"=c(wsp1,wsp2,wsp3), "wariancja"=c(war1,war2,war3), "dominanta"=c(dom1,dom2,dom3), "kurtoza"=c(k1,k2,k3), "skośność"=c(sk1,sk2,sk3))

rownames(param) <- c("zarobki ogółem", "informacja/komunikacja", "budownictwo")  


#GRAFICZNA PREZENTACJA DANYCH

#histogramy porównujące zarobki ogółem;zarobki w sektorze informacji/komunikacji oraz zarobki ogółem;zarobki w sektorze budownictwa
par(mfrow=c(2,1))
par(mar=c(0,5,3,3))
hist(zarobki1[,2], main="" , xlim=c(3000,13000), ylab="Ogółem", xlab="", ylim=c(0,50) , xaxt="n", las=1 , col="slateblue1", breaks=10)
par(mar=c(5,5,0,3))
hist(zarobki1[,3], main="" , xlim=c(3000,13000), ylab="informacja/komunikacja", xlab="Wysokość wynagrodzenia", ylim=c(50,0) , las=1 , col="yellow"  , breaks=10)

par(mfrow=c(2,1))
par(mar=c(0,5,3,3))
hist(zarobki1[,2] , main="" , xlim=c(3000,10000), ylab="Ogółem", xlab="", ylim=c(0,60) , xaxt="n", las=1 , col="slateblue1", breaks=10)
par(mar=c(5,5,0,3))
hist(zarobki1[,4] , main="" , xlim=c(3000,10000), ylab="budownictwo", xlab="Wysokość wynagrodzenia", ylim=c(60,0) , las=1 , col="purple"  , breaks=10)

#boxplot
boxplot(zarobki1[,2:4],col='pink')

#wykres dystrybuanty empirycznej wysokości wynagrodzenia (ogółem)
ecdf(zarobki1[,2]) #funkcja wyświetlająca punkty skokowe na "surowych" danych
#Pogrupowanie danych w celu zmniejszenia liczby punktów skokowych poprzez podział wartości na klasy
ilosc_klas = 11
klasy = seq(min(zarobki1[,2])-50, max(zarobki1[,2]), length.out = ilosc_klas+1)
klasy <- round(klasy,digits=1)
klasy
klasy_srodki = round((klasy[-length(klasy)] + klasy[-1])/2, 1)
klasy_srodki

cut(zarobki1[,2],klasy, dig.lab=10)
przedzialy <- table(cut(zarobki1[,2],klasy,dig.lab=10))
przedzialy

#Dystrybuanta empiryczna na pogrupowanych danych
ecdf(cut(zarobki1[,2],klasy, dig.lab=10))
ecdf(cut(zarobki1[,2],klasy, dig.lab=10))(1:ilosc_klas)

srodki_czestosci <- data.frame("środki klas"=klasy_srodki, "częstości skumulowane"=ecdf(cut(zarobki1[,2],klasy, dig.lab=10))(1:ilosc_klas))
srodki_czestosci

plot(ecdf(cut(zarobki1[,2],klasy, dig.lab=10)), col="orange", col.lab="red", col.main="red",
     xlab="Zarobki", ylab="Łączna częstość", main="Dystrybuanta wysokości zarobków (ogółem)", lwd=2, xaxt="n", las=1)
axis(side=1, at=1:ilosc_klas, labels=klasy_srodki)

#Wykres średnich zarobków (ogółem) na przestrzeni lat

#install.packages("dplyr") #bez tego pakietu funkcja %>% nie działa
library(dplyr)

#install.packages("tidyverse")
#installed.packages("plotly")
library(tidyverse)
library(plotly)

#colnames(zarobki[,2]) <- "Ogolem"

p <- (zarobki1) %>%
  group_by(rok) %>%
  mutate(srednia = mean(as.numeric(Ogółem), na.rm = T)) %>%
  slice(1) %>%
  ungroup() %>%
  ggplot(aes(x = rok)) +
  geom_point(aes(y = srednia), color="#FCB13B") +
  geom_line(aes(y = srednia), color="#FCB13B") + 
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust=1)) +
  ggtitle("Średnie wynagrodzenie brutto na przestrzeni lat 2010-2023") + 
  labs(x="Rok", y="Wynagrodzenie")
ggplotly(p)


#WERYFIKACJA HIPOTEZ STATYSTYCZNYCH

#Hipoteza dla średniej (zarobki ogółem)
#H0: Średnia wysokość wynagrodzenia (zarobki1$Ogolem) wynosi 4500
#H1: Średnia wysokość wynagrodzenia (zarobki1$Ogolem) nie wynosi 4500
t.test(zarobki1[,2], mu=4500)

#H0: Średnia wysokość wynagrodzenia (zarobki1$Ogolem) wynosi 3000
#H1: Średnia wysokość wynagrodzenia (zarobki1$Ogolem) wynosi więcej niż 3000
t.test(zarobki1[,2], mu=3000, alternative="greater")

#p-value > 1-0.95(confidence_level), nie ma podstaw do odrzucenia H0

#Hipoteza dla wariancji (zarobki ogółem) i dla sektora budownictwo
var.test(zarobki1[,2], zarobki1[,4])

cor.test(zarobki1[,3], zarobki1[,4])
