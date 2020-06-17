#################################################
#  Company    : Stevens
#  Project    : HW-08
#  Purpose    : Cluster
#  First Name : Huajie
#  Last Name  : Xu
#  Id			    : 10442734
#  Date       : 05/02/2019
#  Comments   :

rm(list=ls())

ibm <- read.csv("IBM_Employee_Attrition_V2.csv")
ibm <- cbind(ibm[13],ibm[8],ibm[5],ibm[2])
ibm <- data.frame(lapply(na.omit(ibm),as.numeric))

ibm_dist<-dist(ibm[,-4])
hclust_resutls<-hclust(ibm_dist)
plot(hclust_resutls)
hclust_3<-cutree(hclust_resutls,2)
table(hclust_3,ibm[,4])


?kmeans

kmeans_2<- kmeans(ibm[,-4],2,nstart = 10)
kmeans_2$cluster
table(kmeans_2$cluster,ibm[,4])
