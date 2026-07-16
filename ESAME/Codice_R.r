# Impostazione della working directory
setwd("C:/Users/Giulia/OneDrive - Alma Mater Studiorum Università di Bologna/Desktop/esame")
getwd()       #verifica della working directory
list.files()  #lista dei file all'interno della working directory

# Caricamento pacchetti utilizzati
library(terra)      # Gestione, elaborazione e analisi dei dati raster
library(imageRy)    # Visualizzazione ed elaborazione di immagini raster
library(viridis)    # Palette di colori per grafici 
library(ggplot2)    # Creazione di grafici personalizzati
library(ggridges)   # Realizzazione di ridgline plot per il confronto di distribuzioni
library(patchwork)  # Combinazione di più grafici in un'unica figura

# Importazione e visualizzazione dei dati raster Sentinel - 2
## Situazione pre incendio (luglio 2022)
pre <- rast("Preincendio_luglio2022.tif")
plot(pre)

## Situazione post incendio (agosto 2022)
post <- rast("Postincendio_agosto2022.tif")
plot(post)

## Situazione due anni dopo l'evento (agosto 2024)
post2024 <- rast("SerradaEstrela_agosto2024.tif")
plot(post2024)

## Le immagini sono state esportate e salvate in formato .png

# Composizione RGB a colori naturali
im.multiframe(1, 3)   #suddivisione della finestra grafica in 1 riga e 3 colonne
plotRGB(pre, r = 3, g = 2, b = 1, stretch = "lin", main = "Pre-incendio")
plotRGB(post, r = 3, g = 2, b = 1, stretch = "lin", main = "Post-incendio")
plotRGB(post2024, r = 3, g = 2, b = 1, stretch = "lin", main = "Due anni dopo")
dev.off()             #chiusura della finestra grafica

# Visualizzazione delle singole bande del visibile e del vicino infrarosso 
im.multiframe(3, 4)   #suddivisione della finestra grafica in 3 righe e 4 colonne
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
## Due anni dopo (agosto 2024)
plot(post2024[[1]], col = magma(100), main = "Due anni dopo, B2")
plot(post2024[[2]], col = magma(100), main = "Due anni dopo, B3")
plot(post2024[[3]], col = magma(100), main = "Due anni dopo, B4")
plot(post2024[[4]], col = magma(100), main = "Due anni dopo, B8")
dev.off()

# Analisi DVI
## calcolo indici con funzione im.dvi del pacchetto imageRy
dvi_pre <- im.dvi(pre, 4, 3)
dvi_post <- im.dvi(post, 4, 3)
dvi_post2024 <- im.dvi(post2024, 4, 3) 

## visualizzazione indici 
im.multiframe(1, 3)   #suddivisione della finestra grafica in 1 riga e 3 colonne
plot(dvi_pre, col = cividis(100), main = "DVI luglio 2022")
plot(dvi_post, col = cividis(100), main = "DVI agosto 2022")
plot(dvi_post2024, col = cividis(100), main = "DVI agosto 2024")
dev.off()

# Analisi NDVI
## calcolo indici con la funzione im.ndvi del pacchetto imageRy
ndvi_pre <- im.ndvi(pre, 4, 3)
ndvi_post <- im.ndvi(post, 4, 3)
ndvi_post2024 <- im.ndvi(post2024, 4, 3)

## visualizzazione indici 
im.multiframe(1, 3)   #suddivisione della finestra grafica in 1 riga e 3 colonne
plot(ndvi_pre, col = inferno(100), main = "NDVI luglio 2022")
plot(ndvi_post, col = inferno(100), main = "NDVI agosto 2022")
plot(ndvi_post2024, col = inferno(100), main = "NDVI agosto 2024")
dev.off()

## calcolo differenza inidici ndvi tra le diverse fasi
ndvi_diff1 <- ndvi_post - ndvi_pre
ndvi_diff2 <- ndvi_post2024 - ndvi_post
ndvi_diff3 <- ndvi_post2024 - ndvi_pre

## visualizzazione differenze indici per il confronto temporale
im.multiframe(1, 3)   #suddivisione finestra grafica in 1 riga e 3 colonne
plot(ndvi_diff1, col = inferno(100), main = "agosto2022 - luglio2022")
plot(ndvi_diff2, col = inferno(100), main = "agosto2024 - agosto2022")
plot(ndvi_diff3, col = inferno(100), main = "agosto2024 - luglio2022")
dev.off()

# Analisi multitemporale della distribuzione dell'NDVI mediante ridgeline plot
stack_ndvi <- c(ndvi_pre, ndvi_post, ndvi_post2024)               #creazione dello stack dei tre indici NDVI 
names(stack_ndvi) <- c("NDVI_Pre", "NDVI_Post", "NDVI_Post2024")  #assegnazione dei nomi agli elementi dello stack
im.ridgeline(stack_ndvi, scale = 1, palette = "inferno")          #generazione del ridgeline plot

# Classificazione 
#classificazione non supervisionata delle tre immagini raster in 3 cluster
class_pre <- im.classify(ndvi_pre, seed = 3, num_cluster = 3)
class_post <- im.classify(ndvi_post, seed = 3, num_cluster = 3)
class_post2024 <- im.classify(ndvi_post2024, seed = 3, num_cluster = 3)

#assegnazione delle etichette alle 3 classi
levels(class_pre) <- data.frame(value = c(1, 2, 3), label = c("Vegetazione", "Suolo nudo", "Vegetazione rada"))
levels(class_post) <- data.frame(value = c(1, 2, 3), label = c("Vegetazione", "Suolo nudo", "Vegetazione rada"))
levels(class_post2024) <- data.frame(value = c(1, 2, 3), label = c("Vegetazione", "Suolo nudo", "Vegetazione rada"))

#assegnazione colori personalizzati alle 3 classi
colori <- c(
  "Vegetazione" = "chartreuse4",
  "Suolo nudo" = "honeydew4",
  "Vegetazione rada"  = "darkorange1"
)

#visualizzazione delle classificazioni
im.multiframe(1, 3)   #suddivisione finestra grafica in 1 riga e 3 colonne
plot(class_pre, col = colori,  main = "Pre incendio", legend = FALSE)
plot(class_post, col = colori, main = "Post incendio", legend = FALSE)
plot(class_post2024, col = colori, main = "Due anni dopo", legend = FALSE)
#aggiunta manuale di una legenda unica per i tre grafici in basso a sinistra
legend("bottomleft",            #posizione della legenda in basso a sinistra 
       legend = names(colori),  #definizione delle etichette della legenda
       fill = colori,           #definizione dei colori nel riquadro della legenda
       title = "Classe"         #titolo delle legenda
       bg = "white",            #impostazione del colore dello sfondo
       xpd = TRUE)              #la legenda può essere disegnata fuori dall'area del grafico
dev.off()

#calcolo delle frequenze 
f_pre <- freq(class_pre)
f_post <- freq(class_post)
f_post2024 <- freq(class_post2024)

#calcolo delle proporzioni
prop_pre <- f_pre$count / ncell(class_pre)
prop_post <- f_post$count / ncell(class_post)
prop_post2024 <- f_post2024$count / ncell(class_post2024)

#calcolo delle percentuali
perc_pre <- prop_pre * 100
perc_post <- prop_post * 100
perc_post2024 <- prop_post2024 * 100

#creazione tabella riassuntiva delle percentuali per ogni fase
tabella <- data.frame(
  class = c("Vegetazione", "Suolo nudo", "Vegetazione rada"),
  Pre_incendio = perc_pre,
  Post_incendio = perc_post,
  Post_2024 = perc_post2024
)

#visualizzazione della tabella
tabella

# Generazione di istogrammi per il confronto
p1 <- ggplot(tabella, aes(x = class, y = perc_pre, fill = class)) +             #creazione del grafico usando il dataset tabella
  geom_bar(stat = "identity") +                                                 #definizione del tipo di grafico (grafico a barre)                       
  ylim(c(0, 100)) +                                                             #limiti asse y
  scale_fill_manual(values = colori) +                                          #impostazione manuale dei colori delle barre
  labs(title = "Copertura Post incendio", x = "Classe", y = "Percentuale (%)")  #definizione etichette del grafico
  theme(legend.position = "none")                                               #elimina la legenda del grafico

p2 <- ggplot(tabella, aes(x = class, y = perc_post, fill = class)) +
   geom_bar(stat = "identity") +
   ylim(c(0, 100))+
   scale_fill_manual(values = colori) +
   labs(title = "Copertura Post incendio", x = "Classe", y = "Percentuale (%)") +
   theme(legend.position = "none")

p3 <- ggplot(tabella, aes(x = class, y = perc_post2024, fill = class)) +
   geom_bar(stat = "identity") +
   ylim(c(0, 100))+
   scale_fill_manual(values = colori) +
   labs(title = "Copertura due anni dopo", x = "Classe", y = "Percentuale (%)") 

#visualizzazione dei grafici uno accanto all'altro
p1 + p2 + p3
