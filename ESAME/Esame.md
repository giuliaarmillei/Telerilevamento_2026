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


# Visualizzazione delle immagini in RGB




# Visualizzazione delle quattro bande separate per le tre immagini (luglio 2022 - agosto 2022 - agosto 2024)



# Visualizzazione immagini a falsi colori









