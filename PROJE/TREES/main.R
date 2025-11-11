install.packages("rpart")
install.packages("rattle")
library(rpart)
library(rattle)
data<-read.csv("C:\\Users\\damla\\OneDrive\\Belgeler\\GitHub\\R\\PROJE\\TREES\\diabetes.csv")
View(data)
library(mice)
md.pattern(data)#na de??eri var m?? diye bak??yoruz
table(data$Outcome)#burada diyabet olan ve olmayanlar??n say??s??n?? tablo halde verdi

set.seed(165)
trainindex<-sample(1:nrow(data),0.8*nrow(data))
traindata<-data[trainindex,]
testdata<-data[-trainindex,]
traindata$Outcome<-as.factor(traindata$Outcome)
testdata$Outcome<-as.factor(testdata$Outcome)
model1<-rpart(Outcome ~.,data=traindata,method="class",
      parms=list(split="information"))
model2<-rpart(Outcome ~.,data=traindata,method="class",
              parms=list(split="gini"))

install.packages("rattle")
library(rattle)

fancyRpartPlot(model1)
#a??a?? ??ok b??y??k oldu??u i??in budama yapmamam??z gerek
printcp(model1)  # hata ??apraz do??rulama (complexity parameter) tablosuna bak
pruned_model <- prune(model1, cp = 0.02)
fancyRpartPlot(pruned_model)
summary(model1)
summary(model2)




#hyper parameter

model1control<-rpart(Outcome ~. ,data=traindata,method="class",
                     parms =list(split="information"),
                     control=rpart.control(minsplit=40,cp=0.02,maxdepth=5))
predict1<-predict(model1,testdata,type="class")
predict2<-predict(model2,testdata,type="class")
predict1control<-predict(model1control,testdata,type="class")

predict1
library(caret)

confusionMatrix(predict1,testdata$Outcome)
confusionMatrix(predict2,testdata$Outcome)
confusionMatrix(predict1control,testdata$Outcome)



modelLookup("rpart")
modelLookup("rpart2")
install.packages("e1071")
library(e1071)

traincontrol1<-trainControl(method="cv",number=5,search="random")
modelCp<-train(Outcome~.,data=traindata,
               method="rpart",
               tuneLength=20,
               trControl=traincontrol1)

trcontrol2<-trainControl(method="cv",number=5,search="grid")
modelmd<-train(Outcome~.,data=traindata,
               method="rpart2",
               trControl=trcontrol2)
modelTunemin<-tune.rpart(Outcome~.,data=traindata,
                        minsplit=10:15,minbucket = 5:10,
                        cp=seq(0.0,0.2,by=0.01)
                         )

modelmd$finalmodel
premo<-predict(modelmd$finalModel,testdata,type="class")
precd<-predict(modelCp$finalModel,testdata,type="class")
preptuning<-predict(modelTunemin$best.model,testdata,type="class")


confusionMatrix(premo,testdata$Outcome,mode="prec_recall",positive="1")
confusionMatrix(precd,testdata$Outcome,mode="prec_recall",positive="1")
confusionMatrix(preptuning,testdata$Outcome,mode="prec_recall",positive="1")
