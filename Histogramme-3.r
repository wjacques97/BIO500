##Figure 3 : Histogramme comparatif du nombre de collaborations pour une même paire d'éudiants dans les cours en ligne vs en présentiel

#Installation de deux packages nécessaires à l'histogramme, utiliser le code suivant pour les installer
#install.packages("ggplot2")
#install.packages("dplyr")
library(ggplot2)
library(dplyr)

#Retrait des NA dans les data frame de collaborations en ligne et en présentiel
nb_collab_enligne<-na.omit(enligne)
nb_collab_presentiel<-na.omit(presentiel)

#Création des vecteurs pour spécifier si les collaborations avaient eu lieu pré ou post-covid
vecenligne<-data.frame(Legende=c(rep("En ligne", 4)))
vecpresentiel<-data.frame(Legende=c(rep("Présentiel", 9)))

#Création du data frame de nombre de collaborations en ligne
nb_collab_enligne1<-data.frame(table(nb_collab_enligne[,1:2]))
nb_collab_enligne2<-data.frame(Collaborations=nb_collab_enligne1$Freq)

#Enlever tous les 0 du data frame
nb_collab_enligne3<-data.frame(Collaborations=nb_collab_enligne2[apply(nb_collab_enligne2, 1, function(row) all(row !=0 )), ])

#Création du data frame de nombre de collaborations en présentiel
nb_collab_presentiel1<-data.frame(table(nb_collab_presentiel[,1:2]))
nb_collab_presentiel2<-data.frame(Collaborations=nb_collab_presentiel1$Freq)

#Enlever tous les 0 du data frame
nb_collab_presentiel3<-data.frame(Collaborations=nb_collab_presentiel2[apply(nb_collab_presentiel2, 1, function(row) all(row !=0 )), ])

#Création du data frame avec les proportions du nombre de collaborations par équipe de 2 en ligne
data_enligne <- data.frame(Collaborations=t(prop.table(table(nb_collab_enligne3$Collaborations))) * 100)

#Création du data frame avec les proportions du nombre de collaborations par équipe de 2 en pr?sentiel
data_presentiel <- data.frame(Collaborations=t(prop.table(table(nb_collab_presentiel3$Collaborations))) * 100)

#Jonction des data frame respectifs pour définir les collaborations en ligne vs présentiel
data_enligne1<-cbind(data_enligne, vecenligne)
data_presentiel1<-cbind(data_presentiel, vecpresentiel)

#Jonctions des data frame des proportions de collaborations
enligne_presentiel<-rbind(data_enligne1, data_presentiel1)

#Ajout d'une colonne de proportions en pourcentage
enligne_presentiel1 <- enligne_presentiel %>% mutate(proportions = Collaborations.Freq / 100)

#Graphique de proportion du nombre de collaborations entre deux personnes dans des cours en ligne vs en présentiel
p6 <-ggplot(enligne_presentiel1, aes(x=Collaborations.Var2, proportions, fill= Legende))+
  geom_bar(stat = "identity", width=0.5, position="dodge")+
  labs(x="Nombre de fois que deux personnes ont collaboré ensemble",
       y="Proportion du nombre de collaborations entre deux personnes",
       title="Proportion du nombre de collaborations entre deux personnes dans des cours en ligne vs en présentiel")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels = scales::percent)

#Visualisation du graphique
p6

#Enregistrement de la figure 3 en pdf
pdf("Histogramme3.pdf", height=10, width=20)
ggplot(enligne_presentiel1, aes(x=Collaborations.Var2, proportions, fill= Legende))+
  geom_bar(stat = "identity", width=0.5, position="dodge")+
  labs(x="Nombre de fois que deux personnes ont collaboré ensemble",
       y="Proportion du nombre de collaborations entre deux personnes",
       title="Proportion du nombre de collaborations entre deux personnes dans des cours en ligne vs en présentiel")+
  theme(axis.text=element_text(size=15),
        axis.title=element_text(size=15),legend.title = element_text(size=15),legend.text = element_text(size=14), plot.title = element_text(hjust = 0.5, size=20))+
  scale_y_continuous(labels = scales::percent)
dev.off()
