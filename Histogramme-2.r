##Figure 2 : Histogramme comparatif du nombre de collaborations pour une même paire d'éudiants avant et depuis le début de la pandémie
library(ggplot2)

#Pr?-covid
test1 <- data.frame(table(testsql[,1:2]))
test2<-data.frame(Collaborations=test1$Freq)
#Enlever tous les 0 du data frame
test2<-data.frame(Collaborations=test2[apply(test2, 1, function(row) all(row !=0 )), ])

#Post-Covid
test3<-data.frame(table(testsql2[,1:2]))
test4<-data.frame(Collaborations=test3$Freq)
#Enlever tous les 0 du data frame
test4<-data.frame(Collaborations=test4[apply(test4, 1, function(row) all(row !=0 )), ])

#Cr?ation du data frame avec les proportions du nombre de collaborations par ?quipe de 2 pr?-covid
data_perc <- data.frame(Collaborations=t(prop.table(table(test2$Collaborations))) * 100)

#Cr?ation du data frame avec les proportions du nombre de collaborations par ?quipe de 2 post-covid
data_perc1 <- data.frame(Collaborations=t(prop.table(table(test4$Collaborations))) * 100)

#Superposition des donn?es en un graphique
#Ajout du trait de pr?-covid et post-covid
#install.packages("dplyr")
library(dplyr)
data_perc$Collaborations.Var1 <- as.numeric(as.character(data_perc$Collaborations.Var1))
data_perc[,c("Collaborations.Var1")][is.na(data_perc[,c("Collaborations.Var1")])] <- "Pré-Covid"
data_perc1$Collaborations.Var1 <- as.numeric(as.character(data_perc1$Collaborations.Var1))
data_perc1[,c("Collaborations.Var1")][is.na(data_perc1[,c("Collaborations.Var1")])] <- "Post-Covid"
#Jonction des deux tables
data_perc2<-data.frame(rbind(data_perc, data_perc1))
#Ajout d'une colonne de proportions en pourcentage
data_perc2 <- data_perc2 %>% mutate(proportions = Collaborations.Freq / 100)
#Modification du nom de la colonne de l?gende
colnames(data_perc2)[colnames(data_perc2) %in% c("Collaborations.Var1")] <- c("Légende")
#Graphique pr? et post-covid superpos?
p55 <-ggplot(data_perc2, aes(Collaborations.Var2, proportions, fill=Légende))+
  geom_bar(stat = "identity", width=0.5, position="dodge")+
  labs(x="Nombre de fois que deux personnes ont collaboré ensemble",
       y="Proportion du nombre de collaborations entre deux personnes",
       title="Comparaison du nombre de collaborations entre deux personnes pré- et post-Covid")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels = scales::percent)
#visualisation de l'histogramme
p55
