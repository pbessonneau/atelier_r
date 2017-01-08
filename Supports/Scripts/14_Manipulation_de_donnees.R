## ----defaults,results='hide',echo=FALSE----------------------------------
require(MASS,quietly=T,warn.conflicts=FALSE)
require(xtable,quietly=T,warn.conflicts=FALSE)
require(stringr,quietly=T,warn.conflicts=FALSE)
require(plyr,quietly=T,warn.conflicts=FALSE)
require(reshape2,quietly=T,warn.conflicts=FALSE)
#require(SweaveListingUtils,quietly=TRUE,warn.conflicts=FALSE)

opts_chunk$set(fig.path='graphiques/beamer-',fig.align='center',fig.show='hold',size='footnotesize',
               fig.height=7,fig.width=7,out.width="\\textwidth",resize.height="0.8\\textheight",
               tidy=FALSE,prompt=TRUE
               )
options(width=50)

xtfme <- read.csv("data/Xtfme_score.csv",strings=F)
xtfmc <- read.csv("data/Xtfmc_score.csv",strings=F)

eleves <- read.csv2("data/evaluation-eleves.csv")
eleves$id <- as.character( eleves$id )
scores <- read.csv2("data/evaluation-scores.csv")
scores$id <- as.character( scores$id )

## ----SingleCouleur-------------------------------------------------------
couleurs <- c( "red", "green", "blue" )
names(couleurs) <- levels(iris$Species)
iris$couleur <- couleurs[as.character(iris$Species)]
with( iris, table(couleur,Species) )

## ----SingleMoy-----------------------------------------------------------
longueur_par_spe <- tapply( iris$Sepal.Length, iris$Species, mean )
iris$Sepal.Length.Moy <- longueur_par_spe[as.character(iris$Species)]
with( iris, table(Sepal.Length.Moy,Species) )

## ----mergesimple---------------------------------------------------------
res <- merge( eleves, scores, by="id" )
dim(res)

## ----mergerow------------------------------------------------------------
rownames(eleves) <- eleves$id
rownames(scores) <- scores$id

res <- merge( eleves, scores, by="row.names" )
dim(res)

## ----MErgeDim------------------------------------------------------------
dim(eleves);dim(scores);dim(res)
colnames(res)

## ----naturelle-----------------------------------------------------------
conatif <- read.csv2( "data/evaluation-conatif.csv" )
conatif$id <- as.character( conatif$id )
dim(conatif)

ec <- merge( eleves, conatif, by="id" )
dim(ec)

## ----agauche-------------------------------------------------------------
ec <- merge( eleves, conatif, by="id", all.x = T )
dim(ec)

## ----suffixes------------------------------------------------------------
res <- merge( eleves, scores, by="row.names", 
              suffixes=c(".eleves",".scores" ) 
              )
dim(res)
colnames(res)

## ----manquants-----------------------------------------------------------
res <- merge( eleves, conatif, by="id", all.x=T )
(perdus <- res$id[ !(res$id %in% conatif$id) ])

## ----vec-----------------------------------------------------------------
x <- 1:4
x*4
# n'est autre que l'équivalent implicite de 
vreponse <- c()
for ( ii in 1:length(x) ) vreponse <- c( vreponse, x[ii]*4 )
vreponse

## ----FnMult--------------------------------------------------------------
"*"(3,4)

## ----FNSyntaxe,eval=FALSE------------------------------------------------
## mafonction <- function ( arg1, arg2, arg3=F, ... ) {
##   # code
## }

## ----Lambdas-------------------------------------------------------------
apply(iris[1:4],2,function(x){
  c(mean(x),sd(x))
})

## ----tapply1-------------------------------------------------------------
res <- with( xtfme, tapply( vali_f, num_etab, mean, na.rm=T ) )
res[1:5]

## ----tapply2-------------------------------------------------------------
with( xtfme, tapply( 
  vali_f, 
  list( strate=strate, sexe=sexe ), 
  mean, 
  na.rm=T
  ) 
)

## ----tapply3,eval=FALSE--------------------------------------------------
## with( xtfme, tapply(
##   vali_f,
##   list(strate=strate),
##   function(x,na.rm=T) {
##     c( mean(x,na.rm=na.rm), sd(x,na.rm=na.rm) )
##     }
##   )
## )

## ----tapply4,echo=FALSE--------------------------------------------------
with( xtfme, tapply( 
  vali_f, 
  list(strate=strate), 
  function(x,na.rm=T) { 
    c( mean(x,na.rm=na.rm), sd(x,na.rm=na.rm) ) 
    } 
  ) 
)

## ----count1--------------------------------------------------------------
with(xtfme, tapply( rep(1,length(strate)), strate, sum) )
with(xtfme, tapply( num_etab, strate, length) )

## ----poids---------------------------------------------------------------
with(xtfme, tapply( poids, strate, sum) )

## ----agg0----------------------------------------------------------------
with( xtfme, aggregate( 
  cbind(vali_f, vali_m), 
  list(strate=strate), 
  mean
  ) 
)

## ----agg0b---------------------------------------------------------------
with( xtfme, aggregate( 
  cbind(vali_f, vali_m), 
  list(strate=strate,sexe=sexe), 
  mean
  ) 
)

## ----agg2----------------------------------------------------------------
aggregate( 
  vali_m ~ strate + sexe, 
  data=xtfme, mean  
  )

## ----agg3----------------------------------------------------------------
data(iris)
aggregate( . ~ Species, data=iris, mean, na.rm=T  )

## ----plyr1---------------------------------------------------------------
ddply( xtfme, .(strate), summarize, 
       moy_f=mean(vali_f), sd_f=sd(vali_f),
       moy_m=mean(vali_m), sd_m=sd(vali_m)
       )

## ----plyr2---------------------------------------------------------------
head(
  ddply( xtfme, .(strate,sexe), summarize, 
       moy_f=mean(vali_f), sd_f=sd(vali_f),
       moy_m=mean(vali_m), sd_m=sd(vali_m)
       ), 4
)

## ----AggrFail1,eval=FALSE------------------------------------------------
## agg <- lapply( split(xtfme,xtfme$num_etab), function(x) {
##       data.frame(
##         uai=unique(x$num_etab), vali_f=mean(x$vali_f),
##         vali_m=mean(x$vali_m), poids=sum(x$poids),
##         prop_garcons=mean(ifelse(x$sexe==1,0,1))
##       )
##     }
##   )
## head( do.call( rbind, agg), 3 )

## ----AggrFail2,echo=FALSE------------------------------------------------
agg <- lapply( split(xtfme,xtfme$num_etab), function(x) { 
      data.frame( 
        uai=unique(x$num_etab), vali_f=mean(x$vali_f), 
        vali_m=mean(x$vali_m), poids=sum(x$poids),
        prop_garcons=mean(ifelse(x$sexe==1,0,1))
      )
    }  
  )
head( do.call( rbind, agg), 3 )

## ----AggrFail3,echo=FALSE------------------------------------------------
agg <- lapply( split(xtfme,xtfme$num_etab), function(x) { 
      data.frame( 
        uai=unique(x$num_etab), vali_f=mean(x$vali_f), 
        vali_m=mean(x$vali_m), poids=sum(x$poids),
        prop_garcons=mean(ifelse(x$sexe==1,0,1))
      )
    }  
  )
head( do.call( rbind, agg), 3 )

## ----Perso_lm,eval=FALSE-------------------------------------------------
## elev <- merge(scores,eleves,by="id")
## elev$sexe <- as.character(elev$sexe)
## elev <- elev[elev$sexe!="M",]
## 
## coef <- function(score,age3e,n) { coef(lm( score ~ age3e ))[n] }
## 
## res <- ddply(
##   elev, .( , secteur ), summarize,
##   coef1_age3e = coef1(score,age3e,1),
##   coef2_age3e = coef2(score,age3e,2)
## )
## 

## ----t-------------------------------------------------------------------
(a = matrix( 1:16, nrow=4, ncol=4 ))
t(a)  

## ----air1----------------------------------------------------------------
names(airquality) <- tolower(names(airquality))
head(airquality)

## ----air2----------------------------------------------------------------
head( 
  melt( airquality, 
        id=c("month", "day"), 
        measure.vars=c("ozone"),
        na.rm=TRUE
        ) 
  )

## ----air3----------------------------------------------------------------
head( 
  z <- melt( airquality, 
        id=c("month", "day"), 
        measure.vars=c("wind","ozone"),
        na.rm=TRUE
        ), 3
  )
table(z$variable)

## ----air4----------------------------------------------------------------
head( 
  dcast( z, month + day ~ variable )
  )

## ----air5----------------------------------------------------------------
head( 
  dcast( z, month ~ variable, mean, na.rm=T )
  )

## ----dplyr1,eval=FALSE---------------------------------------------------
## a1 <- group_by(flights, year, month, day)
## a2 <- select(a1, arr_delay, dep_delay)
## a3 <- summarise(a2,
##   arr = mean(arr_delay, na.rm = TRUE),
##   dep = mean(dep_delay, na.rm = TRUE))
## a4 <- filter(a3, arr > 30 | dep > 30)

## ----dplyr2,eval=FALSE---------------------------------------------------
## filter(
##   summarise(
##     select(
##       group_by(flights, year, month, day),
##       arr_delay, dep_delay
##     ),
##     arr = mean(arr_delay, na.rm = TRUE),
##     dep = mean(dep_delay, na.rm = TRUE)
##   ),
##   arr > 30 | dep > 30
## )

## ----dplyr3,eval=FALSE---------------------------------------------------
## flights %>%
##   group_by(year, month, day) %>%
##   select(arr_delay, dep_delay) %>%
##   summarise(
##     arr = mean(arr_delay, na.rm = TRUE),
##     dep = mean(dep_delay, na.rm = TRUE)
##   ) %>%
##   filter(arr > 30 | dep > 30)

## ----AggrFail4-----------------------------------------------------------
agg2 <- xtfme %>% group_by(num_etab) %>% 
  summarize(vali_f=mean(vali_f),
        vali_m=mean(vali_m), poids=sum(poids),
        prop_garcons=mean(ifelse(sexe==1,0,1))
  )               
head( agg2 )

