library(ggplot2)
library(dplyr)
#Retrait des NA
nb_collab_enligne<-na.omit(enligne)
nb_collab_presentiel<-na.omit(presentiel)

#Creation des vecteurs pour sp?cifier si les collaborations avaient eu lieu pre ou post-covid
vecenligne<-data.frame(Legende=c(rep("En ligne", 4)))
vecpresentiel<-data.frame(Legende=c(rep("Presentiel", 9)))

#En ligne
nb_collab_enligne1<-data.frame(table(nb_collab_enligne[,1:2]))
nb_collab_enligne2<-data.frame(Collaborations=nb_collab_enligne1$Freq)
#Enlever tous les 0 du data frame
nb_collab_enligne3<-data.frame(Collaborations=nb_collab_enligne2[apply(nb_collab_enligne2, 1, function(row) all(row !=0 )), ])

#Presentiel
nb_collab_presentiel1<-data.frame(table(nb_collab_presentiel[,1:2]))
nb_collab_presentiel2<-data.frame(Collaborations=nb_collab_presentiel1$Freq)
#Enlever tous les 0 du data frame
nb_collab_presentiel3<-data.frame(Collaborations=nb_collab_presentiel2[apply(nb_collab_presentiel2, 1, function(row) all(row !=0 )), ])

#Creation du data frame avec les proportions du nombre de collaborations par ?quipe de 2 en ligne
data_enligne <- data.frame(Collaborations=t(prop.table(table(nb_collab_enligne3$Collaborations))) * 100)

#Creation du data frame avec les proportions du nombre de collaborations par ?quipe de 2 en pr?sentiel
data_presentiel <- data.frame(Collaborations=t(prop.table(table(nb_collab_presentiel3$Collaborations))) * 100)

#Jonction des data frame respectifs pour d?finir les collaborations en ligne vs pr?sentiel
data_enligne1<-cbind(data_enligne, vecenligne)
data_presentiel1<-cbind(data_presentiel, vecpresentiel)

#Jonctions des data frame des collaborations
enligne_presentiel<-rbind(data_enligne1, data_presentiel1)

#Ajout d'une colonne de proportions en pourcentage
enligne_presentiel1 <- enligne_presentiel %>% mutate(proportions = Collaborations.Freq / 100)

#Graphique de proportion du nombre de collaborations entre deux personnes dans des cours en ligne vs presentiel
p6 <-ggplot(enligne_presentiel1, aes(x=Collaborations.Var2, proportions, fill= Legende))+
  geom_bar(stat = "identity", width=0.5, position="dodge")+
  labs(x="Nombre de fois que deux personnes ont collabore ensemble",
       y="Proportion du nombre de collaborations entre deux personnes",
       title="Proportion du nombre collaborations entre deux personnes dans des cours en ligne vs en presentiel")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels = scales::percent)
#Sortie du graphique
p6
