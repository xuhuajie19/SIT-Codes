#################################################
#  Company    : Stevens
#  Project    : MID-03
#  Purpose    : EDA
#  First Name : Huajie
#  Last Name  : Xu
#  Id			    : 10442734
#  Date       : 04/02/2019
#  Comments   :

#################################################
#Import essential library
library(kknn)

#Delete all the objects
rm(list=ls())

xyz <- read.csv("mid03a.csv")

training <- xyz[1:3,]

test <- xyz[4,]

#K = 2 and method = "unweighted vote" is used

predict <- kknn(formula = IncomeK~., training, test, k=2, kernel = "rectangular")

fit <- fitted(predict)

#The answer is 95(K)
fit

#K = 3 and method = ”distance weighted vote” is used

predict <- kknn(formula = IncomeK~., training, test, k=3, kernel = "triangular")

fit <- fitted(predict)

#The answer is 96.67(K)
fit

##Problem 2

#Delete all the objects
rm(list=ls())

xyz <- read.csv("mid03b.csv")

##Define max-min normalization function
mmnorm <- function(x,minx,maxx) {
  z <- ((x-minx)/(maxx-minx))
  return(z) 
}

xyz_normalized <- as.data.frame (         
  cbind( Income=mmnorm(xyz[,2],min(xyz[,2]),max(xyz[,2]))
         ,AssetSize=mmnorm(xyz[,3],min(xyz[,3]),max(xyz[,3] ))
         ,IncomeK=as.character(xyz[,4])
  )
)

training <- xyz_normalized[1:6,]

test <- xyz_normalized[7,]

predict <- kknn(formula = IncomeK~., training, test, k=3, kernel = "rectangular")

fit <- fitted(predict)

##The result: High
fit

