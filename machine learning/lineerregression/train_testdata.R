data<-read.csv("C:\\Users\\damla\\OneDrive\\Belgeler\\GitHub\\R\\machine learning\\lineerregression\\top_women_chess_players_aug_2020.csv")
show(data)
data<-na.omit(data)
names(data)
View(data)
df <- data[c("Standard_Rating", "Rapid_rating")]
set.seed(6)
samp<-sample(1:nrow(df),size=0.8*nrow(df))
traindata<-df[samp,]
testdata<-df[-samp,]
nrow(testdata)
nrow(traindata)
library(outliers)
install.packages("outliers")
score<-scores(traindata,type="z",prob=0.95)
function()
anytrue<-apply(score,1,FUN=function(x){any(x == TRUE)})
index<-which(anytrue)
traindataremoved<-traindata[-index,]
nrow(traindata)
nrow(traindataremoved)
install.packages("ggplot2")
library(ggplot2)
fig<-ggplot(data=traindataremoved,aes(x=Rapid_rating,y=Standard_Rating))+geom_point(size=2)
fig
install.packages("mice")
library("mice")
md.pattern(traindata)
md.pattern(data)
install.packages("caret")
library(caret)
names(traindata)

model1<-data.frame("actuals"=traindata$Standard_Rating,"predictions"=traindata$Rapid_rating)
model2<-data.frame("actuals"=traindataremoved$Standard_Rating,"predictions"=traindataremoved$Rapid_rating)

R2(model1$predictions,model1$actuals)
R2(model2$predictions,model2$actuals)
RMSE(model1$predictions,model1$actuals)
RMSE(model2$predictions,model2$actuals)
MAE(model1$predictions,model1$actuals)
MAE(model2$predictions,model2$actuals)




model1MADE<-mean(abs(model1$actuals-model1$predictions)/(model1$actuals))
model2MADE<-mean(abs(model2$actuals-model2$predictions)/(model2$actuals))
