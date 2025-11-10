data<-read.csv("C:\\Users\\damla\\OneDrive\\Belgeler\\GitHub\\R\\machine learning\\coklulineerregression\\Weather Test Data.csv")
View(data)
names(data)
df_albury<-data[ data$Location=="Albury",]
View(df_albury)
nrow(df_albury)

df<-df_albury[c("Humidity9am","MinTemp" ,"MaxTemp" ,
                "WindSpeed9am","Pressure9am","Temp9am")]
cor(na.omit(df))
pairs(na.omit(df))
library(mice)
md.pattern(df)
imputed<-mice(df,m=5)
names(df)
imputed$imp
df_alb_imp<-complete(imputed,3)
md.pattern(df_alb_imp)
df_alb_imp
