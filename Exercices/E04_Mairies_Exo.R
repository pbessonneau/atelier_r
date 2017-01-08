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
               tidy=FALSE,prompt=TRUE
               )

options(width=45)


## ------------------------------------------------------------------------
mairies <- read.csv("data/ville_secu_informatique_centroide.csv"
                    , fileEncoding = "UTF8"
                    , stringsAsFactors = F
                    )

## ------------------------------------------------------------------------
summary(mairies)

## ------------------------------------------------------------------------
prop.table(table(mairies$Site))
prop.table(table(mairies$Site))*100

## ------------------------------------------------------------------------
prop.table(table(mairies$https))*100

## ------------------------------------------------------------------------
prop.table(table(mairies$Catégorie))*100

## ------------------------------------------------------------------------
prop.table(table(mairies$Catégorie))*100

## ------------------------------------------------------------------------
prop.table(table(mairies$Serveur))*100

## ------------------------------------------------------------------------
prop.table(table(mairies$Serveur,mairies$https))*100
prop.table(table(mairies$Serveur,mairies$https),1)*100

## ------------------------------------------------------------------------
prop.table(table(mairies$Serveur,mairies$Catégorie))*100
res <- prop.table(table(mairies$Serveur,mairies$Catégorie),1)*100
write.csv2(as.data.frame.matrix(res),file="data/resultats1.csv")

## ------------------------------------------------------------------------
(tmp <- tapply(mairies$Population,mairies$Serveur,mean))

## ------------------------------------------------------------------------
barplot(tmp,las=3)

## ------------------------------------------------------------------------
boxplot(mairies$Population ~ mairies$Serveur,las=3)

## ------------------------------------------------------------------------
boxplot(mairies$Population ~ mairies$Serveur,las=3,ylim=c(0,50000))

## ------------------------------------------------------------------------
mairies$dept <- substr(mairies$Code.Insee,1,2)

## ------------------------------------------------------------------------
prop.table(table(mairies$dept,mairies$Catégorie),1)*100
mairies$a.jour <- mairies$Catégorie == "À jour"
(res <- prop.table(table(mairies$dept,mairies$a.jour),1)*100)
write.csv2(as.data.frame.matrix(res),file="data/resultats2.csv")

