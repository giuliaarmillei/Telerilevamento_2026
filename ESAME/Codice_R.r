# Pacchetti utilizzati
library(terra) #
library(imageRy) #
library(viridis) #
library(ggplot2) #
library(patchwork) #

# Impostazione della working directory
setwd("C:/Users/Giulia/OneDrive - Alma Mater Studiorum Università di Bologna/Desktop/esame")
getwd()

# Lista file nella working directory
list.files()

# Importazione e visualizzazione delle bande spettrali luglio 2022 
pre <- rast("Preincendio_luglio2022.tif")
plot(pre)


# Importazione e visualizzazione delle bande spettrali agosto 2022 
post <- rast("Postincendio_agosto2022.tif")
plot(post)

# Importazione e visualizzazione delle bande spettrali due anni dopo l'incendio
post2024 <- rast("SerradaEstrela_agosto2024.tif")
plot(post2024)

# Le immagini sono state salvate in formato .pgn 

# Visualizzazione delle immagini a veri colori con schema RGB
im.multiframe(1,3)
plotRGB(pre, r = 3, g = 2, b = 1, stretch = "lin", main = "Pre-incendio")
plotRGB(post, r = 3, g = 2, b = 1, stretch = "lin", main = "Post-incendio")
plotRGB(post2024, r = 3, g = 2, b = 1, stretch = "lin", main = "Post-2024")
dev.off()

# Visualizzazione delle singole bande (B2=Blu, B3=Verde, B4=Rosso, B9=NIR) per le 3 immagini
im.multiframe(3,4)
# pre-incendio luglio 2022
plot(pre[[1]], col = magma(100), main = "pre - B2")
plot(pre[[2]], col = magma(100), main = "pre - B3")
plot(pre[[3]], col = magma(100), main = "pre - B4")
plot(pre[[4]], col = magma(100), main = "pre - B8")

# post-incendio agosto 2022
plot(post[[1]], col = magma(100), main = "post - B2")
plot(post[[2]], col = magma(100), main = "post - B3")
plot(post[[3]], col = magma(100), main = "post - B4")
plot(post[[4]], col = magma(100), main = "post - B8")

# post-incendio agosto 2024
plot(post2024[[1]], col = magma(100), main = "post2024 - B2")
plot(post2024[[2]], col = magma(100), main = "post2024 - B3")
plot(post2024[[3]], col = magma(100), main = "post2024 - B4")
plot(post2024[[4]], col = magma(100), main = "post2024 - B8")

dev.off()

# Visualizzazione delle immagini a falsi colori sostituendo la banda del rosso con il NIR
im.multiframe(1,3)
plotRGB(pre, r = 4, g = 3, b = 2, stretch = "lin", main = "Pre-incendio")
plotRGB(post, r = 4, g = 3, b = 2, stretch = "lin", main = "Post-incendio")
plotRGB(post2024, r = 4, g = 3, b = 2, stretch = "lin", main = "Post-2024")
dev.off()
# Sostituendo la banda del rosso con la banda del NIR evidenzio la vegetazione in rosso e questo permette di osservare lo stato di salute della vegetazione
# Una minor riflessione del NIR indica una vegetazione sottoposta a stress. 









