install.packages("neuralnet")
library(neuralnet)

data<-read.csv("C:\\Users\\damla\\OneDrive\\Belgeler\\GitHub\\R\\PROJE\\neural networks\\diabetes.csv")
View(data)
data$Outcome<-as.factor(data$Outcome)
library(caret)
modelScale<-preProcess(data,method=c("center","scale"))
modelDataScaled<-predict(modelScale,data)
set.seed(6)
trainIndex<-sample(1:nrow(modelDataScaled),size=0.75*nrow(modelDataScaled))
trainset<-modelDataScaled[trainIndex,]
testset<-modelDataScaled[-trainIndex,]

nrow(trainset)
nrow(testset)

table(trainset$Outcome)
table(testset$Outcome)


modelnn1<-neuralnet(Outcome~.,data=trainset,
                    hidden=1,
                    threshold=0.01,
                    act.fct = "logistic",
                    linear.output = FALSE)

plot(modelnn1)

modelnn1



modelnn2<-neuralnet(Outcome~.,data=trainset,
                    hidden=c(2,2),
                    threshold=0.01,
                    act.fct = "logistic",
                    linear.output=FALSE)
plot(modelnn2)
modelnn2

tahmin1<-predict(modelnn1,testset)
apply(tahmin1,1,which.max)
model1_c<-ifelse(apply(tahmin1,1,which.max)==1,"0","1")


tahmin2<-predict(modelnn2,testset)
apply(tahmin2,1,which.max)
model2_c<-ifelse(apply(tahmin2,1,which.max)==1,"0","1")
confusionMatrix(as.factor(model1_c),testset$Outcome)

confusionMatrix(as.factor(model2_c),testset$Outcome)
