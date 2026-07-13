# Analisi di impatto sulla vegetazione in seguito all'incendio di Serra da Estrela (2022)


# Introduzione
...

foto immagine

# Obiettivi dell'analisi

....

# METODOLOGIA


# Raccolta immagini


# Impostazione della working directory

```r
setwd("C:/Users/Giulia/OneDrive - Alma Mater Studiorum Università di Bologna/Desktop/esame")
getwd() #verifica della working directory
list.files() #lista dei file all'interno della working directory
```

# Caricamento pacchetti utilizzati nello studio

```r
library(terra) #
library(imageRy) #
library(viridis) #
library(ggplot2) #
library(patchwork) #
```

# Impostazione e visualizzazione dati raster Sentinel - 2

PRE-INCENDIO (LUGLIO 2022)
```r
pre <- rast("Preincendio_luglio2022.tif") #importazione 
plot(pre) #visualizzazione delle bande spettrali
```

<img width="480" height="480" alt="preincendio" src="https://github.com/user-attachments/assets/f30bf323-68c3-4378-9b2c-323013d30e4f" />


POST-INCENDIO (AGOSTO 2022)
```r
post <- rast("Postincendio_agosto2022.tif") 
plot(post) 
```

<img width="480" height="480" alt="postincendio" src="https://github.com/user-attachments/assets/d8256580-903c-4dad-a984-8e0cedda3720" />


# Composizione RGB a colori naturali 

```r
# Suddivisione della finestra grafica in 1 riga e 2 colonne
im.multiframe(1,2)

# Visualizzazione a colori naturali con schema RGB (B4=Red=layer3, B3=Green=layer2, B2=Blu=layer1)
plotRGB(pre, r = 3, g = 2, b = 1, stretch = "lin", main = "Pre-incendio")
plotRGB(post, r = 3, g = 2, b = 1, stretch = "lin", main = "Post-incendio")

dev.off()
```

<img width="480" height="480" alt="truecolor" src="https://github.com/user-attachments/assets/a366fddd-e70c-46f4-aa07-ca11f83debe2" />

La composizione RGB a colori naturali permette di effettuare un primo confronto qualitativo tra le condizioni dell'area di studio pre e post incendio, evidenziando le variazioni della copertura vegetale e le aree percorse dal fuoco, che appaiono con tonalità più scure o brunaste. 


# Visualizzazione delle singole bande del visibile (B2, B3, B4) e del vicino infrarosso (B8) pre e post incendio

```r
im.multiframe(2,4) #suddivisione della finestra grafica in 2 righe e 4 colonne

# Pre-incendio (luglio2022)
plot(pre[[1]], col = magma(100), main = "Pre-incendio, B2")
plot(pre[[2]], col = magma(100), main = "Pre-incendio, B3")
plot(pre[[3]], col = magma(100), main = "Pre-incendio, B4")
plot(pre[[4]], col = magma(100), main = "Pre-incendio, B8")

# Post-incendio (agosto2022)
plot(post[[1]], col = magma(100), main = "Post-incendio, B2")
plot(post[[2]], col = magma(100), main = "Post-incendio, B3")
plot(post[[3]], col = magma(100), main = "Post-incendio, B4")
plot(post[[4]], col = magma(100), main = "Post-incendio, B8")

dev.off()
```

<img width="480" height="480" alt="singolebarre" src="https://github.com/user-attachments/assets/57a3c0ae-1e56-401f-a34a-f7e049986766" />

La visualizzazione separata delle bande del visibile (blu, verde e rosso) e dalla banda del vicino infrarosso (NIR) consente di analizzare le modifiche della risposta spettrale delle diverse superfici prima e dopo l'incendio. In particolare, osservando la banda del NIR, sensibile alla presenza e allo stato di salute della vegetazione, si nota una diminuzione della riflettanza, in seguito all'incendio. 

# Visualizzazione immagini a falsi colori









