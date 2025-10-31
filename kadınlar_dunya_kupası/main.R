df<-read.csv("WomenFootballResults")
View(WomenFootballResults)
df<-read.csv(WomenFootballResults)
df <- read.csv("WomenFootballResults.csv")
getwd()
setwd("C:\\Users\\damla\\OneDrive\\Belgeler\\GitHub\\R\\kad??nlar_dunya_kupas??")
df
df$date<-as.Date(df$date)
df$date
names(df)
yenidf <- subset(df, 
                 date >= "1980-12-01" & 
                   date <= "2019-12-31" & 
                   home_team == "Hong Kong" & 
                   away_team == "Philippines",
                 select = c(home_team, away_team, home_score, away_score, date))
yenidf
