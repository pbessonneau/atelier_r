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

suppressPackageStartupMessages(require(plyr,quietly=T,warn.conflicts=FALSE))
suppressPackageStartupMessages(require(dplyr,quietly=T,warn.conflicts=FALSE))
suppressPackageStartupMessages(require(ggplot2,quietly=T,warn.conflicts=FALSE))
suppressPackageStartupMessages(require(jsonlite,quietly=T,warn.conflicts=FALSE))
suppressPackageStartupMessages(require(RColorBrewer,quietly=T,warn.conflicts=FALSE))

suppressPackageStartupMessages(require(XLConnect,quietly=T,warn.conflicts=FALSE))
suppressPackageStartupMessages(require(lubridate,quietly=T,warn.conflicts=FALSE))

opts_chunk$set(fig.path='graphiques/beamer-',fig.align='center',fig.show='hold',size='footnotesize',
               fig.height=7,fig.width=7,out.width="\\textwidth",resize.height="0.6\\textheight",
               tidy=FALSE,prompt=TRUE,eval=FALSE
               )

options(width=45)

correction <- TRUE



## ----Q1,echo=correction--------------------------------------------------
require(readxl)
ophtalmo <- read_excel("data/delai_rdv/Delai_rdv_ophtalmos_2012.xlsx")
ophtalmo$sp�cialit� <- "ophtalmo"

gynecos <- read_excel("data/delai_rdv/Delai_rdv_gynecos_2012.xlsx")
gynecos$sp�cialit� <- "gynecos"

medecins <- rbind(ophtalmo,gynecos)


## ----echo=correction-----------------------------------------------------
tapply(medecins$"D�lai rendez-vous",medecins$"sp�cialit�",mean)


## ----echo=correction-----------------------------------------------------
plot(medecins$Tarif, medecins$`D�lai rendez-vous`, pch=20, col="blue",
     xlab="Tarifs (euros)",ylab="D�lai (jours)", main="D�lai d'attente et tarifs")

## ----echo=correction-----------------------------------------------------
colnames(medecins)
medecins$D�lai <- medecins$`D�lai rendez-vous`
med <- ddply(medecins, .(Ville,sp�cialit�), summarise, 
             D�lai = mean(D�lai), Tarif = mean(Tarif))
med.old <- med

## ----echo=correction-----------------------------------------------------
med <- med[med$sp�cialit�=="ophtalmo",]
plot(0,0,xlim=range(med$D�lai),ylim=range(med$Tarif),
     type="n",xlab="D�lai (jours)", ylab="Tarif (euros)",
     main="Ophtalmo"
     )
abline(v=mean(med$D�lai)); abline(h=mean(med$Tarif))

text(med$D�lai,med$Tarif,med$Ville,cex=0.6)

## ----echo=correction-----------------------------------------------------
cor(med$D�lai,med$Tarif)

## ----echo=correction-----------------------------------------------------
med <- med.old
plot(0,0,xlim=range(c(med$D�lai)),ylim=range(med$Tarif),
     type="n",xlab="D�lai (jours)", ylab="Tarif (euros)",
     main="Gyn�co et ophtalmo"
     )
abline(v=mean(med$D�lai)); abline(h=mean(med$Tarif))

couleurs <- c(gynecos="blue",ophtalmo="lightblue")

text(med$D�lai,med$Tarif,med$Ville,col=couleurs[med$sp�cialit�],cex=0.6)

## ----echo=correction-----------------------------------------------------
cor(med$D�lai,med$Tarif)

