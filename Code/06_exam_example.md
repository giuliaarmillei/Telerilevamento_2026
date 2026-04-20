# The Richat Structure: questo sarà il titolo del progetto d'esame

in questa riga scrivo l'intro alle mie analisi

## Pacchetti utilizzati
per questo esame ho usato ... pacchetti: 
```r

library(terra)

```

# Importazione dei dati
i dati sono stati scaricati da Earth Observatory: https://science.nasa.gov/earth/earth-observatory/eyeing-the-richat-structure/

oppure 

i dati sono stati scaricati da [Earth Observatory](https://science.nasa.gov/earth/earth-observatory/eyeing-the-richat-structure/)

Il codice utilizzato è il seguente. Prima di tutto selezioniamo la working directory:
```r
setwd("C:/Users/Giulia/Downloads/drone")
getwd()
list.files()
```
per importare i dati è stata usata la funzione `rast()` del pacchetto `terra`:
```r
richat <- rast("richatstructure_oli_20260306.jpg")
richat <- flip(richat)
plot(richat)
```

<img width="480" height="480" alt="figurarichat" src="https://github.com/user-attachments/assets/4da4c546-21d0-4f3d-9016-accba7ded33c" />

## Analisi esplorativa: plottaggio delle singole bande
Le singole bande sono state plottate usando un multiframe:
```r
par(mfrow=c(2,1))
plot(richat[[1]])
plot(richat[[2]])
```

questo è l'output dell'analisi
<img width="480" height="480" alt="bande" src="https://github.com/user-attachments/assets/4ec48ab3-f277-4d6c-af11-621c53c174e8" />





