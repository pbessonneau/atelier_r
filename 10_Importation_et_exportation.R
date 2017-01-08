## ----defaults,results='hide',echo=FALSE----------------------------------
require(MASS,quietly=T,warn.conflicts=FALSE)
require(xtable,quietly=T,warn.conflicts=FALSE)
require(stringr,quietly=T,warn.conflicts=FALSE)
require(RSQLite,quietly=T,warn.conflicts=FALSE)
require(foreign,quietly=T,warn.conflicts=FALSE)
suppressPackageStartupMessages(require(XLConnect,quietly=T,warn.conflicts=FALSE))

opts_chunk$set(fig.path='graphiques/beamer-',fig.align='center',fig.show='hold',size='footnotesize',
               fig.height=7,fig.width=7,out.width="\\textwidth",resize.height="0.8\\textheight",
               tidy=FALSE,prompt=TRUE
               )

options(width=45)


## ----setwd1,eval=FALSE---------------------------------------------------
## setwd("~/Documents/R/FormationR")

## ----getwd---------------------------------------------------------------
getwd()

## ----dirshort,echo=FALSE-------------------------------------------------
dir <- function(pattern,nblignes=16,...) {
  base::dir(pattern="tex",...)[1:nblignes]
}

## ----dir1----------------------------------------------------------------
dir(pattern="tex")

## ----dir2----------------------------------------------------------------
dir(pattern="tex",all=T)

## ----saveimage,eval=FALSE------------------------------------------------
## save.image()

## ----Quit,eval=FALSE-----------------------------------------------------
## q("no")

## ----SaveIris------------------------------------------------------------
save(iris,file="data/iris.RData")
save(iris,mtcars,file="data/misc.RData")

## ----LoadIris------------------------------------------------------------
load("data/iris.RData")

## ----LoadIris2-----------------------------------------------------------
(load("data/iris.RData"))

## ----LoadIris3-----------------------------------------------------------
recharger <- load("data/iris.RData")
recharger

## ----CSVFr---------------------------------------------------------------
iris <- read.table("data/iris.csv",
header=T,sep=";",dec=",")

## ----irisfalse-----------------------------------------------------------
iris <- read.csv2( "data/iris.csv", nrow = 1)
types <- rep( NA, ncol(iris) )
names(types) <- colnames(iris)
types["Species"] <- "character"
iris <- read.csv2( "data/iris.csv", colClasses=types )
(types <- sapply(as.list(iris),class))

## ----irisapply-----------------------------------------------------------
iris <- read.csv2( "data/iris.csv", nrow = 10 )
(types <- sapply(as.list(iris),class))
types["Species"] <- "character"
iris <- read.csv2( "data/iris.csv", colClasses=types )
(types <- sapply(as.list(iris),class))

## ----eval=FALSE----------------------------------------------------------
## require(readr)
## iris <- read_csv2("Support R/data/Iris.csv")

## ----eval=FALSE----------------------------------------------------------
## require(readr)
## iris <- read_csv2("Support R/data/Iris.csv")

## ----Write.CSV2----------------------------------------------------------
write.csv2(iris,"data/iris.csv")

## ----Write.CSV2b,echo=F--------------------------------------------------
write.csv2(iris,"data/iris.csv",row.names=F)

## ----readfwf-------------------------------------------------------------
a=read.fwf("data/fixed.txt",width=c(5, 7, 2, 4, 4))
colnames(a) <- c("model","make","mph","weight","price")

## ----readfwf2------------------------------------------------------------
read.fwf2 <- function ( file, width, ... ) {

   l = scan( file, what="character", nlines=1, sep="\n" )

   col.names <- substr(
        rep(l,length(width)) ,
	cumsum(c(1,width[-length(width)])),
	c(cumsum(width))
   )
   return(
      read.fwf( file, width=width, col.names=col.names, skip = 1, ... )
   )
}

## ----SPSS1---------------------------------------------------------------
iris.spss <- read.spss("data/iris.sav")

## ----SPSS2---------------------------------------------------------------
class(iris.spss)

## ----SPSS3---------------------------------------------------------------
str(iris.spss)

## ------------------------------------------------------------------------
str(as.data.frame(iris.spss))

## ----eval=FALSE----------------------------------------------------------
## require(haven)
## eleves <- read_sas("eleves.sas7bdat")

## ------------------------------------------------------------------------
require(jsonlite)
arbres <- fromJSON("data/arbresremarquablesparis2011.json",
                   simplifyDataFrame = T)


## ----connectSQLite,eval=TRUE---------------------------------------------
require(RSQLite)
driver <- dbDriver("SQLite")
con <- dbConnect( driver, dbname = "data/eslc_stu.sqlite")

## ----connectMySQL,eval=FALSE---------------------------------------------
## require(RMySQL)
## driver <- dbDriver("MySQL")
## conn <- dbConnect(
##    driver,
##    host="127.0.0.1",
##    username="user",
##    password = "passwd",
##    dbname = "eslc"
## )

## ----select1,eval=FALSE--------------------------------------------------
## requete <- dbSendQuery( con, "SELECT * from stu")
## stu <- fetch(requete, n = 5 )
## dbClearResult(requete)

## ----select2,EVAL=FALSE--------------------------------------------------
requete <- dbSendQuery(
   con,
   "SELECT * from stu WHERE country_id='FR'"
)
stu <- fetch(requete, n = 5 )
dbClearResult(requete)

## ----readtable,eval=FALSE------------------------------------------------
## stu <- dbReadTable( con, "NomDeLaTable" )
## stu <- dbReadTable( con, "NomDeLaTable", row.names=student_id )

## ----writetable,eval=FALSE-----------------------------------------------
## dbWriteTable( con, "stu2", stu )

## ----XLConnectRead,eval=FALSE--------------------------------------------
## wb = loadWorkbook("eslc.xlsx", create = T)
## data = readWorksheet(wb, sheet = "Eleves")

## ----XLConnectSave,eval=FALSE--------------------------------------------
## classeur = loadWorkbook("res_eslc.xlsx", create = T)
## createSheet(classeur, name = "eleves")
## writeWorksheet(classeur, eslc_eleves, sheet = "eleves")
## saveWorkbook(wb)

## ----XLConnectSaveTry,eval=FALSE-----------------------------------------
## classeur = loadWorkbook("res_eslc.xlsx", create = T)
## try({removeSheet(wb, sheet = "eleves")},silent=T)
## createSheet(classeur, name = "eleves")
## writeWorksheet(classeur, eslc_eleves, sheet = "eleves")
## saveWorkbook(wb)

## ----SetHeader,eval=FALSE------------------------------------------------
## csHeader = createCellStyle(wb, name = "header")
## setFillPattern(csHeader,
##                fill = XLC$FILL.SOLID_FOREGROUND)
## setFillForegroundColor(csHeader,
##                        color = XLC$COLOR.GREY_25_PERCENT)
## setCellStyle(wb, sheet = sheet, row = 1,
##               col = seq(length.out = ncol(curr)),
##               cellstyle = csHeader)

## ----eval=FALSE----------------------------------------------------------
## require(readxl)
## classeur = read_excel("res_eslc.xlsx")

