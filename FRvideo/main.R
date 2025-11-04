getwd()
setwd("C:\\Users\\damla\\OneDrive\\Belgeler\\GitHub\\R\\FRvideo")
getwd()
list.files()
df<-read.csv("FRvideos.csv")
df
View(df)

names(df)
bir<-df%>%filter(views>3000000)
bir
View(bir)
iki<-df%>%filter(views>3000000)%>%group_by(channel_title,category_id)
uc<-df%>%filter(views>3000000)%>%group_by(channel_title,category_id)%>%summarise(ds<-mean(dislikes,na.rm=TRUE),
                                                                                 ls<-mean(likes,na.rm=TRUE),
                                                                                 vs<-mean(views,na.rm=TRUE))

View(mtcars)
table(mtcars$gear,mtcars$cyl)
