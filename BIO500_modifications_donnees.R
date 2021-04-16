#Importation des fichiers
AABBBcollaborations<-read.table("AABBB_collaborations.csv", header=T, sep=";")
Augercollaborations_<-read.table("Auger_etal_collaborations.csv", header=T, sep=";")
Drouincollaborations<-read.table("Drouin_etal_collaborations.csv", header=T, sep=";")
Merielcollaborations<-read.table("Meriel_etal_collaborations.csv", header=T, sep=";")
Teamdefeucollaborations<-read.table("Teamdefeu_collaborations.csv", header=T, sep=";")
Vachoncollaborations<-read.table("Vachon_etal_collaborations.csv", header=T, sep=";")
AABBBcours<-read.table("AABBB_cours.csv", header=T, sep=";")
Augercours<-read.table("Auger_etal_cours.csv", header=T, sep=";")
Drouincours<-read.table("Drouin_etal_cours.csv", header=T, sep=";")
Merielcours<-read.table("Meriel_etal_cours.csv", header=T, sep=";")
Teamdefeucours<-read.table("Teamdefeu_cours.csv", header=T, sep=";")
Vachoncours<-read.table("Vachon_etal_cours.csv", header=T, sep=";")
AABBBnoeuds<-read.table("AABBB_noeuds.csv", header=T, sep=";")
Augernoeuds_<-read.table("Auger_etal_noeuds.csv", header=T, sep=";")
Drouinnoeuds<-read.table("Drouin_etal_noeuds.csv", header=T, sep=";")
Merielnoeuds<-read.table("Meriel_etal_noeuds.csv", header=T, sep=";")
Teamdefeunoeuds<-read.table("Teamdefeu_noeuds.csv", header=T, sep=";",stringsAsFactors = F)
Vachonnoeuds<-read.table("Vachon_etal_noeuds.csv", header=T, sep=";")

#Standardisation des noms de colonnes
colnames(Merielcollaborations)[colnames(Merielcollaborations) %in% c("ï..etudiant1", "session")] <- c("etudiant1", "date")
colnames(Teamdefeucollaborations)[colnames(Teamdefeucollaborations) %in% c("ï..etudiant1")] <- c("etudiant1")
colnames(Drouincollaborations)[colnames(Drouincollaborations) %in% c("session")] <- c("date")
colnames(Teamdefeucours)[colnames(Teamdefeucours) %in% c("ï..sigle")] <- c("sigle")
colnames(Merielcours)[colnames(Merielcours) %in% c("ï..sigle")] <- c("sigle")
colnames(Drouincours)[colnames(Drouincours) %in% c("credit")] <- c("credits")
colnames(Augercours)[colnames(Augercours) %in% c("ï..sigle")] <- c("sigle")
colnames(Drouinnoeuds)[colnames(Drouinnoeuds) %in% c("session")] <- c("session_debut")
colnames(Merielnoeuds)[colnames(Merielnoeuds) %in% c("ï..nom")] <- c("nom_prenom")
colnames(Teamdefeunoeuds)[colnames(Teamdefeunoeuds) %in% c("ï..nom_prenom")] <- c("nom_prenom")

#Association de BIO500 avec les personnes dans le fichier noeuds de Auger
augerBIO500<-unique(Augercollaborations_[c("etudiant1", "Participation.BIO500")])
augerBIO500<- within(augerBIO500, Participation.BIO500[etudiant1=="cloutier_zachary"] <- (Participation.BIO500[etudiant1=="cloutier_zahary"]=NA))
augerBIO500<- within(augerBIO500, Participation.BIO500[etudiant1=="beaupre_raphael"] <- (Participation.BIO500[etudiant1=="beaupre_raphael"]=NA))
augerBIO500<- unique(augerBIO500)
#Correction et cr?ation de fichiers non-conformes de l'?quipe Auger et al.
unique<-unique(Augercollaborations_$etudiant1)
Augernoeuds <- data.frame(nom_prenom=c(unique), session_debut=c(rep(NA,37)), programme=c(rep(NA,37)), coop=c(rep(NA,37)), BIO500=c(augerBIO500$Participation.BIO500), stringsAsFactors=FALSE)
Augercollaborations<-data.frame(etudiant1=c(Augercollaborations_$etudiant1), etudiant2=c(Augercollaborations_$etudiant2), cours=c(Augercollaborations_$cours), date=c(Augercollaborations_$date), stringsAsFactors = F)

#Correction de la valeur non-conforme de nom_prenom de l'?quipe Auger et al. dans le fichier noeuds
Augernoeuds$nom_prenom[Augernoeuds$nom_prenom =="pelletier_karlphillipe"] <- "pelletier_karlphilippe"

#Correction de la valeur non-conforme d'appartenance au r?gime COOP de l'?quipe Team de feu dans le fichier noeuds
Teamdefeunoeuds$coop <- as.character(Teamdefeunoeuds$coop)
Teamdefeunoeuds$coop[Teamdefeunoeuds$coop == "coop"] <- "1"
#Correction de la valeur non-conforme de nom_prenom de l'?quipe Team de feu dans le fichier noeuds
Teamdefeunoeuds$nom_prenom[Teamdefeunoeuds$nom_prenom =="lespÃ©rance_laurie"] <- "lesperance_laurie"

#Correction de la valeur non-conforme de etudiant1 de l'?quipe Auger et al. dans le fichier collaborations
Augercollaborations$etudiant1[Augercollaborations$etudiant1=="pelletier_karlphillipe"] <- "pelletier_karlphilippe"

#Correction de valeur pr?sentiel/distance dans Merielcours pour ECL603
Merielcours<- within(Merielcours,presentiel[sigle=="ECL603"] <- (presentiel[sigle=="ECL603"]=1))
#Correction de valeur pr?sentiel/distance dans Vachoncours pour ECL611 et ECL616
Vachoncours<- within(Vachoncours,presentiel[sigle=="ECL611"] <- (presentiel[sigle=="ECL611"]=1))
Vachoncours<- within(Vachoncours,presentiel[sigle=="ECL616"] <- (presentiel[sigle=="ECL616"]=1))
#Correction de valeur pr?sentiel/distance dans Teamdefeucours pour PSL105
Teamdefeucours<- within(Teamdefeucours,presentiel[sigle=="PSL105"] <- (presentiel[sigle=="PSL105"]=0))
#Cr?ation des data frame de chaque type de document en assemblant les documents des ?quipes
cours<-rbind(AABBBcours, Augercours, Drouincours, Merielcours, Teamdefeucours, Vachoncours)
collaborations<-rbind(AABBBcollaborations, Augercollaborations, Drouincollaborations, Merielcollaborations, Teamdefeucollaborations, Vachoncollaborations)
noeuds<-rbind(AABBBnoeuds, Augernoeuds, Drouinnoeuds, Merielnoeuds, Teamdefeunoeuds, Vachonnoeuds)
#On d?cide de retirer les colonnes COOP
#Noeuds pas corrig? mais remove NA et unique fait -> probl?me de + = coop de Ariane Gauthier
noeuds<-noeuds[!is.na(noeuds$BIO500),]
noeuds<-unique(noeuds[c("nom_prenom", "BIO500")])
#Correction du nombre de cr?dits erronn? pour des cours
cours["49", 2] = 3
cours["50", 2] = 2
#Supression des doublons dans cours
cours<-unique(cours)
#Correction du tableau de collaboration global
collaborations<-unique(collaborations)
