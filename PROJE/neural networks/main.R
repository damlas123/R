library(neuralnet)
library(caret)
library(mice)

data<-read.csv("C:\\Users\\damla\\OneDrive\\Belgeler\\GitHub\\R\\PROJE\\neural networks\\concrete_data.csv")

View(data)
nrow(data)

datasaled<-preProcess(data,method=c("center","scale"))
tahmin<-predict(datasaled,data)
datasaled<-tahmin
datasaled$mean
datasaled$std

set.seed(7)
trainindex<-sample(1:nrow(datasaled),size=0.75*nrow(datasaled))
trainset<-datasaled[trainindex,]
testset<-datasaled[-trainindex,]

nrow(trainset)
nrow(testset)

modelnn_1<-neuralnet(Strength~.,data=trainset,
                     hidden=4,
                     threshold=0.04,
                     learningrate=0.05,
                     linear.output = TRUE
                     )
plot(modelnn_1)

modelnn_2<-neuralnet(Strength~.,data=trainset,
                     hidden=c(3,2),
                     threshold=0.04,
                     learningrate=0.05,
                     linear.output = TRUE,
                     stepmax=500000
)

plot(modelnn_2)

fittedValues<-modelnn_1$net.result[[1]]
r2<-R2(fittedValues,trainset$Strength)
r2
rmse<-RMSE(fittedValues,trainset$Strength)
rmse
mae<-MAE(fittedValues,trainset$Strength)
mae




fittedValues2<-modelnn_2$net.result[[1]]
r2_2<-R2(fittedValues2,trainset$Strength)
r2_2
rmse2<-RMSE(fittedValues2,trainset$Strength)
rmse2
mae2<-MAE(fittedValues2,trainset$Strength)
mae


#test veri ile tahminler


model1tahmin<-predict(modelnn_1,testset)
model2tahmin<-predict(modelnn_2,testset)
R2(model1tahmin,testset$Strength)
MAE(model1tahmin,testset$Strength)
RMSE(model1tahmin,testset$Strength)


R2(model2tahmin,testset$Strength)
MAE(model2tahmin,testset$Strength)
RMSE(model2tahmin,testset$Strength)


