data<-read.csv("C:\\Users\\damla\\OneDrive\\Belgeler\\GitHub\\R\\PROJE\\LOGISTIC REGRESSION\\Placement_data_full_class.csv")
library(caret)
library(tidyverse)
library(glmnet)


data["sl_no"]<-NULL
data["salary"]<-NULL

table(data$status)
dataplaced<-data%>%filter(status=="Placed")
dataNotplaced<-data%>%filter(status=="Not Placed")

set.seed(8)
trainindex<-sample(1:nrow(dataplaced),size=0.75*nrow(dataNotplaced))
dataNotPlacedIndex<-sample(1:nrow(dataNotplaced),size=0.75*nrow(dataNotplaced ))
trainplaced<-dataplaced[trainindex,]
trainnotplaced<-dataNotplaced[dataNotPlacedIndex,]
trainSet<-rbind(trainplaced,trainnotplaced)
table(trainSet$status)

setplaced<-dataplaced[-trainindex,]
setnotplaced<-dataNotplaced[-dataNotPlacedIndex,]

testset<-rbind(setplaced,setnotplaced)
table(testset$status)



trainSet$status <- as.factor(trainSet$status)

#model olu??turma


modelogic<-glm(formula=status~.,  family="binomial",data=trainSet)
modelogic
summary(modelogic)

anova(modelogic)

