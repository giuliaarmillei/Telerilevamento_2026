# R code for visualizing saatellite images

library(terra)
library(imageRy)

install.packages("viridis")
library(viridis)

library(ggplot2)
install.packages("patchwork")
libraru(patchwork)
  
#listing data
im.list()

#importing images: b2 è la banda del 2
b2 <- im.import("sentinel.dolomites.b2.tif")
plot(b2)

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

#importing band 3 (=banda del verde)
b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3)

#esercizio: chanfe the ramp palette according to the viridis package
plot(b3, col=plasma(100))

#importing band 4 (banda del rosso)
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4)

#importing band 8
b8 <- im.import("sentinel.dolomites.b8.tif")
plot(b8)

#esercizio: multiframe with four bands, legends: in line with the wavelenght
par(mfrow=c(2,2))
cl2 <- colorRampPalette(c("darkblue", "blue", "lightblue"))(100)
cl3 <- colorRampPalette(c("darkgreen", "forestgreen", "lightgreen"))(100)
cl4 <- colorRampPalette(c("darkred", "red1", "tomato1"))(100)
cl8 <- colorRampPalette(c("violetred4", "violetred", "violetred1"))(100)
plot(b2, col=cl2)
plot(b3, col=cl3)
plot(b4, col=cl4)
plot(b8, col=cl8)

plot(b2, col=inferno(100))
plot(b3, col=inferno(100))
plot(b4, col=inferno(100))
plot(b8, col=inferno(100))

#stack
sentinel <- c(b2, b3, b4, b8)
plot(sentinel)
plot(sentinel, col=inferno(100))
names(sentinel)


plot(sentinel$sentinel.dolomites.b8)
#layer1=b2, layer2=b3, layer30b4, layer4=b8
plot(sentinel[[1]])
plot(sentinel[[4]])

install.packages("ggplot2")


#importo la banda del blu
b2 <- im.import("sentinel.dolomites.b2.tif")
b3 <- im.import("sentinel.dolomites.b3.tif")
b4 <- im.import("sentinel.dolomites.b4.tif")
b8 <- im.import("sentinel.dolomites.b8.tif")
#creo uno stack
sentinel <- c(b2, b3, b4, b8)

#layer 1 = b2 = blue
#layer 2 = b3 = green
#layer 3 = b4 = red
#layer 4 = b8 = infrarosso (NIR)

#una volta creato lo stack dei 4 layer che rappresentano le 4 bande posso fare il plot delle 4 bande tutte insieme
plot(sentinel)
#per plottare una sola delle bande:
plot(sentinel[[4]])

#quarto metodo con ggplot2
p1 <- im.ggplot(b8)
p2 <- im.ggplot(b4)
p1 + p2

# Multiframe:
# 1. par(mfrow=c(1,2))
# 2. im.multiframe(1,2)
# 3. stack
# 4. ggplot2 patchwork

#plotting by RGB schemes

#layer 1 = b2 = blue
#layer 2 = b3 = green
#layer 3 = b4 = red
#layer 4 = b8 = infrarosso (NIR)

im.plotRGB(sentinel, r=3, g=2, b=1)
im.plotRGB(sentinel, r=4, g=3, b=2)
