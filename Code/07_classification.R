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
