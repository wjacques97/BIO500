##Figure 2 : Histogramme comparatif du nombre de collaborations pour une même paire d'éudiants avant et depuis le début de la pandémie

#Installation d'un package nécessaire à l'histogramme, utiliser le code suivant pour l'installer
#install.packages("ggplot2")
library(ggplot2)

#Création des data frames pré-covid
test1 <- data.frame(table(testsql[,1:2]))
test2<-data.frame(Collaborations=test1$Freq)
#Enlever tous les 0 du data frame
test2<-data.frame(Collaborations=test2[apply(test2, 1, function(row) all(row !=0 )), ])

#Création des data frames post-Covid
test3<-data.frame(table(testsql2[,1:2]))
test4<-data.frame(Collaborations=test3$Freq)
#Enlever tous les 0 du data frame
test4<-data.frame(Collaborations=test4[apply(test4, 1, function(row) all(row !=0 )), ])

#Création du data frame avec les proportions du nombre de collaborations de chaque équipe de 2 pré-covid
data_perc <- data.frame(Collaborations=t(prop.table(table(test2$Collaborations))) * 100)

#Création du data frame avec les proportions du nombre de collaborations de chaque équipe de 2 post-covid
data_perc1 <- data.frame(Collaborations=t(prop.table(table(test4$Collaborations))) * 100)

#Ajout du trait pré-covid et post-covid au data frame des proportions
#install.packages("dplyr")
library(dplyr)
data_perc$Collaborations.Var1 <- as.numeric(as.character(data_perc$Collaborations.Var1))
data_perc[,c("Collaborations.Var1")][is.na(data_perc[,c("Collaborations.Var1")])] <- "Pré-Covid"
data_perc1$Collaborations.Var1 <- as.numeric(as.character(data_perc1$Collaborations.Var1))
data_perc1[,c("Collaborations.Var1")][is.na(data_perc1[,c("Collaborations.Var1")])] <- "Post-Covid"

#Jonction des deux tables de proportions
data_perc2<-data.frame(rbind(data_perc, data_perc1))

#Ajout d'une colonne de proportions en pourcentage
data_perc2 <- data_perc2 %>% mutate(proportions = Collaborations.Freq / 100)

#Modification du nom de la colonne de légende
colnames(data_perc2)[colnames(data_perc2) %in% c("Collaborations.Var1")] <- c("Légende")

#Création du graphique pré et post-covid des collaborations pour les mêmes paires d'étudiants
p55 <-ggplot(data_perc2, aes(Collaborations.Var2, proportions, fill=Légende))+
  geom_bar(stat = "identity", width=0.5, position="dodge")+
  labs(x="Nombre de fois que deux personnes ont collaboré ensemble",
       y="Proportion du nombre de collaborations entre deux personnes",
       title="Comparaison du nombre de collaborations entre deux personnes pré- et post-Covid")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels = scales::percent)

#Visualisation du graphique
p55

#Enregistrement de la figure 2 en pdf
pdf("Histogramme2.pdf", height=10, width=20)
ggplot(data_perc2, aes(Collaborations.Var2, proportions, fill=Légende))+
geom_bar(stat = "identity", width=0.5, position="dodge")+
  labs(x="Nombre de fois que deux personnes ont collaboré ensemble",
       y="Proportion du nombre de collaborations entre deux personnes",
       title="Comparaison du nombre de collaborations entre deux personnes pré- et post-Covid")+
  theme(axis.text=element_text(size=15),
        axis.title=element_text(size=15),legend.title = element_text(size=15),legend.text = element_text(size=14), plot.title = element_text(hjust = 0.5, size=20))+
  scale_y_continuous(labels = scales::percent)
dev.off()
