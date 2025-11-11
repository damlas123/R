data<-read.csv("C:\\Users\\damla\\OneDrive\\Belgeler\\GitHub\\R\\PROJE\\TREES\\data.csv")
View(data)
names(data)
data<-data[-c(33)]

library(caret)
library(mice)
md.pattern(data)

library(e1071)
library(rpart)
library(rattle)

set.seed(86)
trainIndex<-sample(1:nrow(data),0.8*nrow(data))
traindata<-data[trainIndex,]
testdata<-data[-trainIndex,]

traindata$diagnosis<-as.factor(traindata$diagnosis)
testdata$diagnosis<-as.factor(testdata$diagnosis)

table(traindata$diagnosis)
table(testdata$diagnosis)
model1<-rpart(diagnosis~.,data=traindata,method="class",
              parms=list(split="information"))

model2<-rpart(diagnosis~.,data=traindata,method="class",
              parms=list(split="gini"))
summary(model1)
fancyRpartPlot(model1)
fancyRpartPlot(model2)

model1Control<-rpart(diagnosis~.,data=traindata,method="class",
                     parms=list(split="information"),
                    control=rpart.control(minsplit=2,cp=0.5,maxdepth=5))


predict1<-predict(model1,testdata,type="class")
predict2<-predict(model2,testdata,type="class")
predict3<-predict(model1Control,testdata,type="class")

confusionMatrix(predict1,testdata$diagnosis)
confusionMatrix(predict2,testdata$diagnosis)
confusionMatrix(predict3,testdata$diagnosis)


#tuning a??amas?? 


modelLookup("rpart")
modelLookup("rpart2")

traincontrol<-trainControl(method="cv",number=5,search="random")
modelControl<-train(diagnosis~.,data=traindata,
                    method="rpart",
                    tuneLength=4,
                    trControl=traincontrol)
traincontrol2<-trainControl(method="cv",number=5,search="grid")
modelMd<-train(diagnosis~.,data=traindata,
               method="rpart2",
               trControl=traincontrol2)


modelTunemin<-tune.rpart(diagnosis~.,data=traindata,
                         minsplit = 4:7,minbucket=2:6,cp=seq(0.0,0.2,0.01))


predictmodelTunemin<-predict(modelTunemin$best.model,testdata,type="class")
predictmodelMd<-predict(modelMd$finalModel,testdata,type="class")
predictmodelControl<-predict(modelControl$finalModel,testdata,type="class")



confusionMatrix(predictmodelTunemin,data=testdata$diagnosis,mode="prec_recall",positive="B")
confusionMatrix(predictmodelMd,data=testdata$diagnosis,mode="prec_recall",positive="B")
confusionMatrix(predictmodelControl,data=testdata$diagnosis,mode="prec_recall",positive = "B")


