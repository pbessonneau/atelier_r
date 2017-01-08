## ----echo=F--------------------------------------------------------------
options(width=50)
#opts_chunk$set(height=3,fig.width=3,size="small")
opts_chunk$set(fig.path='graphiques/beamer-',fig.align='center',fig.show='hold',size='footnotesize')

## ----Write.CSV2a,echo=F--------------------------------------------------
write.csv2(iris,"iris.csv",row.names=F)

## ----cocode,eval=FALSE---------------------------------------------------
## x <- rnorm(1000)
## t.test(x,conf.level=0.8)
## t.test(conf=0.8,x=x)

## ----S3_1----------------------------------------------------------------
class(iris)

## ----S3_2a,eval=TRUE-----------------------------------------------------
methods(class="data.frame")

