library(RSQLite)
setwd("~/UdeS/UdeS Éco H2021/BIO 500 - Méthodes en écologie computationnelle/BIO500")
db<-dbConnect(SQLite(), dbname="./reseau.db")

#Création tableau liste étudiants dans la base de données

etudiants_sql<- 'CREATE TABLE etudiants (
nom_prenom VARCHAR(50),
BIO500 BOLEAN(1),
PRIMARY KEY (nom_prenom)
);'

dbSendQuery(db,etudiants_sql) 
dbListTables(db)

#Création tableau liste collaborations dans la base de données

collaborations_sql<-'CREATE TABLE collaborations (
  etudiant1 VARCHAR(50),
  etudiant2 VARCHAR(50),
  cours CHAR(6),
  date CHAR (3),
  PRIMARY KEY (etudiant1, etudiant2, cours),
  FOREIGN KEY (etudiant1) REFERENCES etudiants(nom_prenom),
  FOREIGN KEY (etudiant2) REFERENCES etudiants(nom_prenom),
  FOREIGN KEY (cours) REFERENCES cours(cours));'

dbSendQuery(db,collaborations_sql)
dbListTables(db)

#Création tableau cours dans la base de données

cours_sql<- 'CREATE TABLE cours (
  cours CHAR(6),
  credits INTEGER(1),
  presentiel BOLEAN(1),
  libre BOLEAN(1),
  PRIMARY KEY (cours));'

dbSendQuery(db,cours_sql)
dbListTables(db)

# Lecture des fichiers CSV
bd_etudiants<-read.table(file = "noeuds.csv")
bd_collaborations<-read.table(file ="collaborations.csv")
bd_cours<-read.table(file = "cours.csv")

# Injection des enregistrements dans la BD
dbWriteTable(db, append = TRUE, name = "etudiants", value = bd_etudiants, row.names = FALSE)
dbWriteTable(db, append = TRUE, name = "collaborations", value = bd_collaborations, row.names = FALSE)
dbWriteTable(db, append = TRUE, name = "cours", value = bd_cours, row.names = FALSE)

#Commande utiles
#dbSendQuery(db,"DROP TABLE etudiants;")
#dbSendQuery(db,"DROP TABLE collaborations;")
#dbSendQuery(db,"DROP TABLE cours;")
#dbDisconnect(db)

#Requêtes

#Figure 1 : Extraction des collaborations pré-covid et post-covid pour les étudiants avec ou sans BIO500

#Requête avec BIO500
sql_requete<- "SELECT nom_prenom
FROM etudiants
WHERE BIO500 like 1
;"
sqlavecBIO500<-dbGetQuery(db,sql_requete)
head(sqlavecBIO500)

#Requête sans BIO500
sql_requete<- "SELECT nom_prenom
FROM etudiants
WHERE BIO500 like 0
;"
sqlsansBIO500<-dbGetQuery(db,sql_requete)
head(sqlsansBIO500)

#Figure 2 : Extraction des collaborations pré-covid et post-covid

#Requête pré-covid
sql_requete<- "SELECT etudiant1, etudiant2
FROM collaborations
WHERE      date like 'H18%'
OR         date like 'A18%' 
OR         date like 'H19%'
OR         date like 'E19%'
OR         date like 'A19%' 
OR         date like 'H20%';"
testsql<-dbGetQuery(db,sql_requete)
head(testsql)

#Requête post-covid
sql_requete<- "SELECT etudiant1, etudiant2
FROM collaborations
WHERE      date like 'E20%' 
OR         date like 'A20%'
OR         date like 'H21%' ;"
testsql2<-dbGetQuery(db,sql_requete)
head(testsql2)
