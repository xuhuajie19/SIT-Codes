#################################################
#  Company    : Stevens
#  Project    : HW-07
#  Purpose    : ANN
#  First Name : Huajie
#  Last Name  : Xu
#  Id			    : 10442734
#  Date       : 05/02/2019
#  Comments   :

rm(list=ls())

ibm <- read.csv("IBM_Employee_Attrition_V2.csv")
ibm <- data.frame(lapply(na.omit(ibm),as.numeric))

set.seed(Sys.time())

index <- seq (5,nrow(ibm),by=5)
test<- ibm[index,]
training<-ibm[-index,]

library("neuralnet")

net_ibm <- neuralnet(
  Attrition~Age+BusinessTravel+DistanceFromHome+Education+EmployeeID+EnvironmentSatisfaction+Gender+MaritalStatus+MonthlyIncome+NumCompaniesWorked+OverTime+TotalWorkingYears ,training, hidden=34, threshold=0.01)
#Plot the neural network
plot(net_ibm)

## test should have only the input colum
ann <-compute(net_ibm, test[,-2])
ann$net.result 

ann_cat<-ifelse(ann$net.result <1.5,1,2)
length(ann_cat)

table(Actual=test$Attrition,predition=ann_cat)

wrong<- (test$Attrition!=ann_cat)
error_rate<-sum(wrong)/length(wrong)
error_rate

