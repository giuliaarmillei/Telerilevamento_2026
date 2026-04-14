# Code to import data

library(terra)
library(viridis)

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
