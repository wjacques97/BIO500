##Requêtes SQL

##Figures 1 et 2 : Extraction des collaborations pré-covid et post-covid

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

##Requêtes figure 3
#Collaborations entre étudiants pour les cours en présentiel
requete_presentiel<-  "SELECT etudiant1,etudiant2
FROM collaborations
INNER JOIN cours ON collaborations.cours=cours.cours
WHERE presentiel LIKE 1;"
presentiel<-dbGetQuery(db,requete_presentiel)
head(presentiel)

#Collaborations entre étudiants pour les cours en ligne
requete_enligne<-  "SELECT etudiant1,etudiant2
FROM collaborations
INNER JOIN cours ON collaborations.cours=cours.cours
WHERE presentiel LIKE 0;"
enligne<-dbGetQuery(db,requete_enligne)
head(enligne)

##Figure 4 : Histogramme des cours présentiel/en ligne pour pre/post covid
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
##Aller voir les scripts pour chacunes des figures : 1,2,3,4 et pour le tableau des liens de collaborations par étudiant
##+ DE COURS EN PRE-COVID QUI NE NÉCESSITAIENT PAS DE TRAVAUX D'EQUIPE, CAR PlUS THEORIQUE AU DEPART
