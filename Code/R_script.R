# First R script

# oggetti (michele) e assegnazione (<- o = )
michele <- 2 + 3
michele = 2 + 3 

tecla <- 4 + 6
#tutte le operazioni
michele + tecla
michele/tecla
michela^tecla

#arrays o vettori
sonia <- c(10, 8, 3, 1, 0)
giorgia <- c(3, 10, 20, 50, 100)
plot(giorgia, sonia)
plot(giorgia, sonia, col="blue", phc=19)
plot(giorgia, sonia, pch=19, cex=2, xlab="pollution", ylab="numero di delfini")

# installazione pacchetti da CRAN
install.packages("terra")
library(terra)

#installazione con GitHub
install.packages("devtools")
library(devtools)
install_github("ducciorocchini/imageRy")
