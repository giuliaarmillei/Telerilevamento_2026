library(terra)
library(imageRy)
library(viridis)

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

#DVI
#ipotizziamo una riflettanza della pianta da 0 a 100
#NIR=100 red=0
# indice dvi = NIR - red = 100 - 0 = massimo dvi di una pianta
#se una pianta va in sofferenza cala molto il NIR e il rosso non viene assorbito con la fotosintesi e quindi aumenta la riflettanza
#dvi_t1 = 40 - 10 = 30

#DVI
#l1=NIR - red
#con le due parentesi quadre ci riferiamo a una specifica banda dell'oggetto
dvi1992 = mato1992[[1]] - mato1992[[2]]
dvi2006 = mato2006[[1]] - mato2006[[2]]
par(mfrow=c(1,2))
plot(dvi1992)
plot(dvi2006)

#cambio colore della legenda con 100 sfumature (devo prima richiamare il pacchetto viridis)
plot(dvi1992, col=inferno(100))
plot(dvi2006, col=inferno(100))

#DVI with different radiometric resolution 
#8 bit con valori di range da 0 a 255
#DVI = NIR - red = 255 - 0 = 255 = max DVI
#DVI = NIR - red = 0 - 255 = -255 = min DVI
#quindi il range di DVI  va da -255 a 255

#2 bit = 4 valori possibile che variano in un range da 0 a 3
#DVI = NIR - red = 3 - 0 = 3 = max DVI
#DV = NIR - red = 0 - 3 = -3 = min DVI
#per usare il DVI è necessario che abbiano la stessa risoluzione radiometrica

#8 bit con valori di range da 0 a 255
#NDVI = (NIR - red) / (NIR + red) = (255 - 0)/(255 + 0) = 1 = max NDVI
#NDVI = (NIR - red) / (NIR + red) = (0 - 255)/(0+255) = -1 = min NDVI

#2 bit = 4 valori possibile che variano in un range da 0 a 3
#NDVI = (NIR - red) / (NIR + red) = (3 - 0) / (3 + 0) = 1 = max NDVI
#NDV = (NIR - red) / (NIR + red) = (0 - 3) / (0 + 3) = -1 = min DVI

#NDVI 1992
ndvi1992 = dvi1992 / (mato1992[[1]] + mato1992[[2]])

#NDVI 2006
ndvi2006 = dvi2006 / (mato2006[[1]] + mato2006[[2]])

par(mfrow=c(2,2))
plot(dvi1992)
plot(dvi2006)
plot(ndvi1992)
plot(ndvi2006)

#DVI con imageRy
#l1 = NIR, l2= red, l3 = green
dvi1992 = im.dvi(mato1992, 1, 2)
dvi2006 = im.dvi(mato2006, 1, 2)
plot(dvi1992)
plot(dvi2006)

#NDVI con imageRy
ndvi1992 = im.ndvi(mato1992, 1, 2)
ndvi2006 = im.ndvi(mato2006, 1, 2)
plot(ndvi1992)
plot(ndvi2006)
