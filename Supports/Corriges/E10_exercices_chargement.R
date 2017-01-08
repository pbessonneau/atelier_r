## ----intro,echo=F--------------------------------------------------------
require(MASS,quietly=T,warn.conflicts=FALSE)
require(xtable,quietly=T,warn.conflicts=FALSE)
require(stringr,quietly=T,warn.conflicts=FALSE)
require(questionr,quietly=T,warn.conflicts=FALSE)
require(plyr,quietly=T,warn.conflicts=FALSE)

opts_chunk$set(fig.path='Graphiques/',fig.align='center',fig.show='hold',size='footnotesize',
               fig.height=7,fig.width=7,out.width="\\textwidth",resize.height="0.8\\textheight",
               
# dé-commenter pour obtenir le document sans les solutions et les sorties               
              eval=FALSE,
      
              echo=TRUE,

               tidy=TRUE,prompt=TRUE

               )

options(width=45)

correction <- FALSE

## ----IrisDataLoad,echo=correction,eval=FALSE-----------------------------
## data(iris)

## ----IrisLoad1,echo=correction-------------------------------------------

# --- C'est le format par défaut pour un fichier Excel ("Français") -------

csv_iris <- read.table(
	"data/iris.csv",
	header=T,		# En-tête de colonne	
	sep=";",		# Séparateur de champs = ;
	dec=","			# Séparateur de décimal = ,
)
str(csv_iris)
# ou strictement équivalent
csv_iris <- read.csv2("data/Iris.csv")      
str(csv_iris)

## ----IrisLoad2,echo=correction-------------------------------------------

# --- Format "tabulation" -------------------------------------------------

# Si on regarde le format, le séparateur de champ est un \t (tabulation) et le séparateur de 
# décimal est ",". Il y a en première ligne des en-têtes de colonne...

table_iris <- read.table(
	"data/Iris.txt",
	header=T,		# En-tête de colonne	
	sep="\t",		# Séparateur de champs = ;
	dec=","			# Séparateur de décimal = ,
)
str(table_iris)
# ou strictement équivalent
table_iris <- read.delim("data/Iris.txt",stringsAsFactors = F)
str(table_iris)

## ----patientLoad1,echo=correction----------------------------------------

# --- Format question ouverte ---------------------------------------------

# Si on regarde le format, le séparateur de champ est un "|" et le séparateur de 
# décimal est ".". Il y a en première ligne des en-têtes de colonne... C'est un format qu'on peut
# rencontrer quand on travaille avec bases SQL où des champs sont susceptibles de contenir des ","
# ou des ";". C'est par exemple le cas pour des sondages avec des questions ouvertes ou des 
# libelés de formation.

dat_patient <- read.table(
	"data/patient.dat",
	header=T,		# En-tête de colonne	
	sep="|",		# Séparateur de champs = ;
	dec="."			# Séparateur de décimal = ,
)
str(dat_patient)

## ----patientLoad2,echo=correction----------------------------------------

# --- C'est le format de sortie de SAS par défaut pour un fichier CSV -----
csv_patient <- read.table(
	"data/patient.csv",
	header=T,		# En-tête de colonne	
	sep=",",		# Séparateur de champs = ;
	dec="."			# Séparateur de décimal = ,
)
# ou équivalent
csv_patient <- read.csv("data/patient.csv",stringsAsFactors = F)
str(csv_patient)

## ----patientLoad3,echo=correction----------------------------------------

# --- Modification des types de colonne -----------------------------------

# on charge quelques quelques lignes
csv_patient <- read.csv("data/patient.csv",stringsAsFactors = F,nrows=20)
dim(csv_patient)
str(csv_patient)

# on récupère le type des variables et on modifie pour les trois demandées
types <- sapply(csv_patient,class)
types[c("ACP","peridurale","periACP")] <- "character"

# on charge le fichier avec les bons types de données
csv_patient <- read.csv("data/patient.csv",stringsAsFactors = F,colClasses=types[-1])
str(csv_patient)

## ----ExportExcel,eval=FALSE,echo=correction------------------------------
## write.csv2(mtcars,"data/mtcars-excel.csv")

## ----ExportSAS,eval=FALSE,echo=correction--------------------------------
## write.csv(mtcars,"data/mtcars-sas.csv",row.names = F)

## ----PatientSPSS,echo=correction-----------------------------------------

# Le fichier iris.sav est un fichier SPSS, il nécessite le package foreign...
require(foreign)
iris <- read.spss("data/iris.sav")

# On obtient pas une data.frame mais une liste. Parce que la fonction tente de charger les attributs
# et formats de SPSS. 
class(iris)

str(iris)

# On voit ici qu'il n'y a pas de structures très complexes. Ce sont juste des vecteurs. Aussi R va
# pouvoir tout seul convertir la list en data.frame...
iris <- as.data.frame(iris)
str(iris)

# Seul problème c'est qu'en réduisant en data.frame, on perd les libellés de SPSS notamment


## ----ExcelTeacher1,eval=FALSE,echo=correction----------------------------
## 
## # Ouverture de la connexion
## wb1 <- loadWorkbook(
##   "data/Teacher.xlsx",
##   create = FALSE
## )
## 
## # Chargement
## teachers <- readWorksheet( wb1, sheet = "Teacher")
## 

## ----ExcelTeacher2,eval=FALSE,echo=correction----------------------------
## 
## # Ouverture de la connexion
## wb2 <- loadWorkbook(
##   "data/Teacher.xls",
##   create = TRUE
## )
## 
## # Préparation de la feuille
## createSheet(wb, name = "Teacher")
## 
## # Ecriture dans la feuille
## writeWorksheet( wb2, teachers, sheet = "Teacher")
## 
## saveWorkbook(wb2,"data/Teacher.xls")
## 

## ----ExcelPatient,echo=correction----------------------------------------

# Ouverture de la connexion
wbPatient <- loadWorkbook(          
  "data/patient.xlsx", 
  create = FALSE
)

patient <- readWorksheet( wbPatient, sheet = "Patients", startRow = 4, endCol = 17 )


## ----ChargementFichierFixe,echo=correction-------------------------------

# --- Lecture de fichiers à positions fixes -------------------------------

# C'est le royaume de read.fwf

# On va repartir de notre bon vieux fichier iris...
# Examiner le fichier Iris...
# En fait les longueurs de colonnes sont c( 5, 5, 5, 5, 15)
# Mais n'oubliez pas que la première colonne qui contient les titres est lu différement, avec un 
# séparateur... Ici c'est un ";"
fixed_iris <- read.fwf(
	"data/Iris-fixed.txt",
	width = c( 5, 5, 5, 5, 15),
	header=T,
	sep=";",
	strip.white=TRUE
)


## ----SQL,eval=FALSE,echo=TRUE--------------------------------------------
## # 1) country_id = \"FR\"
## 
## # 2) targetLanguage_id=\"EN\"

## ----SQLite,echo=correction----------------------------------------------
# Base de données #################################################################################

# Script de création de la base
# db <- dbConnect(SQLite(), dbname = "stu.sqlite")
# (dbWriteTable( db, "stu", stu))
# dbDisconnect(db)

require(RSQLite)

# Ouverture de la connexion
db <- dbConnect(SQLite(), dbname = "stu.sqlite")

# Notre requete, que la France
requete <- "SELECT * FROM stu WHERE country_id = \"FR\";"	
res <- dbSendQuery( db, requete)
fr <- fetch( res, n = -1 )
dbClearResult(res)					# Vider le tampon

# Changement de type de variables à cause des fonctionnalités 
# du pilote SQLite (factors->character)
str(fr)		

# Vérification qu'on a bien pris la France
table(fr$country_id)

# Pour ceux qui ont passé l'anglais... Attention on utilise la MEME connexion <db> qui a été déjà créée !
requete <- "SELECT * FROM stu WHERE country_id = \"FR\" and targetLanguage_id=\"EN\"";
res <- dbSendQuery( db, requete)
fren <- fetch( res, n = -1 )
dbClearResult(res)					# Vider le tampon

# Et voilà... Pour le fun, l'opération qui permet de télécharger toute la base en mémoire...
s=dbReadTable(db,"stu")

# Enfin on est civilisé donc on ferme la connexion de la base !
dbDisconnect(db)

## ----EcritureSQLite,eval=FALSE,echo=correction---------------------------
## 
## # initialisation de la connexion.
## db <- dbConnect(SQLite(), dbname = "data/stu.sqlite")
## 
## # écriture de la table, on supprime les row.names
## dbWriteTable( db, "fr", fr, row.names=F)
## 
## # Commande RSQLite pour avoir la liste des tables dans la base de données
## dbListTables( db )
## 
## # On ferme TOUJOURS la connexion
## dbDisconnect(db)
## 

