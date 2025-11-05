View(airquality)
df<-lm(Ozone~Temp,data=airquality)
df
summary(df)
?lm


#artık değerler
df$residuals
plot(as.numeric(df$residuals))
plot(df)
?mahalanobis
plot(airquality$Ozone,airquality$Temp)
air<-na.omit(airquality[c("Ozone","Temp")])
air.center=colMeans(air)
air.center
air.cov=cov(air)
distance=mahalanobis(air,center=air.center,cov=air.cov)
distance
cutoff<-qchisq(p=0.95,df=2)
cutoff
distance>cutoff
index<-which(distance>cutoff)
air_new<-air[-index,]
model2<-lm(Ozone~Temp,data=air_new)
View(model2)
summary(model2)
plot(model2)


air_new2<-na.omit(air_new[c("Ozone","Temp")])
air_new2.center=colMeans(air_new2)
air_new2.cov=cov(air_new2)
distance2=mahalanobis(air_new2,center=air_new2.center,cov=air_new2.cov)
trasehold<-qchisq(p=0.95,2)
index2<-which(distance2>trasehold)
airr<-air_new2[-index2,]
model3<-lm(Ozone ~Temp,data=airr)
plot(model3)
summary(model3)


model4<-lm(sqrt(Ozone)~sqrt(Temp),data=airr)
par(mfrow=c(2,2))
plot(model4)
dev.off()
plot(model4)

summary(model4)
model5<-lm(log(Ozone)~log(Temp),data=airr)
plot(model5)

summary(model5)
