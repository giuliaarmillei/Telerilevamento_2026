# Caricamento pacchetti utilizzati
library(terra) #
library(imageRy) #
library(viridis) #
library(ggplot2) #
library(patchwork) #

# Impostazione della working directory
setwd("C:/Users/Giulia/OneDrive - Alma Mater Studiorum Università di Bologna/Desktop/esame")
getwd() #controllo della working directory
list.files() #lista dei file all'interno della working directory

# Importazione e visualizzazione dei dati raster Sentinel - 2
# Situazione pre incendio (luglio 2022)
pre <- rast("Preincendio_luglio2022.tif")
plot(pre)

# Situazione post incendio (agosto 2022)
post <- rast("Postincendio_agosto2022.tif")
plot(post)

# Le immagini sono state esportate e salvate in formato .png

# Composizione RGB a colori naturali
im.multiframe(1,2) #suddivisione della finestra grafica in 1 riga e 2 colonne
plotRGB(pre, r = 3, g = 2, b = 1, stretch = "lin", main = "Pre-incendio")
plotRGB(post, r = 3, g = 2, b = 1, stretch = "lin", main = "Post-incendio")
dev.off()

# Visualizzazione delle singole bande del visibile e del vicino infrarosso pre e post incendio
im.multiframe(2,4) #suddivisione della finestra grafica in 2 righe e 4 colonne
# Pre-incendio (luglio2022)
plot(pre[[1]], col = magma(100), main = "Pre-incendio, B2")
plot(pre[[2]], col = magma(100), main = "Pre-incendio, B3")
plot(pre[[3]], col = magma(100), main = "Pre-incendio, B4")
plot(pre[[4]], col = magma(100), main = "Pre-incendio, B8")
# Post-incendio (agosto2022)
plot(post[[1]], col = magma(100), main = "Post-incendio, B2")
plot(post[[2]], col = magma(100), main = "Post-incendio, B3")
plot(post[[3]], col = magma(100), main = "Post-incendio, B4")
plot(post[[4]], col = magma(100), main = "Post-incendio, B8")
dev.off()







