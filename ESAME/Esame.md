# Analisi di impatto sulla vegetazione in seguito all'incendio di Serra da Estrela (2022)


# Introduzione
...

foto immagine

# Obiettivi dell'analisi

....

# Metodologia

# Raccolta immagini

# Importazione e visualizzaizone immagini

```r
setwd("C:/Users/Giulia/OneDrive - Alma Mater Studiorum Università di Bologna/Desktop/esame")
getwd()
```

Pacchetti installati

```r
library(terra) #
library(imageRy) #
library(viridis) #
library(ggplot2) #
library(patchwork) #
```

Impostiamo i raster Sentinel-2
```r
pre <- rast("Preincendio_luglio2022.tif")
plot(pre)
```
<img width="480" height="480" alt="preincendio" src="https://github.com/user-attachments/assets/aa1b2894-01a0-4804-97b5-bd3c6b0a50f2" />

```r
post <- rast("Postincendio_agosto2022.tif")
plot(post)
```
<img width="480" height="480" alt="post_incendio" src="https://github.com/user-attachments/assets/2368d922-57ed-4186-8e24-14d76af9d5c1" />

```r
post2024 <- rast("SerradaEstrela_agosto2024.tif")
plot(post2024)
```
<img width="480" height="480" alt="post2024" src="https://github.com/user-attachments/assets/8a22f615-c6ea-4912-8bc9-b6a6c49e8706" />

# Visualizzazione delle immagini in RGB

```r
im.multiframe(1,3)
plotRGB(pre, r = 3, g = 2, b = 1, stretch = "lin", main = "Pre-incendio")
plotRGB(post, r = 3, g = 2, b = 1, stretch = "lin", main = "Post-incendio")
plotRGB(post2024, r = 3, g = 2, b = 1, stretch = "lin", main = "Post-2024")
dev.off()
```

<img width="480" height="480" alt="truecolor" src="https://github.com/user-attachments/assets/195eaedb-6229-4f7d-9408-df5de30126e9" />

# Visualizzazione delle quattro bande separate per le tre immagini (luglio 2022 - agosto 2022 - agosto 2024)

```r
im.multiframe(3,4)
plot(pre[[1]], col = magma(100), main = "pre - B2")
plot(pre[[2]], col = magma(100), main = "pre - B3")
plot(pre[[3]], col = magma(100), main = "pre - B4")
plot(pre[[4]], col = magma(100), main = "pre - B8")
plot(post[[1]], col = magma(100), main = "post - B2")
plot(post[[2]], col = magma(100), main = "post - B3")
plot(post[[3]], col = magma(100), main = "post - B4")
plot(post[[4]], col = magma(100), main = "post - B8")
plot(post2024[[1]], col = magma(100), main = "post2024 - B2")
plot(post2024[[2]], col = magma(100), main = "post2024 - B3")
plot(post2024[[3]], col = magma(100), main = "post2024 - B4")
plot(post2024[[4]], col = magma(100), main = "post2024 - B8")
dev.off
```
<img width="480" height="480" alt="preincendio" src="https://github.com/user-attachments/assets/571ba327-235a-4a92-a645-3a696d5dc0d6" />

# Visualizzazione immagini a falsi colori

```r
im.multiframe(1,3)
plotRGB(pre, r = 4, g = 3, b = 2, stretch = "lin", main = "Pre-incendio")
plotRGB(post, r = 4, g = 3, b = 2, stretch = "lin", main = "Post-incendio")
plotRGB(post2024, r = 4, g = 3, b = 2, stretch = "lin", main = "Post-2024")
dev.off()
```

<img width="480" height="480" alt="falsecolor" src="https://github.com/user-attachments/assets/562ef83c-fa9b-4943-89b2-622f4b216e5a" />







