# ANALISI DELL'IMPATTO SULLA VEGETAZIONE IN SEGUITO ALL'INCENDIO DEL 2022 NELLA SERRA DA ESTRELA (PORTOGALLO)

**Esame di telerilevamento geo-ecologico in R 2026**  
**Giulia Armillei**

## INTRODUZIONE

Nell'agosto del 2022, il Parco Nazionale della Serra da Estrela, in Portogallo, è stato devastato dal più grande incendio boschivo degli ultimi 50 anni. Alimentato da temeprature estreme e forti venti, l'incendio ha bruciato 25.000 ettari di territorio, costringendo all'evacuazione le comunità locali. L'evento ha interessato habitat montani di elevato valore ecologico, provocando ingenti danni alla vegetazione naturale e agli ecosistemi locali. Le immagini satellitari di Sentinel-2 (programma Copernicus) permettono di analizzare gli effetti dell'incendio boschivo del 2022 sulla vegetazione della Serra da Estrela, valutando tre diverse fasi:

* Luglio 2022 (01/07/2022 - 31/07/2022): situazione pre-incendio
  
* Agosto 2022 (10/08/2022 - 31/08/2022): situazione post-incendio
  
* Agosto 2024 (10/08/2024 - 31/08/2024): situazione di recupero, due anni dopo l'incendio

<img width="737" height="496" alt="posizione serra" src="https://github.com/user-attachments/assets/b5ca54ec-723a-4393-acdb-8a7127a652db" />


## OBIETTIVI 

L'obiettivo dell'analisi è di valutare le variazioni della copertura vegetale nell'area della Serra da Estrela pre e post incendio e di osservare il recupero vegetazionale due anni dopo l'evento, attraverso l'analisi multitemporale e l'elaborazione quantitativa di indici di vegetazione:

* **DVI**: Difference Vegetation Index
* **NDVI**: Normalized Difference Vegetation Index

## METODOLOGIA

### Raccolta immagini
Le immagini sono state acquisite dal portale web di [Google Earth Engine](https://earthengine.google.com/), selezionando l'area colpita dall'incendio e le date sopra riportate. 

### Impostazione della working directory

```r
setwd("C:/Users/Giulia/OneDrive - Alma Mater Studiorum Università di Bologna/Desktop/esame")
getwd() #verifica della working directory
list.files() #lista dei file all'interno della working directory
```

### Caricamento pacchetti utilizzati nello studio

```r
library(terra) # Gestione, elaborazione e analisi dei dati raster
library(imageRy) # Visualizzazione ed elaborazione di immagini raster
library(viridis) # Palette di colori per grafici 
library(ggplot2) # Creazione di grafici personalizzati
library(ggridges) # Realizzazione di ridgline plot per il confronto di distribuzioni
library(patchwork) # Combinazione di più grafici in un'unica figura
```

### Impostazione e visualizzazione dati raster Sentinel - 2

**PRE-INCENDIO (LUGLIO 2022)**
```r
pre <- rast("Preincendio_luglio2022.tif") #importazione 
plot(pre) #visualizzazione delle bande spettrali
```

<img width="480" height="480" alt="preincendio" src="https://github.com/user-attachments/assets/f30bf323-68c3-4378-9b2c-323013d30e4f" />


**POST-INCENDIO (AGOSTO 2022)**
```r
post <- rast("Postincendio_agosto2022.tif") 
plot(post) 
```

<img width="480" height="480" alt="postincendio" src="https://github.com/user-attachments/assets/d8256580-903c-4dad-a984-8e0cedda3720" />


### Composizione RGB a colori naturali 

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


### Visualizzazione delle singole bande del visibile (B2, B3, B4) e del vicino infrarosso (B8) pre e post incendio

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

### Visualizzazione immagini a falsi colori

???

### Analisi DVI

Il **Difference Vegetation Index (DVI)** è un indice di vegetazione ottenuto come diiferenza tra la riflettanza della banda del vicino infrarosso (NIR) e quella della banda del rosso (Red):

**DVI = NIR - Red**

La vegetazione sana riflette intensamente la radiazione nel vicino infrarosso e assorbe gran parte della radiazione nel rosso, per i processi fotosintetici. di conseguenza è usato per valutare la presenza di vegetazione: valori elevati di DVI indicano una vegetazione vigorosa e con elevata attività fotosintetica. 
È un indice non normalizzato, ma fornisce informazioni comparative, per evidenziare la perdita di vegetazione causata dal fuoco. 

Per il calcolo dell'indice pre e post incendio utilizzo la funzione `im.dvi` del pacchetto `imageRy` 

```r
# calcolo dell'indice pre e post incendio 
dvi_pre <- im.dvi(pre, 4, 3)
dvi_post <- im.dvi(post, 4, 3)

# visualizzazione indici per il confronto temporale
im.multiframe(1,2) #suddivisione della finestra grafica in 1 riga e 2 colonne
plot(dvi_pre, col = cividis(100), main = "DVI luglio 2022")
plot(dvi_post, col = cividis(100), main = "DVI agosto 2022")
dev.off()
```

<img width="480" height="480" alt="indicidvi" src="https://github.com/user-attachments/assets/6a1a8c40-a1f0-4293-8c0b-e79d5711d308" />

Il confronto tra i valori del DVI pre e post incendio evidenzia una riduzione della risposta vegetazionale in seguito all'evento del 2022, dovuta alla perdita di biomassa vegetale. 

```r
dvi_diff <- dvi_post - dvi_pre # differenza tra gli indici dvi pre e post incendio
plot(dvi_diff, col = cividis(100), main = "Differenza DVI pre-post incendio")
```

<img width="480" height="480" alt="Diidvi" src="https://github.com/user-attachments/assets/07a3c41b-2304-4745-859b-7796daad092c" />

La differenza tra gli indici DVI pre e post incendio, permette di evidenziare spazialemente le aree maggiormente colpite dal passaggio del fuoco e caratterizzate dalla maggior perdita di attività fotosintetica, in corrispondenza di valori negativi-

### Analisi NDVI

Il **Normalized Difference Vegetation Index (NDVI)** è uno degli indici di vegetaione più utilizzati nell'ambito del telerilevamento per valutare lo stato e il vigore della copertura vegetale. Come per il DVI, si basa sulle caratteristiche spettrali della vegetazione, che assorbe la radiazione nella banda del rosso e riflette invece le radiazioni nel vicino infrarosso. 
A differenza del DVI, però, l'NDVI è un indice normalizzato che assomu valori compresi tra -1 e +1:

**$NDVI = \frac{NIR - Red}{NIR + Red}$**

* Valori prossimi a +1 indicano una vegetazione densa, sana e caratterizzata da elevata attività fotosintetica
* Valori intorno allo 0 sono associati a vegetazione rada, arbustiva o a suoli privi di vegetazione
* Valori prossimi a -1 indicano superfici non vegetate come corpi idrici e aree urbanizzate

Per il calcolo degli indici NDVI pre e post incendio ho usato la funzione `im.ndvi` del pacchetto `imageRy`

```r
# calcolo indici con la funzione im.ndvi del pacchetto imageR
ndvi_pre <- im.ndvi(pre, 4, 3)
ndvi_post <- im.ndvi(post, 4, 3)

# visualizzazione indici per il confronto temporale
im.multiframe(1,2) #suddivisione della finestra grafica in 1 riga e 2 colonne
plot(ndvi_pre, col = inferno(100), main = "NDVI luglio 2022")
plot(ndvi_post, col = inferno(100), main = "NDVI agosto 2022")
dev.off()
```
<img width="480" height="480" alt="ndvi" src="https://github.com/user-attachments/assets/f8bf5185-7207-4276-9ae9-b50139085a4b" />

commento...

### Analisi statistica della densità di distribuzione dell'indice NDVI

cos'è e a cosa serve

```r
# creazione dello stack con i due indici NDVI pre e post incendio
stack_ndvi <- c(ndvi_pre, ndvi_post)

# assegnazione dei nomi ai due elementi dello stack
names(stack_ndvi) <- c("NDVI_Pre", "NDVI_Post")

# generazione del ridgeline plot con la funzione im.ridgeline
im.ridgeline(stack_ndvi, scale = 1, palette = "inferno")
```

<img width="480" height="480" alt="ridgelineplot" src="https://github.com/user-attachments/assets/e74d3071-789d-4ae5-89a0-e224d916d357" />

commento...



