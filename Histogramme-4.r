##Figure 4 : Comparaison du nombre de cours en ligne et du nombre de cours en présentiel avant et depuis le début de la pandémie
library(ggplot2)
#Data frame de sp?cification du  moment o? les cours ont eu lieu
veccourspre<-data.frame(Legende=c(rep("Pre-Covid", 16)))
veccourspost<-data.frame(Legende=c(rep("Post-Covid", 24)))

#Sp?cification des cours de type en ligne ou pr?sentiel
courspostcov$presentiel[courspostcov$presentiel == "0"] <- "En ligne"
courspostcov$presentiel[courspostcov$presentiel == "1"] <- "Presentiel"
coursprecov$presentiel[coursprecov$presentiel == "0"] <- "En ligne"
coursprecov$presentiel[coursprecov$presentiel == "1"] <- "Presentiel"

#Jonction des cours avec le moment o? ils ont eu lieu
courspostcov1<-cbind(courspostcov, veccourspost)
coursprecov1<-cbind(coursprecov, veccourspre)

#Jonction des deux data frame de type de cours cours pr? et post covid
coursprepost<-rbind(courspostcov1, coursprecov1)

#Graphique du type de cours en fonction du moment o? ils ont eu lieu
p7<-ggplot(coursprepost, aes(presentiel, fill=Legende))+
  geom_histogram(position="dodge", stat="count", binwidth=0.2)+
  labs(x="Type de cours",
       y="Nombre de cours de chaque type",
       title="Comparaison du nombre de cours en ligne et presentiel pre- et post-Covid")+
  theme(plot.title = element_text(hjust = 0.5))
p7
