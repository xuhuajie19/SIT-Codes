#################################################
#  Company    : Stevens
#  Project    : HW-02
#  Purpose    : EDA
#  First Name : Huajie
#  Last Name  : Xu
#  Id			    : 10442734
#  Date       : 03/24/2019
#  Comments   :

#################################################
##   Step:
## 
##       I. Summarizing each column (e.g. min, max, mean )
##       II. Identifying missing values
##       III. Replacing the missing values with the “mode” (most frequent value) of the column.
##       IV. Displaying the frequency table of “Class” vs. F6
##       V. Displaying the scatter plot of F1 to F6, one pair at a time
##       VI. Show histogram box plot for columns F7 to F9
##
######################

rm(list=ls())
bcw <- read.csv("breast-cancer-wisconsin.data.csv")

#Summarizing each column
summary(bcw)

#Identifying missing values
bcw[bcw=="?"] <- NA
bcw$F6 = as.integer(as.character(bcw$F6))

#Replacing the missing values
modevalue <- as.integer(tail(names(sort(table(bcw$F6))),1))
bcw$F6[is.na(bcw$F6)] <- modevalue

#Displaying the frequency table
freq = as.data.frame(table("Class"=bcw$Class,"F6"=bcw$F6))
freq

#Displaying the scatter plot
plot(bcw$F1,bcw$F2,xlab="F1",ylab="F2")
plot(bcw$F3,bcw$F4,xlab="F3",ylab="F4")
plot(bcw$F5,bcw$F6,,xlab="F5",ylab="F6")

#Show histogram box plot
hist(bcw$F7)
hist(bcw$F8)
hist(bcw$F9)
boxplot(bcw$F7,bcw$F8,bcw$F9)

#Part 2 

#Delete all the objects from your R- environment. 
rm(list=ls())

#Reload the “breast-cancer-wisconsin.data.csv” from canvas into R. 
bcw <- read.csv("breast-cancer-wisconsin.data.csv")

#Remove any row with a missing value in any of the columns.
bcw[bcw=="?"] <- NA
bcw_cleaned<-na.omit(bcw)
