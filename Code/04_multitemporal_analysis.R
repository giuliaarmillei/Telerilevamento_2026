library(terra)
library(imageRy)
library(viridis)
library(ggplot2)
install.packages("ggridges")
library(ggridges)

im.list()
EN_01 <- im.import("EN_01.png"))
plot(EN_01)
EN_01 <- flip(EN_01)
plot(EN_01)
EN_13 <- im.import("EN_03.png")
EN_13 <- flip(EN_13)
plot(EN_13)

#esercizio: osservare le due immagini una dopra l'altra
par(mfrow=c(2,1))
plot(EN_01)
plot(EN_13)

#differencing
ENdif <- EN_01[[1]] - EN_13[[1]] 
dev.off()
plot(ENdif)

#esercizio: importa tutte le greenland immagini e crea lo stack
g2000 <- im.import("greenland.2000.tif")
g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")
sg <- c(g2000, g2005, g2010, g2015)

gr <- im.import("greenland")

par(mfrow=c(1,2))
plot(gr[[1]], col=plasma(100))
plot(gr[[4]], col=plasma(100))

#differenza
dif <- gr[[4]] - gr[[1]]
dev.off()
plot(dif)

#RGB
im.plotRGB(gr, r=1, g=2, b=4)

# NDVI data
ndvi <- im.import("Sentinel2_NDVI_2020")

#istogramma
hist(ndvi)

#ridgeline plotting
im.ridgeline(ndvi, scale=1, palette="viridis")

names(ndvi) <- c("02_fev", "05_may", "08_aug", "11_nov")
im.ridgeline(ndvi, scale=1, palette="viridis")

#pairs
pairs(ndvi)

plot(ndvi[[1]], ndvi[[2]])

# y = a + bx
# y = x
#a = 0    b=1

#insert the line x=y
abline(0, 1)

plot(ndvi[[1]], ndvi[[2]], xlim=c(-0.3,0.9), ylim=c(-0.3,0.9))
abline(0, 1)









