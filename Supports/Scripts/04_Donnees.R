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
suppressPackageStartupMessages(require(jsonlite,quietly=T,warn.conflicts=FALSE))

suppressPackageStartupMessages(require(XLConnect,quietly=T,warn.conflicts=FALSE))

opts_chunk$set(fig.path='graphiques/beamer-',fig.align='center',fig.show='hold',size='footnotesize',
               fig.height=7,fig.width=7,out.width="\\textwidth",resize.height="0.6\\textheight",
               tidy=FALSE,prompt=TRUE
               )

options(width=45)


## ------------------------------------------------------------------------
data(iris)
class(iris)

## ------------------------------------------------------------------------
summary(iris)

## ------------------------------------------------------------------------
table(iris$Species)
prop.table(table(iris$Species))
prop.table(table(iris$Species))*100

## ------------------------------------------------------------------------
tapply(iris$Sepal.Length,iris$Species,mean)

## ------------------------------------------------------------------------
prenoms <- read.csv2("data/prenoms/liste_des_prenoms_2004_a_2012.csv",
                     stringsAsFactors = F,encoding = "UTF-8")
colnames(prenoms)

## ------------------------------------------------------------------------
prenoms2004 <- prenoms[prenoms$Annee==2004,]

## ------------------------------------------------------------------------
max(prenoms$Nombre)
prenoms2004$Prenoms[prenoms2004$Nombre == max(prenoms2004$Nombre)]

## ----eval=FALSE----------------------------------------------------------
## prenoms2004$Prenoms[prenoms2004$Nombre == min(prenoms2004$Nombre)]

## ----echo=FALSE----------------------------------------------------------
iconv(prenoms2004$Prenoms[prenoms2004$Nombre == min(prenoms2004$Nombre)],"ASCII//translit")

## ------------------------------------------------------------------------
min(prenoms2004$Nombre)

## ------------------------------------------------------------------------
prenoms2004$Nombre[prenoms2004$Prenoms=="Pascal"]

## ------------------------------------------------------------------------
tt <- table(prenoms$Prenoms)
range(tt)

## ------------------------------------------------------------------------
range(prenoms$Annee)
head(names(tt)[tt>12])

## ------------------------------------------------------------------------
pp <- names(tt)[tt>12]
prenoms_prb <- prenoms[prenoms$Prenoms %in% pp,] 
head(prenoms_prb[order(prenoms_prb$Prenoms),])

## ------------------------------------------------------------------------
head(table(prenoms_prb$Prenoms,prenoms_prb$Annee))

## ------------------------------------------------------------------------
prenoms_prb[prenoms_prb$Prenoms=="Andrea" & prenoms_prb$Annee == 2012,]

