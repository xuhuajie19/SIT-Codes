#################################################
#  Company    : Stevens
#  Project    : MID-06
#  Purpose    : 
#  First Name : Huajie
#  Last Name  : Xu
#  Id			    : 10442734
#  Date       : 04/01/2019
#  Comments   :

#################################################

rm(list=ls())

#install.packages('e1071', dependencies = TRUE)

library(class)
library(e1071)

#Reload the “breast-cancer-wisconsin.data.csv” from canvas into R
ibm <- read.csv("IBM_Employee_Attrition_v1.csv")

#a)	Remove any row with missing values
ibm = na.omit(ibm)

##Define max-min normalization function
mmnorm <- function(x,minx,maxx) {
  z <- ((x-minx)/(maxx-minx))
  return(z) 
}

ibm_normalized<-as.data.frame (         
  cbind( Age=mmnorm(ibm[,1],min(ibm[,1]),max(ibm[,1]))
         ,JobSatisfaction=mmnorm(ibm[,2],min(ibm[,2]),max(ibm[,2] ))
         ,MonthlyIncome=mmnorm(ibm[,3],min(ibm[,3]),max(ibm[,3] ))
         ,YearsAtCompany=mmnorm(ibm[,4],min(ibm[,4]),max(ibm[,4] ))
         ,Single=as.character(ibm[,5])
         ,Attrition=as.character(ibm[,6])
         ,Gender=as.character(ibm[,7])
         
  )
)

#b) Select every third record as the test dataset and the remaining records as the training dataset
idx <- seq(3,nrow(ibm_normalized ),by=3)
test <- ibm_normalized[idx,]

#everything doesn't match idx, as test data
training <- ibm_normalized[-idx,]

#c) Preform Naïve Bayes using only the following columns: JobSatisfaction,Single,Gender
nBayes_3 <- naiveBayes(Attrition ~JobSatisfaction+Single+Gender, data = training)
category_3 <- predict(nBayes_3,test)

#d)	Score the test dataset
NB_wrong<-sum(category_3!=test$Attrition)

#e)	Measure the error rate
NB_error_rate<-NB_wrong/length(category_3)

NB_error_rate
