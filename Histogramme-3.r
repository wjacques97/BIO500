library(ggplot2)
#Création des vecteurs pour sp?cifier si les collaborations avaient eu lieu pre ou post-covid
vecpre<-data.frame(Légende=c(rep("Pré-covid", 79)))
vecpost<-data.frame(Légende=c(rep("Post-covid", 50)))

#Attachement des vecteurs de spécification pre ou post-covid au data frame respectif
nb_collab_postcov1<-data.frame(cbind(nb_collab_postcov, vecpost))
nb_collab_precov1<-data.frame(cbind(nb_collab_precov, vecpre))

#Attachement des data frame de collaboration pre-covid et post-covid
total_collab<-data.frame(rbind(nb_collab_postcov1, nb_collab_precov1))

#Retrait des NA
total_collab<-na.omit(total_collab)

#Graphique du nombre de collab par personne pre et post-covid
p6 <-ggplot(total_collab, aes(x=nbcollab, fill= Légende))+
  geom_histogram(position="dodge", bins=45)+
  labs(x="Nombre de collaborations par personne",
       y="Total des personnes qui ont ce nombre de collaborations",
       title="Comparaison du nombre de collaborations par personne pré- et post-Covid")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_x_continuous(breaks = seq(0, 22, by = 2)) +
  scale_y_continuous(breaks = seq(0, 25, by = 2))
#Visualisation du graphique
p6
