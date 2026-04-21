# Code for classifying data

library(terra)
library(imageRy)

#usiamo le immagini di terra. Listing files:
im.list()

#importiamo il dato (l'immagine)
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
plot(sun)

#classify
sunc <- im.classify(sun)
sunc <- im.classify(sun, seed=3)
sunc <- im.classify(sun, seed=42)

# import Grand Canyon data
can <- im.import("dolansprings_oli_2013088_canyon_lrg.jpg")

# classify Gran Canyon data
cancc <- im.classify(can, num_cluster = 4, seed=42)

# classifying data out of R
setwd("C:/Users/Giulia/Downloads/drone")
getwd()

list.files()

#import data
sir <- rast("sirolo1.jpg")
sir <- flip(sir)
plot(sir)

# classify data
sirc <- im.classify(sir, num_clusters = 3)
sirc <- im.classify(sir, num_clusters = 5)

# Mato grosso example
im.list()
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

par(mfrow=c(2,1))
plot(m1992)
plot(m2006)

# classifichiamo l'immagine del 1992
m1992c <- im.classify(m1992, num_clusters = 2, seed=42)

#Assign labels: creiamo un dataframe con una colonna con valori 1 e 2 e una colonna con le label "forest" e "human" --> inserisco le etichette come due livelli nella mappa

levels(m1992c) <- data.frame(
  value = c(1, 2),
  label = c("forest", "human")
)

plot(m2006c)

# faccio lo stesso per m2006

m2006c <- im.classify(m2006, num_clusters = 2, seed=42)

# Assign labels
levels(m2006c) <- data.frame(
  value = c(2, 1),
  label = c("forest", "human")
)

plot(m2006c)

# calculating frequencies con la funzioen freq
f1992 <- freq(m1992c)

# percentuale --> frequenze/numero totale di celle = proporzione di foreste e umani x 100
prop1992 <- f1992$count / ncell(m1992c)
perc1992 <- prop1992*100

#facciamo lo stesso epr il 2006
f2006 <- freq(m2006c)
prop2006 <- f2006$count / ncell(m2006c)
perc2006 <- prop2006*100

# possiamo creare una tabella = dataframe per fare gli istogrammi 
# table con funzione data.frame(varie colonne con nomi delle colonne e valori)
tabout <- data.frame(
  class=c("Forest", "Human"),
  perc1992=c(83, 17),
  perc2006=c(45, 55)
  )



