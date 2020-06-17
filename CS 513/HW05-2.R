#################################################
#  Company    : Stevens
#  Project    : HW-05-2
#  Purpose    : CART
#  First Name : Huajie
#  Last Name  : Xu
#  Id			    : 10442734
#  Date       : 04/08/2019
#  Comments   :

#################################################

##  Step 0: Clear the environment
rm(list=ls())

##  Step 1: Load the relavent packages
#install.packages("rpart")
#install.packages("rpart.plot")     # Enhanced tree plots
#install.packages("rattle")         # Fancy tree plot
#install.packages("RColorBrewer")   # colors needed for rattle
library(rpart)
library(rpart.plot)  			# Enhanced tree plots
library(rattle)           # Fancy tree plot
library(RColorBrewer)     # colors needed for rattle

##  Step 2:  example
bcw <- read.csv("breast-cancer-wisconsin.data.csv")

bcw <- as.data.frame (         
  cbind( F1=as.character(bcw[,2])
         ,F2=as.character(bcw[,3])
         ,F3=as.character(bcw[,4])
         ,F4=as.character(bcw[,5])
         ,F5=as.character(bcw[,6])
         ,F6=as.character(bcw[,7])
         ,F7=as.character(bcw[,8])
         ,F8=as.character(bcw[,9])
         ,F9=as.character(bcw[,10])
         ,Class=as.character(bcw[,11])
  )
)

set.seed(Sys.time())

index<-sort(sample(nrow(bcw),round(.25*nrow(bcw))))
training<-bcw[-index,]
test<-bcw[index,]

#Grow the tree 
CART_class<-rpart( Class~.,data=training)
rpart.plot(CART_class)
CART_predict2<-predict(CART_class,test, type="class") 
table(Actual=test[,10],CART=CART_predict2)
CART_predict<-predict(CART_class,test) 


CART_predict<-predict(CART_class,test)
str(CART_predict)
CART_predict_cat<-ifelse(CART_predict[,1]<=.5,'Yes','No')

table(Actual=test[,10],CART=CART_predict_cat)
CART_wrong<-sum(test[,10]!=CART_predict_cat)
CART_error_rate<-CART_wrong/length(test[,10])
CART_error_rate
CART_predict2<-predict(CART_class,test, type="class")
CART_wrong2<-sum(test[,10]!=CART_predict2)
CART_error_rate2<-CART_wrong2/length(test[,10])
CART_error_rate2 

library(rpart.plot)
prp(CART_class)

# much fancier graph
fancyRpartPlot(CART_class)

