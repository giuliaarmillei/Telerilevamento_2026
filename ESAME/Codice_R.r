# Pacchetti utilizzati
library(terra) #
library(imageRy) #
library(viridis) #
library(ggplot2) #
library(patchwork) #

# Imposto la working directory
setwd("C:/Users/Giulia/OneDrive - Alma Mater Studiorum Università di Bologna/Desktop/esame")
getwd()

# Lista file nella working directory
list.files()

# Importo e visualizzo l'immagine pre-incendio 
pre <- rast("Preincendio_luglio2022.tif")
plot(pre)

# Esporto l'immagine del plot pre-incendio
png("pre_incendio.pgn")
plot(pre)
dev.off()

# Importo e visualizzo l'immagine post-incendio
post <- rast("Postincendio_agosto2022.tif")
plot(post)

# Esporto l'immagine del plot post-incendio
png("post_incendio.png")
plot(post)
dev.off()









