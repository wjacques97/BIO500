library(RSQLite)
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

#Figures 1 et 2 : Extraction des collaborations pré-covid et post-covid

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

##Requêtes tableau du nombre de liens par personne
#Nombre de liens par étudiant 1
requete_collab <- "SELECT DISTINCT etudiant1, count(etudiant1) AS nbcollab FROM (
SELECT DISTINCT etudiant1,etudiant2,
count(etudiant2) AS nb_liens
FROM collaborations
GROUP BY etudiant1, etudiant2
ORDER BY nb_liens
) GROUP BY etudiant1
ORDER BY nbcollab
;"
nb_collab <- dbGetQuery(db, requete_collab)
head(nb_collab)

#Requête du nombre de liens par étudiant avant covid
requete_collab_precov <- "SELECT DISTINCT etudiant1, count(etudiant1) AS nbcollab FROM (
SELECT DISTINCT etudiant1,etudiant2,
count(etudiant2) AS nb_liens
FROM collaborations
WHERE date LIKE '%A18%' OR date LIKE '%H19%' OR date LIKE '%E19%' OR date LIKE '%A19%'OR date LIKE '%H20%'
GROUP BY etudiant1, etudiant2
ORDER BY nb_liens
) GROUP BY etudiant1
ORDER BY nbcollab
;"
nb_collab_precov<- dbGetQuery(db, requete_collab_precov)
head(nb_collab_precov)

#Requête du nombre de liens par étudiant après covid
requete_collab_postcov <- "SELECT DISTINCT etudiant1, count(etudiant1) AS nbcollab FROM (
SELECT DISTINCT etudiant1,etudiant2,
count(etudiant2) AS nb_liens
FROM collaborations
WHERE date LIKE '%E20%' OR date LIKE '%A20%' OR date LIKE '%H21%' 
GROUP BY etudiant1, etudiant2
ORDER BY nb_liens
) GROUP BY etudiant1
ORDER BY nbcollab
;"
nb_collab_postcov<- dbGetQuery(db, requete_collab_postcov)
head(nb_collab_postcov)

#Requête figure 3

requete_presentiel<-  "SELECT etudiant1,etudiant2
FROM collaborations
INNER JOIN cours ON collaborations.cours=cours.cours
WHERE presentiel LIKE 1;"
presentiel<-dbGetQuery(db,requete_presentiel)
head(presentiel)

requete_enligne<-  "SELECT etudiant1,etudiant2
FROM collaborations
INNER JOIN cours ON collaborations.cours=cours.cours
WHERE presentiel LIKE 0;"
enligne<-dbGetQuery(db,requete_enligne)
head(enligne)

#Figure 4 : Histogramme des cours présentiel/en ligne pour pre/post covid
#cours pre-covid
requete_coursprecov<-  "SELECT DISTINCT presentiel, cours.cours
FROM collaborations
INNER JOIN cours ON collaborations.cours=cours.cours
WHERE date like '%A18%' OR date LIKE '%H19%' OR date LIKE '%E19%' OR date LIKE '%A19%'OR date LIKE '%H20%';"
coursprecov<-dbGetQuery(db,requete_coursprecov)
head(coursprecov)

#cours post-covid
requete_courspostcov<-  "SELECT DISTINCT presentiel, cours.cours
FROM collaborations
INNER JOIN cours ON collaborations.cours=cours.cours
WHERE date like '%E20%' OR date LIKE '%A20%' OR date LIKE '%H21%';"
courspostcov<-dbGetQuery(db,requete_courspostcov)
head(courspostcov)

##PLUS DE COURS EN PRE-COVID QUI NE NÉCESSITAIENT PAS DE TRAVAUX D'EQUIPE, CAR PlUS THEORIQUE AU DEPART
