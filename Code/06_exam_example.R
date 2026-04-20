library(terra)

setwd("C:/Users/Giulia/Downloads/drone")
getwd()
#lista di files nella cartella drone
list.files()

#importare l'immagine scaricata
richat <- rast("richatstructure_oli_20260306.jpg")
plot(richat)
richat <- flip(richat)
plot(richat)

#esporto l'immagine plottata sul dekstop
png(
