apply(iris[1:4], MARGIN=1,FUN=mean)#sat??rlar baz??nda
View(iris)
df<-sd(as.numeric(iris[1,1:4]))
df
apply(iris[1:4], MARGIN=2,FUN=mean)#s??tunlar baz??nda

lapply(iris,FUN=mean)#listeler baz??nda s??tunlar baz??nda yapar
l<-list('a'=c(13,45,78,94),'b'=c(54,96,32,76),'c'=c(11,22,33,44))
lapply(l,FUN=mean)
lapply(l,FUN=sd)
lapply(l,FUN=var)
