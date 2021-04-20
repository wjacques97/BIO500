#Nombre de liens par étudiant 1
Tab_nb_collab<-merge(nb_collab_precov,nb_collab_postcov,by="etudiant1")
class(Tab_nb_collab)
head(Tab_nb_collab)

#Noms de colonnes
colnames(Tab_nb_collab)[colnames(Tab_nb_collab) %in% c("etudiant1")] <- c("Étudiants")
colnames(Tab_nb_collab)[colnames(Tab_nb_collab) %in% c("nbcollab.x")] <- c("Nombre de collaborations pré-covid")
colnames(Tab_nb_collab)[colnames(Tab_nb_collab) %in% c("nbcollab.y")] <- c("Nombre de collaborations post-covid")

#Exportation du tableau en fichier Latex
library(knitr)
Tab_nb_collab_tex<-kable(Tab_nb_collab,format="latex")
writeLines(Tab_nb_collab_tex, con = "./Tab_nb_collab.tex", sep = "\n", useBytes = FALSE)