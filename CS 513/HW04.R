#################################################
#  Company    : Stevens
#  Project    : HW-04
#  Purpose    : NB
#  First Name : Huajie
#  Last Name  : Xu
#  Id			    : 10442734
#  Date       : 03/24/2019
#  Comments   :

#################################################

rm(list=ls())

#install.packages('e1071', dependencies = TRUE)

library(class)
library(e1071)

bcw <- read.csv("breast-cancer-wisconsin.data.csv")

bcw[bcw=="?"] <- NA
bcw$F6 = as.integer(as.character(bcw$F6))
bcw <- na.omit(bcw)

nBayes_all <- naiveBayes(Class ~., data =bcw)

## Naive Bayes classification using all variables 

category_all<-predict(nBayes_all,bcw)


table(NBayes_all=category_all,Class=bcw$Class)

NB_wrong<-sum(category_all!=bcw$Class)

NB_error_rate<-NB_wrong/length(category_all)


