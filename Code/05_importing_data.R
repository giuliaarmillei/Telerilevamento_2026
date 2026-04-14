# Code to import data

library(terra)
library(viridis)
library(imageRy)
library(patchwork)
library(ggplot2)


#impostare la cartella di lavoro dove abbiamo scaricato le immagini
setwd("C:/Users/Giulia/Downloads/drone")
getwd()

# lista dei file in cartella 
list.files()

gre <- rast("DJI_20260409152942_0001_MS_G.tiff")
plot(gre)
#non ci sono resistrate le coordinate e quindi facciamo un flip
gre <- flip(gre)
plot(gre)
#abbiamo così un'immagine nel verde, dove tutto ciò che riflette il verde appare giallo
#cambio scala di colori richiamando il pacchetto viridis
plot(gre, col=mako(100))

#faccio lo stesso per l'immagine della banda del rosso
red <- rast("DJI_20260409152942_0001_MS_R.tiff")
red <- flip(red)
plot(red)

#importa ora la banda dell'infrarosso vicino (NIR)
nir <- rast("DJI_20260409152942_0001_MS_NIR.tiff")
nir <- flip(nir)
plot(nir)

#creiamo ora lo stack di queste tre immaigni, come componenti di un unico vettore
stack <- c(gre, red, nir)
plot(stack)
#l'infrarosso rispetto alle bande del visibile è più o meno complementare

#possiamo ora creare un'immagine a falsi colori usando l'infrarosso e due possibili stretch: lin e hist
plotRGB(stack, r=3, g=2, b=1, stretch="lin")
#qui tutto ciò che è rosso è vegetazione
plotRGB(stack, r=3, g=2, b=1, stretch="hist")

par(mfrow=c(1,2))
plotRGB(stack, r=3, g=2, b=1, stretch="lin")
plotRGB(stack, r=3, g=2, b=1, stretch="hist")

#calcolo NDVI
ndvi <- im.ndvi(stack, 3, 2)
dev.off()
plot(ndvi)

#esportare dati
writeRaster(ndvi, "ndvi.tif")

#importing data
ndvi2 <- rast("ndvi.tif")
plot(ndvi2)

par(mfrow=c(1,2))
plot(ndvi)
plot(ndvi2)

#exporting a figure (no data)
par(mfrow=c(2,2))
plot(gre)
plot(red)
plot(nir)
plot(ndvi)

png("figura1.png")
par(mfrow=c(2,2))
plot(gre)
plot(red)
plot(nir)
plot(ndvi)
dev.off()

#è un file vettoriale
pdf("figura2.pdf")
par(mfrow=c(2,2))
plot(gre)
plot(red)
plot(nir)
plot(ndvi)
dev.off()

#uso il pacchetto patchwork
p1 <- im.ggplot(ndvi)
p2 <- im.ridgeline(ndvi, scale=1)
p1 + p2
dev.off()

png("figura3.png")
p1 <- im.ggplot(ndvi)
p2 <- im.ridgeline(ndvi, scale=1)
p1 + p2
dev.off()

# import from Git
# link to the data
#gregit <- rast("https://github.com/ducciorocchini/Telerilevamento_2026/tree/main/Drone2")
gregit <- rast("https://raw.githubusercontent.com/ducciorocchini/Telerilevamento_2026/main/Drone2/DJI_20260409152942_0001_MS_G.TIF")
gregit <- flip(gregit)
plot(gregit)


