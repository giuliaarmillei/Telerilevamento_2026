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

