data<-read.csv("C:\\Users\\damla\\OneDrive\\Belgeler\\GitHub\\R\\PROJE\\SVM\\data.csv")
View(data)
data$id<-NULL
data$X<-NULL
#varNames<-name(data)
#data<-data[,which(varNames=='X' | varNames=='id')]
#bu iki sat??r yukarda null yapt??????m gibi o 2 s??tunu ????kar??r 
str(data) #s??tunlar??n veri t??r??n?? verir


names(data)
selectedVars<-c( "diagnosis",              
                 "radius_mean",            
                 "texture_mean",           
                 "perimeter_mean",         
                 "area_mean",              
                 "smoothness_mean",        
                 "compactness_mean",       
                 "concavity_mean",         
                 "concave.points_mean",    
                 "symmetry_mean",          
                 "fractal_dimension_mean")

modeldataselected<-data[,selectedVars]
View(modeldataselected)

#g??rselle??tirmeler

plot(modeldataselected$radius_mean,modeldataselected$texture_mean,pch=19,
     col=c('blue','orange')[as.factor(modeldataselected$diagnosis)])

plot(modeldataselected$area_mean,modeldataselected$perimeter_mean,pch=19,
     col=c('blue','orange')[as.factor(modeldataselected$diagnosis)])

plot(modeldataselected$smoothness_mean,modeldataselected$compactness_mean,pch=19,
     col=c('blue','orange')[as.factor(modeldataselected$diagnosis)])


library(e1071)

?svm

###Diagnosis factore ??evirme
modeldataselected$diagnosis<-as.factor(modeldataselected$diagnosis)

set.seed(8)
train<-sample(1:nrow(modeldataselected),size=0.8*nrow(modeldataselected))
trainset<-modeldataselected[train,]
testset<-modeldataselected[-train,]

table(trainset$diagnosis)
table(testset$diagnosis)
head(trainset)


#model olu??turma 

modellinear<-svm(diagnosis~.,data=trainset,
            kernel='linear')
modelradial<-svm(diagnosis~.,data=trainset,kernel='radial')

modellinear
modelradial


modelradial$coefs#support vekt??rleri oluyor
modellinear$coefs


predictlinear<-predict(modellinear,testset)
predictradial<-predict(modelradial,testset)
confusionlinear<-confusionMatrix(predictlinear,testset$diagnosis)
confusionradial<-confusionMatrix(predictradial,testset$diagnosis)
confusionlinear
confusionradial

confusionlinear2<-confusionMatrix(predictlinear,testset$diagnosis,positive = 'M')
confusionradial2<-confusionMatrix(predictradial,testset$diagnosis,positive = 'M',mode="pre")

confusionlinear2
confusionradial2

#g??rselle??tirme 


plot(modellinear,trainset,radius_mean~texture_mean)
plot(modellinear,testset,perimeter_mean~area_mean)


plot(modelradial,trainset,radius_mean~texture_mean)
plot(modelradial,testset,perimeter_mean~area_mean)

#tuning i??lemi

modellineartuning<-tune(svm,diagnosis~.,data=trainset,
                        kernel="linear",
                        ranges=list(gamma=2^(-2:2),cost=2^(-4:2)),
                        tunecontrol=tune.control(cross=5))



modelradialtuning<-tune(svm,diagnosis~.,data=trainset,
                        kernel="radial",
                        ranges=list(gamma=2^(-2:2),cost=2^(-4:2)),
                        tunecontrol=tune.control(cross=5))

modellineartuning
modelradialtuning
#Yani bunlar e??itilmi?? modelin kendisi de??il, sadece tuning i??leminin sonu??lar??n?? tutan bir obje.
#Tuned modeli kullanarak tahmin yapabilmen i??in i??indeki en iyi modeli (best.model) ????karman gerekiyor.
predictlinearcv<-predict(modellineartuning$best.model,testset)
predictradialcv<-predict(modelradialtuning$best.model,testset)


confusionlinearcv<-confusionMatrix(predictlinearcv,testset$diagnosis)
confusionradialcv<-confusionMatrix(predictradialcv,testset$diagnosis)
confusionlinearcv
confusionradialcv
