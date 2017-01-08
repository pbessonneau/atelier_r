## ----defaults,results='hide',echo=FALSE----------------------------------
require(MASS,quietly=T,warn.conflicts=FALSE)
require(xtable,quietly=T,warn.conflicts=FALSE)
require(stringr,quietly=T,warn.conflicts=FALSE)
require(RSQLite,quietly=T,warn.conflicts=FALSE)
require(foreign,quietly=T,warn.conflicts=FALSE)
suppressPackageStartupMessages(require(XLConnect,quietly=T,warn.conflicts=FALSE))

opts_chunk$set(fig.path='graphiques/beamer-',fig.align='center',fig.show='hold',size='footnotesize',
               fig.height=7,fig.width=7,out.width="\\textwidth",resize.height="0.8\\textheight",
               tidy=FALSE,prompt=TRUE
               )

options(width=45)


## ------------------------------------------------------------------------
c(2,3,4,6,7)

## ------------------------------------------------------------------------
numeric(4)
logical(4)

## ------------------------------------------------------------------------
is.integer(2L)
is.character(2.3)
as.character(2)

## ------------------------------------------------------------------------
matrix( 0, ncol = 2, nrow = 2)

## ------------------------------------------------------------------------
matrix( 0, ncol = 2, nrow = 2)

## ------------------------------------------------------------------------
head(data.frame(lettre=LETTERS,numero=1:26))

## ------------------------------------------------------------------------
a=list(1, LETTERS, matrix(0,2,2))
str(a)

## ------------------------------------------------------------------------
array(1:4,c(2,2,2))

## ------------------------------------------------------------------------
ts(date())

## ------------------------------------------------------------------------
str(as.list(iris))
str(as.matrix(iris[,1:4]))

## ------------------------------------------------------------------------
LETTERS[1:10]    
c(1,2,3,4)[1:2]
c(1,2,3,4)[-4]
c(1,2,3,4)[-4] * 2

## ------------------------------------------------------------------------
LETTERS[c(1,2,3,4)]
LETTERS[c(2,4)]
LETTERS[c(2,4,2)]

## ------------------------------------------------------------------------
LETTERS[-c(1,2,3,4)]
LETTERS[-c(2,4)]
LETTERS[-c(2,4,2)]

## ------------------------------------------------------------------------
L <- LETTERS[1:6]
L
L[c(T,F,T,F,T,T)]
L[c(T,F)] # recyclage

## ------------------------------------------------------------------------
(a <- 1:4)
(names(a) <- LETTERS[1:4])
a[c("A","D","A","C")]

## ------------------------------------------------------------------------
str(iris[c(1,3,4),]) # à gauche -> lignes
str(iris[,c(2,4,5)]) # à doirte -> colonnes
str(iris[c(2,4,5),c(2,4,5)]) # les deux

## ------------------------------------------------------------------------
a <- list(1, LETTERS, matrix(0,2,2))
a[c(T,F,T)]
a[[1]]

## ------------------------------------------------------------------------
a <- list(z=1, R=LETTERS, matrix(0,2,2))
a$R

## ------------------------------------------------------------------------
head(iris$Species)

