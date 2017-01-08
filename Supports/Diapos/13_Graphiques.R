## ----defaults,results='hide',echo=FALSE----------------------------------
require(MASS,quietly=T,warn.conflicts=FALSE)
require(xtable,quietly=T,warn.conflicts=FALSE)
require(stringr,quietly=T,warn.conflicts=FALSE)
require(RSQLite,quietly=T,warn.conflicts=FALSE)
require(foreign,quietly=T,warn.conflicts=FALSE)
suppressPackageStartupMessages(require(XLConnect,quietly=T,warn.conflicts=FALSE))

opts_chunk$set(fig.path='graphiques/beamer-',fig.align='center',fig.show='hold',size='footnotesize',
               fig.height=7,fig.width=7,out.width="\\textwidth",resize.height="0.6\\textheight",
               tidy=FALSE,prompt=TRUE
               )

options(width=45)


## ------------------------------------------------------------------------
plot(rnorm(1000))

## ------------------------------------------------------------------------
a=rnorm(1000)
plot(a,a+rnorm(1000,0,0.4))

## ------------------------------------------------------------------------
plot(factor(sample(LETTERS[1:4],1000,replace=T)),
            rnorm(1000)
            )

## ----eval=FALSE----------------------------------------------------------
## a <- rnorm(1000)
## dt <- data.frame(
##   a=a,
##   b=a+rnorm(1000,0,0.4)
## )
## rl <- lm(b ~ a)
## plot(rl,ask=F)

## ----echo=FALSE----------------------------------------------------------
a <- rnorm(1000)
dt <- data.frame(
  a=a,
  b=a+rnorm(1000,0,0.4)
)
rl <- lm(b ~ a)
#plot(rl,ask=F)

## ------------------------------------------------------------------------
class(rl)

## ------------------------------------------------------------------------
methods(class=class(rl))

## ------------------------------------------------------------------------
par()$mar
par(mar=c(3.1,2.1,2.1,2.1))
plot(dt$b,dt$a)

## ----eval=FALSE----------------------------------------------------------
## par(mfrow=c(2,2))
## par(mar=c(3.1,2.1,2.1,2.1))
## plot(dt$b,dt$a,col="blue",pch=20)
## plot(dt$b,dt$a,col="green",pch=20)
## plot(dt$b,dt$a,col="yellow",pch=20)
## plot(dt$b,dt$a,col="red",pch=20)

## ----eval=TRUE,echo=FALSE------------------------------------------------
par(mfrow=c(2,2))
par(mar=c(3.1,2.1,2.1,2.1))
plot(dt$b,dt$a,col="blue",pch=20)
plot(dt$b,dt$a,col="green",pch=20)
plot(dt$b,dt$a,col="yellow",pch=20)
plot(dt$b,dt$a,col="red",pch=20)

## ----eval=TRUE,echo=FALSE------------------------------------------------
par(mfrow=c(2,2))
par(mar=c(3.1,2.1,2.1,2.1))
plot(dt$b,dt$a,col="blue",pch=20)
plot(dt$b,dt$a,col="green",pch=20)
plot(dt$b,dt$a,col="yellow",pch=20)
plot(dt$b,dt$a,col="red",pch=20)

## ----eval=FALSE----------------------------------------------------------
## plot(x,y,add=T)

## ------------------------------------------------------------------------
jpeg("graphiques/MonGraphique.jpeg")
par(mfrow=c(2,2))
par(mar=c(3.1,2.1,2.1,2.1))
plot(dt$b,dt$a,col="blue",pch=20)
plot(dt$b,dt$a,col="green",pch=20)
plot(dt$b,dt$a,col="yellow",pch=20)
plot(dt$b,dt$a,col="red",pch=20)
dev.off()

## ----eval=FALSE----------------------------------------------------------
## xmetro <- 9
## xdom <- 1
## mm <- matrix(
##     c(
##       rep( 7,xdom), rep( 1,xmetro),
##       rep( 7,xdom), rep( 1,xmetro),
##       rep( 7,xdom), rep( 1,xmetro),
##       rep( 2,xdom), rep( 1,xmetro),
##       rep( 3,xdom), rep( 1,xmetro),
##       rep( 4,xdom), rep( 1,xmetro),
##       rep( 0,xdom), rep( 1,xmetro),
##       rep( 0,xdom), rep( 1,xmetro),
##       rep( 0,xdom), rep( 1,xmetro),
##       rep( 0,xdom), rep(0,3), rep(5,1), rep(0,1), rep(6,1), rep(0,xmetro-6)
##     ),
##     ncol=10,
##     nrow=10,
##     byrow=T
## )
## mm

## ----echo=FALSE----------------------------------------------------------
xmetro <- 9
xdom <- 1
mm <- matrix(
    c(
      rep( 7,xdom), rep( 1,xmetro),
      rep( 7,xdom), rep( 1,xmetro),
      rep( 7,xdom), rep( 1,xmetro),
      rep( 2,xdom), rep( 1,xmetro),
      rep( 3,xdom), rep( 1,xmetro),
      rep( 4,xdom), rep( 1,xmetro),
      rep( 0,xdom), rep( 1,xmetro),
      rep( 0,xdom), rep( 1,xmetro),
      rep( 0,xdom), rep( 1,xmetro),
      rep( 0,xdom), rep(0,3), rep(5,1), rep(0,1), rep(6,1), rep(0,xmetro-6)
    ),
    ncol=10,
    nrow=10,
    byrow=T
)
mm

