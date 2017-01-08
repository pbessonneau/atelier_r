## ----echo=F--------------------------------------------------------------
options(width=50)
#opts_chunk$set(height=3,fig.width=3,size="small")
opts_chunk$set(fig.path='graphiques/beamer-',fig.align='center',fig.show='hold',size='footnotesize',fig.height=3.3,fig.width=3.3,out.width="\\textwidth")

## ----Base----------------------------------------------------------------
is.function( { function ( x ) {
 x^2
} } )

## ----BaseReturn----------------------------------------------------------
my.square <- function ( x ) {
 return(x^2)
}
my.square(3)

## ----BaseInvisible-------------------------------------------------------
my.square <- function ( x ) {
 invisible(x^2)
}
my.square(3)
(my.square(3))

## ----BaseEnv1------------------------------------------------------------
z <- 2
 my.square <- function ( x ) {
 return(z*x^2)
}
my.square(3)

## ----BaseEnv2------------------------------------------------------------
z <- 2
 my.square <- function ( x ) {
 z <- 4
 return(z*x^2)
}
my.square(3)
z

## ----ttest1--------------------------------------------------------------
t.test(rnorm(1000),y=rnorm(1000,2))

## ----ttest2--------------------------------------------------------------
t.test(rnorm(1000),rnorm(1000,2))

## ----ttest3--------------------------------------------------------------
t.test(rnorm(1000),rnorm(1000,2),var.equal=TRUE)

## ----Barplot1,comment=NA-------------------------------------------------
my.barplot <- function( x, horiz=T, ... ) {
  barplot( x, horiz=horiz, ... )
}
#my.barplot( c(5,4,3,2,1), col="red" )

## ----Barplot2,echo=F,out.width="\\textheight",fig.width=3,fig.height=3----
my.barplot( c(5,4,3,2,1), col="red" )

## ----Pere----------------------------------------------------------------
i <- 1
a <- function (x) { i <- 2 }
i
i <- 1
a <- function (x) { i <<- 2 }
a(7);i;

## ----if_test1,eval=FALSE-------------------------------------------------
## if ( valeur ) {
##        ... code R...
## }

## ----if_test2,eval=FALSE-------------------------------------------------
## if ( valeur ) {
##  ... code R...
## } else {
## ... code R...
## }

## ----IfElse--------------------------------------------------------------
ifelse( rnorm(10) > 0, 1, -1 )

## ----Stat5---------------------------------------------------------------
(r <- apply(iris[,1:4],2,quantile))

## ----Iris1---------------------------------------------------------------
sapply( iris, is.numeric )

## ----Iris----------------------------------------------------------------
str(as.list(iris))

## ----Replicate1,cache=TRUE-----------------------------------------------
set.seed(42)
system.time(
res1 <- replicate( 10000, function() { return(mean(rnorm(1000))) } )
)
system.time({
res2 <- numeric(10000)
for ( ii in 1:10000 ) { res2[ii] <- mean(rnorm(1000)) }
})

## ----Replicate1a,cache=TRUE----------------------------------------------
system.time({
res2 <- c()
for ( ii in 1:10000 ) { res2 <- c( res2, mean(rnorm(1000)) ) }
})

## ----patientCharg,echo=FALSE---------------------------------------------
patient <- read.csv2("data/patient.csv")

## ----Boot1,eval=FALSE----------------------------------------------------
## n <- 1000
## set.seed(42)
## b <- replicate( n, mean( sample( patient$totalechelle,
##                                  length(patient$totalechelle),
##                                  replace = T ), na.rm=T ) )
## mean((b-mean(b))^2)

## ----Boucle1-------------------------------------------------------------
for ( ii in 1:4 ) { print(ii) }

## ----Boucle2-------------------------------------------------------------
for ( ww in LETTERS[1:4] ) { print(ww) }

## ----Boucle3-------------------------------------------------------------
a <- numeric(4)
for ( ii in 1:4 ) { a[ii] <- mean(rnorm(1000)) }
a

## ----Boucle4-------------------------------------------------------------
a <- vapply(1:4,function(x) mean(rnorm(x)),numeric(1))
a

## ----Boucle5-------------------------------------------------------------
vars <- colnames(iris)[sapply(iris,is.numeric)]
for ( ii in vars ) { iris[ii] <- scale(iris[ii]) }

## ----Boucle6-------------------------------------------------------------
vars <- colnames(iris)[sapply(iris,is.numeric)]
iris[,vars] <- apply(iris[,vars],2,scale)

## ----Boucle7-------------------------------------------------------------
for ( ww in c( function(x) {x^1}, function(x) {x^2}, function(x) {x^3} ) ) { print(ww(2)) }

## ----Boucle8-------------------------------------------------------------
power <- function(n,x) {x^n}
sapply(as.list(1:3),power,x=2)

## ----PatientSplit--------------------------------------------------------
str(split(iris,factor(iris$Species)))

## ----ResAggr0------------------------------------------------------------
stats <- function (x) { c( 
  quantile( x$Sepal.Length,probs=c(0,0.25,0.5,0.75,1)), 
  mean(x$Sepal.Length), 
  sd(x$Sepal.Length) ) 
}
res <- lapply( split(iris,iris$Species), stats )
str(res)

## ----ResAggr1------------------------------------------------------------
do.call( rbind, res )

## ----ResAggrDF,eval=FALSE------------------------------------------------
## do.call( data.frame, res )

## ----Jack1,cache=TRUE----------------------------------------------------
mm <- mean(iris[,"Sepal.Length"])
res <- sapply( as.list(1:nrow(iris)), 
               function (x) { 
                 (mean(iris[-x,"Sepal.Length"])-mm)^2
} )
vv <- sqrt(sum(as.numeric(res))/(nrow(iris)*(nrow(iris)-1)))
paste( "[", qt(0.025,nrow(iris)-1)*vv+mm, 
       ":", qt(0.975,nrow(iris)-1)*vv+mm, "]" )

## ----Jack2,cache=TRUE,eval=FALSE-----------------------------------------
## mm <- mean(iris[,"Sepal.Length"])
## res <- mclapply( as.list(1:nrow(iris)), function (x)
##   (mean(iris[-x,"Sepal.Length"])-mm)^2,
##   mc.cores=4
## )
## 
## vv <- sqrt(sum(as.numeric(res))/(nrow(iris)*(nrow(iris)-1)))
## 
## paste( "[", qt(0.025,nrow(iris))*vv+mm, ":",
##        qt(0.975,nrow(iris))*vv+mm, "]" )

