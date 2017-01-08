## ----echo=F--------------------------------------------------------------
require(FactoMineR)
options(width=50)
#opts_chunk$set(height=3,fig.width=3,size="small")
opts_chunk$set(fig.path='graphiques/beamer-',fig.align='center',fig.show='hold',size='footnotesize',fig.height=3.3,fig.width=3.3,out.width="\\textwidth")

## ------------------------------------------------------------------------
temp <- read.csv2("data/temp.csv")
colnames(temp)


## ------------------------------------------------------------------------
head(temp)

## ------------------------------------------------------------------------
rownames(temp) <- temp$Ville
temp <- temp[,-1]

## ------------------------------------------------------------------------
pca <- PCA(temp,quanti.sup = c(13,14))

## ------------------------------------------------------------------------
plot(pca,choix = "ind")

## ------------------------------------------------------------------------
cor(pca$ind$coord[,1:2],temp[,c("lati","long")])

