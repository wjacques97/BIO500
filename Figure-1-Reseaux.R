##Figure 1 : construction des réseaux de collaborations pré et post-covid pour les étudiants de BIO500 et leurs autres collaborateurs
library(igraph)

#Reseau pre-covid
resprecov <- function() {
  precov<- graph_from_data_frame(testsql)
  as_adjacency_matrix(precov)
}
dim(resprecov())
precov<- graph_from_data_frame(testsql)
amprecov<-as_adjacency_matrix(precov)
plot(precov)
plot (precov, vertex.label=NA,edge.arrow.mode=0, vertex.frame.color=NA)

##Raffiner reseau pre-covid

degprecov <- apply(amprecov, 2, sum) + apply(amprecov, 1, sum)
# Le rang pour chaque noeud
rkprecov<-rank(degprecov)
# Faire un code de couleur
col.vec.precov<-rev(heat.colors(87))
# Attribuer aux noeuds la couleur
V(precov)$color = col.vec.precov[rkprecov]
#Representation du reseau raffine pre-covid
reseau_precov<-plot(precov, vertex.label=NA, edge.arrow.mode = 0,
     vertex.frame.color = "black", layout=layout.kamada.kawai(precov), main="Reseau pre-covid")

#Reseau post-covid
respostcov<-function() {
  postcov<- graph_from_data_frame(testsql2)
  as_adjacency_matrix(postcov)
}
dim(respostcov())
postcov<- graph_from_data_frame(testsql2)
ampostcov<-as_adjacency_matrix(postcov)
plot(postcov)
plot (postcov, vertex.label=NA,edge.arrow.mode=0, vertex.frame.color=NA)

#Raffiner reseau post-cov
degpostcov <- apply(ampostcov, 2, sum) + apply(ampostcov, 1, sum)
# Le rang pour chaque noeud
rkpostcov<-rank(degpostcov)
# Faire un code de couleur
col.vec.postcov<-rev(heat.colors(50))
# Attribuer aux noeuds la couleur
V(postcov)$color = col.vec.postcov[rkpostcov]
#Representation du graphique raffine post-covid
reseau_postcov<-plot(postcov, vertex.label=NA, edge.arrow.mode = 0,
                     vertex.frame.color = "black" ,layout=layout.kamada.kawai(postcov), main= "Reseau post-covid")

#Combinaison des 2 reseaux
par(mfrow=c(1,2))
plot(precov, vertex.label=NA, edge.arrow.mode = 0,
     vertex.frame.color = "black", layout=layout.kamada.kawai(precov))
title("Réseau de collaborations entre étudiants avant la pandémie de COVID-19",cex.main=1.5,col.main="black")
plot(postcov, vertex.label=NA, edge.arrow.mode = 0,
     vertex.frame.color = "black" ,layout=layout.kamada.kawai(postcov))
title("Réseau de collaborations entre étudiants depuis la pandémie de COVID-19" ,cex.main=1.5,col.main="black")

#Enregistrement de la figure 1 en pdf
pdf("reseaux_comparaison.pdf", height=10, width=20)
par(mfrow=c(1,2))
plot(precov, vertex.label=NA, edge.arrow.mode = 0,
                    vertex.frame.color = "black", layout=layout.kamada.kawai(precov))
title("Réseau de collaborations entre étudiants avant la pandémie de COVID-19",cex.main=1.5,col.main="black")
plot(postcov, vertex.label=NA, edge.arrow.mode = 0,
     vertex.frame.color = "black" ,layout=layout.kamada.kawai(postcov))
title("Réseau de collaborations entre étudiants depuis la pandémie de COVID-19" ,cex.main=1.5,col.main="black")
dev.off()
