## ----echo=F--------------------------------------------------------------
require(FactoMineR)
options(width=50)
#opts_chunk$set(height=3,fig.width=3,size="small")
opts_chunk$set(fig.path='graphiques/beamer-',fig.align='center',fig.show='hold',size='footnotesize',fig.height=3.3,fig.width=3.3,out.width="\\textwidth")

## ------------------------------------------------------------------------
temp <- read.csv2("data/temp.csv")
colnames(temp)

## ------------------------------------------------------------------------
numerics <- sapply(temp,is.numeric)
for (ii in which(numerics))
  temp[[ii]] <- scale(temp[[ii]])

## ------------------------------------------------------------------------
hcpc <- HCPC(temp[,1:12],nb.clust = 3)

