library(terra)
library(imageRy)

im.list()
EN_01 <- im.import("EN_01.png"))
plot(EN_01)
EN_01 <- flip(EN_01)
plot(EN_01)
EN_13 <- im.import("EN_03.png")
EN_13 <- flip(EN_13)
plot(EN_13)

#esercizio: osservare le due immagini una dopra l'altra
par(mfrow=c(2,1))
plot(EN_01)
plot(EN_13)

#differencing
ENdif <- EN_01[[1]] - EN_13[[1]] 
dev.off()
plot(ENdif)
