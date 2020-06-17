#################################################
#  Company    : Stevens
#  Project    : MID-05
#  Purpose    : 
#  First Name : Huajie
#  Last Name  : Xu
#  Id			    : 10442734
#  Date       : 04/01/2019
#  Comments   :

#################################################

#Import essential library
library(kknn)

#Delete all the objects
rm(list=ls())

#Reload the “breast-cancer-wisconsin.data.csv” from canvas into R
ibm <- read.csv("IBM_Employee_Attrition_v1.csv")

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

#Choose No.3,6,9,12... as the test data
idx <- seq(3,nrow(ibm_normalized ),by=3)
test <- ibm_normalized[idx,]

#everything doesn't match idx, as test data
training <- ibm_normalized[-idx,]

#Make the prediction, k=3, unweighted
predict <- kknn(formula = Attrition~., training, test, k=3, kernel = "rectangular")

#Score the dataset
fit <- fitted(predict)
table(test$Attrition,fit)

err <- (table(test$Attrition,fit)[2]+table(test$Attrition,fit)[3]) / nrow(test)
err

