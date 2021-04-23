##Figure 4 : Comparaison du nombre de cours en ligne et du nombre de cours en présentiel avant et depuis le début de la pandémie
library(ggplot2)
#Data frame de sp?cification du  moment o? les cours ont eu lieu
veccourspre<-data.frame(Legende=c(rep("Pré-Covid", 16)))
veccourspost<-data.frame(Legende=c(rep("Post-Covid", 24)))

#Sp?cification des cours de type en ligne ou pr?sentiel
courspostcov$presentiel[courspostcov$presentiel == "0"] <- "En ligne"
courspostcov$presentiel[courspostcov$presentiel == "1"] <- "Présentiel"
coursprecov$presentiel[coursprecov$presentiel == "0"] <- "En ligne"
coursprecov$presentiel[coursprecov$presentiel == "1"] <- "Présentiel"

#Jonction des cours avec le moment o? ils ont eu lieu
courspostcov1<-cbind(courspostcov, veccourspost)
coursprecov1<-cbind(coursprecov, veccourspre)

#Jonction des deux data frame de type de cours cours pr? et post covid
coursprepost<-rbind(courspostcov1, coursprecov1)

#Graphique du type de cours en fonction du moment o? ils ont eu lieu
p7<-ggplot(coursprepost, aes(presentiel, fill=Legende))+
  geom_histogram(position="dodge", width=0.5, stat="count", binwidth=0.2)+
  labs(x="Catégorie de cours",
       y="Nombre de cours de chaque catégorie",
       title="Comparaison du nombre de cours en ligne et présentiel avant et depuis le début de la pandémie")+
  theme(plot.title = element_text(hjust = 0.5))
#Visualiser le graphique
p7
#Enregistrement de la figure 4 en pdf
pdf("Histogramme4.pdf", height=10, width=20)
ggplot(coursprepost, aes(presentiel, fill=Legende))+
  geom_histogram(position="dodge", width=0.5, stat="count", binwidth=0.2)+
  labs(x="Catégorie de cours",
       y="Nombre de cours de chaque catégorie",
       title="Comparaison du nombre de cours en ligne et présentiel avant et depuis le début de la pandémie")+
  theme(axis.text=element_text(size=15),
        axis.title=element_text(size=15),legend.title = element_text(size=15),legend.text = element_text(size=14), plot.title = element_text(hjust = 0.5, size=20))
dev.off()
