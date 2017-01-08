## ----echo=F--------------------------------------------------------------
require(MASS,quietly=T,warn.conflicts=FALSE)
require(xtable,quietly=T,warn.conflicts=FALSE)
require(stringr,quietly=T,warn.conflicts=FALSE)
require(questionr,quietly=T,warn.conflicts=FALSE)
require(R2HTML,quietly=T,warn.conflicts=FALSE)
require(knitr)
opts_chunk$set(fig.path='graphiques/beamer-',fig.align='center',fig.show='hold',size='footnotesize',
               fig.height=7,fig.width=7,out.width="\\textwidth",resize.height="0.8\\textheight",
               tidy=FALSE,prompt=TRUE
               )
options(width=45)

cg <- read.csv("data/cg0309.csv",strings=F)


## ----Summary-------------------------------------------------------------
summary(iris)

## ----Stat1a--------------------------------------------------------------
mean(iris$Sepal.Length)
sd(iris$Sepal.Length)
quantile(iris$Sepal.Length)

## ----Stat1b--------------------------------------------------------------
r <- c(
  mean(iris$Sepal.Length),
  sd(iris$Sepal.Length),
  quantile(iris$Sepal.Length)
  )
names(r) <- c("Moy.","EC","Min","1erQ","Méd.","3emeQ","Max")
r

## ----Stat1c--------------------------------------------------------------
r <- rbind( r, c(
  mean(iris$Sepal.Length),
  sd(iris$Sepal.Length),
  quantile(iris$Sepal.Length)
  )
)
rownames(r) <- c( "Sepal.Length", "Sepal.Width" )
r
write.csv2(r,"data/Resultats.txt")

## ----Stat1z,eval=FALSE---------------------------------------------------
## write.csv2(r,"clipboard")

## ----clipcopy,eval=FALSE-------------------------------------------------
## clipcopy(r)

## ----NAs1----------------------------------------------------------------
min(c(3,NA,5))

## ----NAs2----------------------------------------------------------------
min(c(3,NA,5),na.rm=T)

## ----Plot,echo=F---------------------------------------------------------
plot(iris$Sepal.Length)

## ----Hist,echo=F---------------------------------------------------------
hist(iris$Sepal.Length)

## ----Box1,echo=F---------------------------------------------------------
boxplot(iris$Sepal.Length)

## ----Box2,echo=F---------------------------------------------------------
boxplot(iris[,1:4])

## ----Cor1----------------------------------------------------------------
cor(cg$score,cg$plaisir)

## ----Cor2----------------------------------------------------------------
cor(cg$score,cg$plaisir,use="pairwise.complete.obs")

## ----Cor3a---------------------------------------------------------------
cor(cg[,8:12],use="pairwise.complete.obs")

## ----Cor3b,echo=F--------------------------------------------------------
plot(iris[,1:4])

## ----CorT1a--------------------------------------------------------------
cor.test(cg$score,cg$plaisir,use="pairwise.complete.obs")

## ----CorT1b--------------------------------------------------------------
montest <- cor.test(cg$score,cg$plaisir,use="pairwise.complete.obs")

## ----CorT4---------------------------------------------------------------
str(montest)

## ----CorT5---------------------------------------------------------------
montest$estimate
montest$conf.int

## ----Patient1a-----------------------------------------------------------
patient <- read.csv2("data/patient.csv")
table(patient$sexe)

## ----Patient1b-----------------------------------------------------------
table(patient$sexe,patient$CIM2)

## ----Patient1c-----------------------------------------------------------
table(Sexe=patient$sexe,CIM2=patient$CIM2)

## ----Patient1d-----------------------------------------------------------
as.data.frame(table(Sexe=patient$sexe,CIM2=patient$CIM2))

## ----Patient1e-----------------------------------------------------------
tableau <- (table(Sexe=patient$sexe,CIM2=patient$CIM2))
class(tableau)
class(tableau) <- "matrix"
class(tableau)

## ----Patient1e2----------------------------------------------------------
tableau <- (table(Sexe=patient$sexe,CIM2=patient$CIM2))
as.data.frame.matrix(tableau)

## ----Patient1g-----------------------------------------------------------
addmargins(tableau,1)

## ----Patient1h-----------------------------------------------------------
addmargins(tableau,2)

## ----Patient1i-----------------------------------------------------------
addmargins(tableau,1:2)

## ----Patient1j-----------------------------------------------------------
prop.table(tableau,1)

## ----Patient1k-----------------------------------------------------------
prop.table(tableau,2)

## ----Patient1------------------------------------------------------------
addmargins(prop.table(tableau),1:2)

