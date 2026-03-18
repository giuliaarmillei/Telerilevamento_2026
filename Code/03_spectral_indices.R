library(terra)
library(imageRy)

#listing file
im.list()

#importing data 
mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992 <- flip(mato1992)

#layer1 = NIR, layer2 = red, layer3 = green
#nel sistema RGB mettiamo il NIR alla componente rossa
im.plotRGB(mato1992, r=1, g=2, b=3)
im.plotRGB(mato1992, r=2, g=1, b=3)
im.plotRGB(mato1992, r=2, g=3, b=1)

mato2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006 <- flip(mato2006)
im.plotRGB(mato2006, r=1, g=2, b=3)

#esercizio: plot the two images one beside the other using im.multiframe
par(mfrow=c(1,2))
im.plotRGB(mato2006, r=1, g=2, b=3)
im.plotRGB(mato1992, r=1, g=2, b=3)

im.plotRGB(mato1992, r=2, g=3, b=1)
im.plotRGB(mato2006, r=2, g=3, b=1)
