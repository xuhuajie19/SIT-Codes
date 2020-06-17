#################################################
#  Company    : Stevens
#  Project    : HW-06-2
#  Purpose    : C50
#  First Name : Huajie
#  Last Name  : Xu
#  Id			    : 10442734
#  Date       : 04/08/2019
#  Comments   :

#################################################

##  Step 0: Clear the environment
rm(list=ls())

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

### remove all the records with missing value

bcw<-na.omit(bcw)
set.seed(Sys.time())


index<-sort(sample(nrow(bcw),round(.25*nrow(bcw))))
training<-bcw[-index,]
test<-bcw[index,]

#install.packages("C50")

# C50  classification 
library('C50')
C50_class <- C5.0( Class~.,data=training )

summary(C50_class)
dev.off()
plot(C50_class)
C50_predict<-predict( C50_class ,test , type="class" )
table(actual=test[,10],C50=C50_predict)
wrong<- (test[,10]!=C50_predict)
c50_rate<-sum(wrong)/length(test[,10])
c50_rate
