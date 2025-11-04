getwd()
setwd("C://Users//damla//OneDrive//Belgeler//GitHub//R//satranc")
getwd()
list.files()
nrow(chess)
chess<-read.csv("top_women_chess_players_aug_2020.csv")
View(chess)
chess<-na.omit
plot(x=chess$Standard_Rating,y=chess$Rapid_rating,
     pch=19,
     main="Satranc",
     xlab="Standard Rating",
     ylab="Rapid Rating",
     bty="L")

abline(lm(chess$Rapid_rating~chess$Standard_Rating),cex=2,col="darkblue")     

legend(x="bottomright",legend=levels(chess$Title),pch=19,
       col=1:length(levels(chess$Title)))
install.packages("Rlab")
library(Rlab)
?dbern
#ba??ar??l?? olunma olas??l?????? 0.6
dbern(x=0,prob=0.6)
  