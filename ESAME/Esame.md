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

### Importazione e visualizzazione dati raster Sentinel - 2

**Pre-incendio (luglio 2022)**
```r
pre <- rast("Preincendio_luglio2022.tif") #importazione 
plot(pre) #visualizzazione delle bande spettrali
```

<img width="800" height="480" alt="pre" src="https://github.com/user-attachments/assets/66109608-ed7c-4cc2-a188-349caa4f79cb" />

**Post-incendio (agosto 2022)**
```r
post <- rast("Postincendio_agosto2022.tif")
plot(post)
```

<img width="800" height="480" alt="post" src="https://github.com/user-attachments/assets/6b1bfeae-9224-49f2-a2e7-195b75ab75b6" />

**Due anni dopo l'incendio (agosto 2024)**
```r
post2024 <- rast("SerradaEstrela_agosto2024.tif")
plot(post2024)
```

<img width="800" height="480" alt="post2024" src="https://github.com/user-attachments/assets/435b6b1b-9084-4dc6-a780-36d7978f902a" />

### Composizione RGB a colori naturali 
```r
# Suddivisione della finestra grafica in 1 riga e 3 colonne
im.multiframe(1, 3)

# Visualizzazione a colori naturali con schema RGB (B4=Red=layer3, B3=Green=layer2, B2=Blu=layer1)
plotRGB(pre, r = 3, g = 2, b = 1, stretch = "lin", main = "Pre-incendio")
plotRGB(post, r = 3, g = 2, b = 1, stretch = "lin", main = "Post-incendio")
plotRGB(post2024, r = 3, g = 2, b = 1, stretch = "lin", main = "Due anni dopo")

# Chiusura finestra grafica corrente
dev.off() 
```

<img width="800" height="480" alt="rgb" src="https://github.com/user-attachments/assets/c4bd3950-fb4f-41b3-b528-fdec7be40f59" />

La composizione RGB a colori naturali permette di effettuare un primo confronto qualitativo tra le condizioni dell'area di studio pre e post incendio, evidenziando le variazioni della copertura vegetale e le aree percorse dal fuoco, che appaiono con tonalità più scure o brunaste. A due anni dall'evento, si osserva un parziale ripristino delle tonalità verdi in alcune porzioni dell'area, segnale della rigenerazione della vegetazione e in altre zone invece un recupero incompleto.   

### Visualizzazione delle singole bande del visibile (B2, B3, B4) e del vicino infrarosso (B8) pre e post incendio

```r
im.multiframe(3, 4) #suddivisione della finestra grafica in 3 righe e 4 colonne

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

# Due anni dopo (agosto 2024)
plot(post2024[[1]], col = magma(100), main = "Due anni dopo, B2")
plot(post2024[[2]], col = magma(100), main = "Due anni dopo, B3")
plot(post2024[[3]], col = magma(100), main = "Due anni dopo, B4")
plot(post2024[[4]], col = magma(100), main = "Due anni dopo, B8")

dev.off()
```

<img width="800" height="800" alt="singole bande" src="https://github.com/user-attachments/assets/f4bfaaa6-9bc1-4585-a326-3b794be172b9" />

La visualizzazione separata delle bande del visibile (blu, verde e rosso) e dalla banda del vicino infrarosso (NIR) consente di analizzare le modifiche della risposta spettrale delle diverse superfici nelle tre diverse fasi analizzate. In particolare, osservando la banda del NIR, sensibile alla presenza e allo stato di salute della vegetazione, si nota una diminuzione della riflettanza, in seguito all'incendio e una ripresa due anni dopo. 


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
dvi_post2024 <- im.dvi(post2024, 4, 3)

# visualizzazione indici per il confronto temporale
im.multiframe(1, 3) #suddivisione della finestra grafica in 1 riga e 3 colonne
plot(dvi_pre, col = cividis(100), main = "DVI luglio 2022")
plot(dvi_post, col = cividis(100), main = "DVI agosto 2022")
plot(dvi_post2024, col = cividis(100), main = "DVI agosto 2024")
dev.off()
```

<img width="480" height="480" alt="dvi" src="https://github.com/user-attachments/assets/5c57e787-670d-4c11-823a-72854dbb7062" />


Il confronto tra i valori del DVI pre e post incendio evidenzia una riduzione della risposta vegetazionale in seguito all'evento del 2022, dovuta alla perdita di biomassa vegetale. A due anni dall'evento, l'analisi mostra un incremento dei valori di DVI rispetto alla situazione immediatamente successiva all'incendio, evidenziando l'avvio dei processi di rigenerazione della vegetazione. 


```r
# calcolo differenze indici
dvi_diff1 <- dvi_post - dvi_pre
dvi_diff2 <- dvi_post2024 - dvi_post
dvi_diff3 <- dvi_post2024 - dvi_pre

# visualizzazione differenze indici per il confronto temporale
im.multiframe(1, 3) # suddivisione finestra grafica in 1 riga e 3 colonne
plot(dvi_diff1, col = cividis(100), main = "luglio2022 - agosto2022")
plot(dvi_diff2, col = cividis(100), main = "agosto2022 - agosto2024")
plot(dvi_diff3, col = cividis(100), main = "luglio2022 - agosto2024")
dev.off()
```

<img width="480" height="480" alt="diffdvi" src="https://github.com/user-attachments/assets/da896d18-3308-4b76-9f4d-52128586e866" />

Questi tre confronti sono completari:il primo evidenzia l'area maggiormente colpito dal passaggio delle fiamme, in corrispondenza dei valori negativi; gli altri due descrivono il recupero nel tempo rispetto alla condizione pre incendio e immediatamente successiva. Nel terzo confronto si osservano zone con valori prossimi allo zero, ad indicare una vegetazione con condizioni simili a quelle pre incendio, ma anche zone con valori negativi, in cui il recupero è ancora incompleto.    

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

# visualizzazione indici 
im.multiframe(1,3) #suddivisione della finestra grafica in 1 riga e 3 colonne
plot(ndvi_pre, col = inferno(100), main = "NDVI luglio 2022")
plot(ndvi_post, col = inferno(100), main = "NDVI agosto 2022")
plot(ndvi_diff, col = inferno(100), main = "Differenza NDVI")
dev.off()
```

<img width="480" height="480" alt="indicindvi" src="https://github.com/user-attachments/assets/ad12370c-7c57-42af-be22-66e51736093f" />

Il confronto degli indici pre e post incendio mostra una diminuzione dei valori nelle aree percorse dal fuoco, evidenziando la perdita di copertura vegetale e di attività fotosintetica. 

```r
# calcolo differenza inidici ndvi
ndvi_diff1 <- ndvi_post - ndvi_pre
ndvi_diff2 <- ndvi_post2024 - ndvi_post
ndvi_diff3 <- ndvi_post2024 - ndvi_pre

# visualizzazione differenze indici per il confronto temporale
im.multiframe(1, 3) # suddivisione finestra grafica in 1 riga e 3 colonne
plot(ndvi_diff1, col = inferno(100), main = "luglio2022 - agosto2022")
plot(ndvi_diff2, col = inferno(100), main = "agosto2022 - agosto2024")
plot(ndvi_diff3, col = inferno(100), main = "luglio2022 - agosto2024")
dev.off()
```

<img width="480" height="480" alt="diffndvi" src="https://github.com/user-attachments/assets/0d8a8b31-81eb-450f-8db4-99e73fc44cd2" />


### Analisi multitemporale della distribuzione dell'NDVI mediante ridgeline plot

Il ridgeline plot permette di analizzare e confrontare la distribuzione dei valori dell'indice NDVI nelle diverse date di acquisizione delle immagini satellitari, evidenziando le variazioni della risposta della vegetazione nel periodo precedente e successivo all'incendio. 

```r
# creazione dello stack con i due indici NDVI pre e post incendio
stack_ndvi <- c(ndvi_pre, ndvi_post, ndvi_post2024)

# assegnazione dei nomi ai due elementi dello stack
names(stack_ndvi) <- c("NDVI_Pre", "NDVI_Post", "NDVI_Post2024")

# generazione del ridgeline plot con la funzione im.ridgeline
im.ridgeline(stack_ndvi, scale = 1, palette = "inferno")
```

<img width="480" height="480" alt="ridgeline" src="https://github.com/user-attachments/assets/a98eb0b6-5dd1-496d-81e5-76a905594b02" />


Dopo l'incendio si osserva uno spostamento della distribuzione verso valori più bassi di NDVI e, nello specifico, a una diminuzione della densità dei valori elevati e l'aumento della densità di valori bassi. Dopo due anni, la distribuzione assomiglia a quella pre incendio, con una diminuzione della densità di valori vicino allo zero e un aumento dei valori prossimi a 0.5 e 1.0 





