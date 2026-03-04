# R code for visualizing saatellite images

library(terra)
library(imageRy)

install.packages("viridis")
library(viridis)
  
#listing data
im.list()

#importing images
b2 <- im.import("sentinel.dolomites.b2.tif")

#changing color
cl <- colorRampPalette(c("darkgoldenrod", "brown", "gold"))(100)
plot(b2, col=cl)

cl2 <- colorRampPalette(c("darkgoldenrod", "brown", "gold"))(3)
plot(b2, col=cl2)

#Viridis palettes
plot(b2, col=inferno(100))

#Exercise: plot with mako
plot(b2, col=mako(100))
plot(b2, col=mako(3))

#Esercizio: plot band 2 with a greyscalepalette
#plottare la banda del blu con una legenda della scala dei grigi
cl <- colorRampPalette(c("darkgrey", "grey", "lightgrey"))(100)
plot(b2, col=cl)

#funzione par
par(mfrow=c(1,2))
plot(b2, col=inferno(100))
plot(b2, col=cl)

dev.off()


