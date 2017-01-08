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
               tidy=FALSE,prompt=TRUE,eval=FALSE
               )

options(width=45)

correction <- TRUE



## ----import,echo=correction----------------------------------------------
gale <- read.csv2("data/maladies/Openhealth_Gale_Regions.csv",stringsAsFactors = F)
poux <- read.csv2("data/maladies/Openhealth_poux_Regions.csv",stringsAsFactors = F)
grippe <- read.csv2("data/maladies/Openhealth_S-Grippal_Regions.csv",stringsAsFactors = F)


## ----Renommage,echo=correction-------------------------------------------
gale$gale_2014_2015 <- gale$Sais_2014_2015
poux$poux_2014_2015 <- poux$Sais_2014_2015
grippe$grippe_2014_2015 <- grippe$Sais_2014_2015

## ----fusion,echo=correction----------------------------------------------
fusion <- merge(gale[,c("PERIODE","gale_2014_2015")],poux[,c("PERIODE","poux_2014_2015")],all=T)
dim(gale);dim(poux);dim(fusion)

## ----fusion2,echo=correction---------------------------------------------
fusion <- merge(fusion,grippe[,c("PERIODE","grippe_2014_2015")],all=T)
dim(fusion);dim(grippe);dim(fusion)

## ----nettoyage,echo=correction-------------------------------------------
fusion <- fusion[!is.na(fusion$gale_2014_2015),]

fusion$date <- dmy(fusion$PERIODE)

## ----plotting,echo=correction--------------------------------------------
ylim <- range( c(fusion$gale_2014_2015,fusion$grippe_2014_2015,fusion$poux_2014_2015) )

fusion <- fusion[order(fusion$date),]

plot(fusion$date, fusion$gale_2014_2015, col = "black", type="l", ylim=ylim)
lines(fusion$date, fusion$grippe_2014_2015, col = "red")
lines(fusion$date, fusion$poux_2014_2015, col = "blue")

## ----echo=correction-----------------------------------------------------
grippe <- grippe[!is.na(grippe$Sais_2014_2015),]
grippe$date <- substr(grippe$PERIODE,1,5)

vars <- c("Sais_2014_2015","Sais_2013_2014","Sais_2012_2013","Sais_2011_2012", "Sais_2010_2011")

ylim <- c()
for (var in vars)
  ylim <- range(c(ylim,grippe[[var]]),na.rm=T)

couleurs <- rev(brewer.pal(length(vars),"YlOrBr"))

plot(1:nrow(grippe),rep(0,nrow(grippe)),type="n",ylab="indice",xlab="date",main="Grippe",ylim=ylim)

for (var in 1:length(vars))
  lines(grippe[[vars[var]]],col=couleurs[[var]])

legend("topright",vars,pch=20,col=couleurs)

## ----moyennes_etc,echo=correction----------------------------------------
grippe2 <- grippe

grippe2 <- grippe[,grep("Sais_|date",colnames(grippe2))]
colnames(grippe2)

grippem <- melt(grippe2,id.vars=c("date"))

colnames(grippem)

grippem %>% group_by(variable) %>%
  summarize(
      mean=mean(value,na.rm=T),
      sd=sd(value,na.rm=T),
      max=max(value,na.rm=T)
  )


