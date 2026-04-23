install.packages("qrcode")

library(qrcode)

url <- "https://github.com/giuliaarmillei"

qr <- qr_code(url)

setwd("C:/Users/Giulia/OneDrive - Alma Mater Studiorum Università di Bologna/Desktop")
getwd()

png("github_profile_qr.png", width = 1000, height = 1000)
plot(qr)
dev.off()
