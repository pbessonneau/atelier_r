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


## ------------------------------------------------------------------------
my.hist <- function(x,col="red",ylab="Effectifs",...) {
  hist(x,...,col="red",ylab=lab)
}

my.hist <- function(x,col="red",ylab=NULL,freq=T,...) {
  if (freq) ylab <- "Effectif"
  else ylab <- "Densité"
  hist(x,...,freq=freq,col="red",ylab=ylab)
}

## ----echo=FALSE----------------------------------------------------------
my.hist(rnorm(1000),breaks=50) 

## ------------------------------------------------------------------------
francais <- function(x,digits=2) {
  gsub(".",",",round(x,digits),fixed=TRUE)
}

## ------------------------------------------------------------------------
francais(rnorm(5,100,50))

## ------------------------------------------------------------------------
a=matrix(rnorm(3^2,100,50),ncol=3,nrow=3)
apply(a,1:2,francais)

## ------------------------------------------------------------------------
summarize <- function(x,na.rm=T...) {
  return(c(
    quantile(x,na.rm=T),
    Moy=mean(x,na.rm=T),
    EC=sd(x,na.rm=T)
  ))
}
t(sapply(iris[,1:4],summarize))

## ------------------------------------------------------------------------
summarize(iris$Sepal.Width)

## ------------------------------------------------------------------------
a = c( setosa = "typeA", versicolor = "typeB",
       virginica = "typeC" )
sample(a[iris$Species],5)

## ------------------------------------------------------------------------
a = c( setosa = "typeA", versicolor = "typeB",
       virginica = "typeC" )
sample(a[iris$Species],5)

