data<-read.csv("C:\\Users\\damla\\OneDrive\\Belgeler\\GitHub\\R\\PROJE\\neural networks\\train.csv")
View(data)

dim(data)
names(data)[1:10]
library(grid)
library(caret)
library(mice)
show_digit<-function(data_row){
  label<-data_row[1]
  pixels<-as.numeric(data_row[-1])
  pixel_matrix<-matrix(pixels,nrow=28,ncol=28)
  image(t(pixel_matrix)[,28:1]
        ,col=gray(0:255/255),
        main=paste("The number is:",label),
        axes=FALSE)
 
}

show_digit(data[25,])

set.seed(123)
sample_index<-sample(1:nrow(data),2500)

datascaled<-data[sample_index,]
dim(datascaled)
datascaled$label<-as.factor(datascaled$label)
str(datascaled$label)

mnist_scaled<-datascaled
mnist_scaled[,-1]<-mnist_scaled[,-1]/255
max(mnist_scaled[500,200:300])

install.packages("nnet")
library(nnet)
labels_one_hot<-class.ind(mnist_scaled$label)
colnames(labels_one_hot)<-paste0("label",colnames(labels_one_hot))

train_data_final<-data.frame(mnist_scaled[,-1],labels_one_hot)
dim(train_data_final)

output_formula<-paste(colnames(labels_one_hot),collapse="+")
input_formula<-paste(names(mnist_scaled)[-1],collapse="+")
final_formula<-as.formula(paste(output_formula,"~",input_formula))

library(neuralnet)              
mnist_model<-neuralnet(final_formula,
                       data=train_data_final,
                       hidden=c(50),
                       linear.output=FALSE,
                       err.fct="ce",
                       act.fct="logistic",
                       stepmax=1e6)                         
                   plot(mnist_model)       
                   