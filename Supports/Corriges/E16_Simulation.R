## ----defaults,results='hide',echo=FALSE----------------------------------
require(MASS,quietly=T,warn.conflicts=FALSE)
require(xtable,quietly=T,warn.conflicts=FALSE)
require(stringr,quietly=T,warn.conflicts=FALSE)
require(RSQLite,quietly=T,warn.conflicts=FALSE)
require(foreign,quietly=T,warn.conflicts=FALSE)

# suppressPackageStartupMessages(require(sp,quietly=T,warn.conflicts=FALSE))
# suppressPackageStartupMessages(require(maptools,quietly=T,warn.conflicts=FALSE))
# suppressPackageStartupMessages(require(rgdal,quietly=T,warn.conflicts=FALSE))
# suppressPackageStartupMessages(require(maps,quietly=T,warn.conflicts=FALSE))
suppressPackageStartupMessages(require(dplyr,quietly=T,warn.conflicts=FALSE))
suppressPackageStartupMessages(require(ggplot2,quietly=T,warn.conflicts=FALSE))

suppressPackageStartupMessages(require(XLConnect,quietly=T,warn.conflicts=FALSE))

opts_chunk$set(fig.path='graphiques/beamer-',fig.align='center',fig.show='hold',size='footnotesize',
               fig.height=7,fig.width=7,out.width="\\textwidth",resize.height="0.6\\textheight",
               tidy=FALSE,prompt=TRUE,eval=FALSE
               )

options(width=45)

correction <- TRUE

## ----echo=correction-----------------------------------------------------
a <- rnorm(10000)
plot(a)

## ----echo=correction-----------------------------------------------------
hist(a)

## ----echo=correction-----------------------------------------------------
a <- rnorm(10000,mean=2,sd=4)

## ----echo=correction-----------------------------------------------------
hist(a)

## ----echo=correction-----------------------------------------------------
a <- rbinom(10000,size = 1, prob = 1 / 2 )
mean(a)
sd(a)
table(a)

## ----echo=correction-----------------------------------------------------
k <- 10
n <- 10
m <- c()
for (ii in 1:k) {
  m <- c( m, mean( rbinom(n, size = 1, prob = 1/2 ) ) )
}
m

## ----echo=correction-----------------------------------------------------
hist(m)

## ----echo=correction-----------------------------------------------------
k <- 10000
n <- 10
m <- c()
for (ii in 1:k) {
  m <- c( m, mean(rbinom(10,size = 1, prob = 1 / 2 )) )
}

## ----echo=correction-----------------------------------------------------
hist(m)

## ----echo=correction-----------------------------------------------------
matrix(valeurs,nrow=k,ncol=k)

## ----echo=FALSE----------------------------------------------------------
k <- 1000

## ----echo=correction-----------------------------------------------------
matrice <- matrix(NA,nrow=k,ncol=k) 
for (ii in 1:k) {
  for (jj in 1:k) {
    matrice[ii,jj] <- rnorm(1)
  }
}

## ----echo=correction-----------------------------------------------------
matrice <- matrix(NA,nrow=k,ncol=k) 
for (ii in 1:k) {
  matrice[ii,] <- rnorm(k)
}

## ----echo=correction-----------------------------------------------------
matrice <- matrix(1,nrow=k,ncol=k) 
matrice <- apply(matrice,1:2,rnorm)

## ----echo=correction-----------------------------------------------------
matrice <- rnorm(k^2) 
dim(matrice) <- c(k,k)

# je sais, c'est pas esthétique.

