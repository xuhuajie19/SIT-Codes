#################################################
#  Company    : Stevens
#  Project    : HW-03
#  Purpose    : EDA
#  First Name : Huajie
#  Last Name  : Xu
#  Id			    : 10442734
#  Date       : 03/24/2019
#  Comments   :

#################################################

#Import essential library
library(kknn)

#Delete all the objects
rm(list=ls())

#Reload the “breast-cancer-wisconsin.data.csv” from canvas into R
bcw <- read.csv("breast-cancer-wisconsin.data.csv")

#Remove any row with a missing value in any of the columns
bcw[bcw=="?"] <- NA
bcw <- na.omit(bcw)

#Generate the index number of 65% training data
idx <- sort(sample(nrow(bcw),as.integer(.65*nrow(bcw))))

training <- bcw[idx,]

#everything doesn't match idx, as test data
test <- bcw[-idx,]

#Do the prediction, in this case k=1
predict <- kknn(formula = Class~., training, test, k=1, kernel = "rectangular")

#Print result
fit <- fitted(predict)
table(test$Class,fit)
