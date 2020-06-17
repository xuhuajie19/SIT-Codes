#################################################
#  Company    : Stevens
#  Project    : MID-04
#  Purpose    : 
#  First Name : Huajie
#  Last Name  : Xu
#  Id		  : 10442734
#  Date       : 04/01/2019
#  Comments   :

#################################################

rm(list=ls())

a <- c(45,48,6,42,49,63,81,56,21,75,25,48,56,24,73,82,NA,80,86,88)


#Get the mean of the dataset
a2 = na.omit(a)

#Replace NA with the mean
a[is.na(a)] <- as.numeric(as.integer(mean(a2)))

#Maximum
max(a)

#Minimum
min(a)

#Median
median(a)

#Mean
mean(a)

#Standard deviation
sd(a)

#Generate the box plot
boxplot(a)