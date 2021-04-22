###Script de création de la base de données, de sa construction et des requêtes
##Création de la base de données
library(RSQLite)
db<-dbConnect(SQLite(), dbname="./reseau.db")

#Création du tableau étudiants dans la base de données

etudiants_sql<- 'CREATE TABLE etudiants (
nom_prenom VARCHAR(50),
BIO500 BOLEAN(1),
PRIMARY KEY (nom_prenom)
);'

dbSendQuery(db,etudiants_sql) 
dbListTables(db)

#Création du tableau collaborations dans la base de données

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

#Création du tableau cours dans la base de données

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

## Injection des données dans la BD
dbWriteTable(db, append = TRUE, name = "etudiants", value = bd_etudiants, row.names = FALSE)
dbWriteTable(db, append = TRUE, name = "collaborations", value = bd_collaborations, row.names = FALSE)
dbWriteTable(db, append = TRUE, name = "cours", value = bd_cours, row.names = FALSE)

#Commandes utiles
#dbSendQuery(db,"DROP TABLE etudiants;")
#dbSendQuery(db,"DROP TABLE collaborations;")
#dbSendQuery(db,"DROP TABLE cours;")
#dbDisconnect(db)
