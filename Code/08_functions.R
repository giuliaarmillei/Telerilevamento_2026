# My functions

somma <- function(x,y){
  z=x+y
  return(z)
  }

# Excercise : make the function calle difference
differenza <- function(x,y){
  z=x-y
  return(z)
  }

# par = creo la funzione par in modo da non dover scrivee tutto mfrow 
mf <- function(nx,ny){
  par(mfrow=c(nx,ny))
  }

# in questo caso creiamo la funzione par con già elementi di default di righe e colonne 
mf2 <- function(nx=1, ny=2){
  per(mfrow=c(nx,ny))
  }

# if else: se --> allora = è una funzione con messaggio che noi definiiamo. positivo(6) --> "Questo numero è positivo"

positivo <- function(x){
  if(x>0) {
    "Questo numero è positivo"
    }
  else if(x<0) {
    "Questo numero è negativo"
    }
  else {
    "Zero non è negativo nè positivo"
    }
  }

# ciclo for (utile se dobbiamo ripetere l'operazione più volte) = con questa funzione se poi scrivo loop() R mi restituisce tutti gli i cioè tutti i numeri da 1 a 50.

loop <- function() {
  for(i in 1:50) {
    print(i)
    }
  }

# ciclo for che mi restituisce l'operazione che scrivo
loop2 <- function() {
  for(i in 1:50) {
  op <- i * 7
  print(op)
    }
  }

sent <- im.import("Sentinel2_NDVI_2020-11-27.tif")
mf(1,2)
plot(sent)
plot(sent)
