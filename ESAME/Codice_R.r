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
