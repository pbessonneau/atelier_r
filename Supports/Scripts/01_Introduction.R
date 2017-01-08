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
               fig.height=7,fig.width=7,out.width="\\textwidth",resize.height="0.8\\textheight",
               tidy=FALSE,prompt=TRUE
               )

options(width=45)


## ------------------------------------------------------------------------
a <- 3 + 4
a

## ------------------------------------------------------------------------
a <- rnorm(10)
a
class(a)

## ------------------------------------------------------------------------
a <- 5
a
a <- "Hello World !"
a

## ------------------------------------------------------------------------
a <- 5 + TRUE
a

## ------------------------------------------------------------------------
a
print(a)

## ------------------------------------------------------------------------
c(1,2,3)
c("A","B","C","D")
c(T,F,T,T,F,T)
c(T,F,T,T,F,T) + 0

## ------------------------------------------------------------------------
c(1,2,3)
c("A","B","C","D")
c(T,F,T,T,F,T)

## ------------------------------------------------------------------------
2 + 3 * 2 / 4
T | T

## ------------------------------------------------------------------------
c(1,2,3) * 2
T & c(T,F,T)

## ------------------------------------------------------------------------
sqrt(4)
min(c(2,3,4,20))

## ------------------------------------------------------------------------
rep(2,5)
paste("A","B")
1:10

## ------------------------------------------------------------------------
A=5
a=4
A
a

## ------------------------------------------------------------------------
"A"=="a"
"A"=="A"

## ------------------------------------------------------------------------
a <- 3 # Assignation
a = 3 # Assignation (déconseillé)
a == 3 # Comparaison
a != 3 # Différent de
a + 4  # somme
a | TRUE # Ou

## ------------------------------------------------------------------------
a <- 3+1
(a <- 3) + 1

