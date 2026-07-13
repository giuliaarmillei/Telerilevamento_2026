# Caricamento pacchetti utilizzati
library(terra) # Gestione, elaborazione e analisi dei dati raster
library(imageRy) # Visualizzazione ed elaborazione di immagini raster
library(viridis) # Palette di colori per grafici 
library(ggplot2) # Creazione di grafici personalizzati
library(ggridges) # Realizzazione di ridgline plot per il confronto di distribuzioni
library(patchwork) # Combinazione di più grafici in un'unica figura

# Impostazione della working directory
setwd("C:/Users/Giulia/OneDrive - Alma Mater Studiorum Università di Bologna/Desktop/esame")
getwd() #controllo della working directory
list.files() #lista dei file all'interno della working directory

# Importazione e visualizzazione dei dati raster Sentinel - 2
## Situazione pre incendio (luglio 2022)
pre <- rast("Preincendio_luglio2022.tif")
plot(pre)

## Situazione post incendio (agosto 2022)
post <- rast("Postincendio_agosto2022.tif")
plot(post)

## Le immagini sono state esportate e salvate in formato .png

# Composizione RGB a colori naturali
im.multiframe(1,2) #suddivisione della finestra grafica in 1 riga e 2 colonne
plotRGB(pre, r = 3, g = 2, b = 1, stretch = "lin", main = "Pre-incendio")
plotRGB(post, r = 3, g = 2, b = 1, stretch = "lin", main = "Post-incendio")
dev.off()

# Visualizzazione delle singole bande del visibile e del vicino infrarosso pre e post incendio
im.multiframe(2,4) #suddivisione della finestra grafica in 2 righe e 4 colonne
## Pre-incendio (luglio2022)
plot(pre[[1]], col = magma(100), main = "Pre-incendio, B2")
plot(pre[[2]], col = magma(100), main = "Pre-incendio, B3")
plot(pre[[3]], col = magma(100), main = "Pre-incendio, B4")
plot(pre[[4]], col = magma(100), main = "Pre-incendio, B8")
## Post-incendio (agosto2022)
plot(post[[1]], col = magma(100), main = "Post-incendio, B2")
plot(post[[2]], col = magma(100), main = "Post-incendio, B3")
plot(post[[3]], col = magma(100), main = "Post-incendio, B4")
plot(post[[4]], col = magma(100), main = "Post-incendio, B8")
dev.off()

# Visualizzazione a falsi colori??
???

# Analisi DVI
## calcolo indici con funzione im.dvi del pacchetto imageRy
dvi_pre <- im.dvi(pre, 4, 3)
dvi_post <- im.dvi(post, 4, 3)
## differenza DVI pre e post incendio
dvi_diff <- dvi_post - dvi_pre

## visualizzazione indici per il confronto temporale
im.multiframe(1,3) #suddivisione della finestra grafica in 1 riga e 3 colonne
plot(dvi_pre, col = cividis(100), main = "DVI luglio 2022")
plot(dvi_post, col = cividis(100), main = "DVI agosto 2022")
plot(dvi_diff, col = cividis(100), main = "Differenza DVI")
dev.off()

# Analisi NDVI
## calcolo indici con la funzione im.ndvi del pacchetto imageRy
ndvi_pre <- im.ndvi(pre, 4, 3)
ndvi_post <- im.ndvi(post, 4, 3)
## calcolo differenza indici ndvi
ndvi_diff <- ndvi_post - ndvi_pre

## visualizzazione indici e differenza indici per il confronto temporale
im.multiframe(1,3) #suddivisione della finestra grafica in 1 riga e 3 colonne
plot(ndvi_pre, col = inferno(100), main = "NDVI luglio 2022")
plot(ndvi_post, col = inferno(100), main = "NDVI agosto 2022")
plot(ndvi_diff, col = inferno(100), main = "Differenza NDVI")
dev.off()

# Analisi multitemporale della distribuzione dell'NDVI mediante ridgeline plot
stack_ndvi <- c(ndvi_pre, ndvi_post) # creazione dello stack dei due indici NDVI pre e post incendio
names(stack_ndvi) <- c("NDVI_Pre", "NDVI_Post") # assegnazione dei nomi ai due elementi dello stack
im.ridgeline(stack_ndvi, scale = 1, palette = "inferno") # generazione del ridgeline plot





