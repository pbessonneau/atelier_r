## ----defaults,results='hide',echo=FALSE----------------------------------
require(MASS,quietly=T,warn.conflicts=FALSE)
require(xtable,quietly=T,warn.conflicts=FALSE)
require(stringr,quietly=T,warn.conflicts=FALSE)
require(RSQLite,quietly=T,warn.conflicts=FALSE)
require(foreign,quietly=T,warn.conflicts=FALSE)
require(lubridate,quietly=T,warn.conflicts=FALSE)
require(reshape2,quietly=T,warn.conflicts=FALSE)
require(plyr,quietly=T,warn.conflicts=FALSE)
require(dplyr,quietly=T,warn.conflicts=FALSE)
require(knitr,quietly=T,warn.conflicts=FALSE)

# suppressPackageStartupMessages(require(sp,quietly=T,warn.conflicts=FALSE))
# suppressPackageStartupMessages(require(maptools,quietly=T,warn.conflicts=FALSE))
# suppressPackageStartupMessages(require(rgdal,quietly=T,warn.conflicts=FALSE))
# suppressPackageStartupMessages(require(maps,quietly=T,warn.conflicts=FALSE))
suppressPackageStartupMessages(require(dplyr,quietly=T,warn.conflicts=FALSE))
suppressPackageStartupMessages(require(ggplot2,quietly=T,warn.conflicts=FALSE))
suppressPackageStartupMessages(require(jsonlite,quietly=T,warn.conflicts=FALSE))
suppressPackageStartupMessages(require(RColorBrewer,quietly=T,warn.conflicts=FALSE))

suppressPackageStartupMessages(require(XLConnect,quietly=T,warn.conflicts=FALSE))

opts_chunk$set(fig.path='graphiques/beamer-',fig.align='center',fig.show='hold',size='footnotesize',
               fig.height=7,fig.width=7,out.width="\\textwidth",resize.height="0.6\\textheight",
               tidy=FALSE,prompt=TRUE
               )

options(width=45)





## ----Q1------------------------------------------------------------------
require(readxl)
ophtalmo <- read_excel("data/delai_rdv/Delai_rdv_ophtalmos_2012.xlsx")
ophtalmo$spécialité <- "ophtalmo"

gynecos <- read_excel("data/delai_rdv/Delai_rdv_gynecos_2012.xlsx")
gynecos$spécialité <- "gynecos"

medecins <- rbind(ophtalmo,gynecos)


## ------------------------------------------------------------------------
tapply(medecins$"Délai rendez-vous",medecins$"spécialité",mean)


## ------------------------------------------------------------------------
plot(medecins$Tarif, medecins$`Délai rendez-vous`, pch=20, col="blue",
     xlab="Tarifs (euros)",ylab="Délai (jours)", main="Délai d'attente et tarifs")

## ------------------------------------------------------------------------
colnames(medecins)
medecins$Délai <- medecins$`Délai rendez-vous`
med <- ddply(medecins,.(Ville,spécialité),summarize, 
             Délai = mean(Délai), Tarif = mean(Tarif))

## ------------------------------------------------------------------------
plot(0,0,xlim=range(med$Délai),ylim=range(med$Tarif),
     type="n",xlab="Délai (jours)", ylab="Tarif (euros)"
     )
abline(v=mean(med$Délai)); abline(h=mean(med$Tarif))

text(med$Délai,med$Tarif,med$Ville,cex=0.6)

## ------------------------------------------------------------------------

med.old <- med
med <- med[med$spécialité=="gynecos",]
plot(0,0,xlim=range(med$Délai),ylim=range(med$Tarif),
     type="n",xlab="Délai (jours)", ylab="Tarif (euros)",
     main="Gynéco"
     )
abline(v=mean(med$Délai)); abline(h=mean(med$Tarif))

text(med$Délai,med$Tarif,med$Ville,cex=0.6)

## ------------------------------------------------------------------------

med <- med.old
med <- med[med$spécialité=="ophtalmo",]
plot(0,0,xlim=range(med$Délai),ylim=range(med$Tarif),
     type="n",xlab="Délai (jours)", ylab="Tarif (euros)",
     main="Gynéco"
     )
abline(v=mean(med$Délai)); abline(h=mean(med$Tarif))

text(med$Délai,med$Tarif,med$Ville,cex=0.6)

