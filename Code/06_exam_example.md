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
