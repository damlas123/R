#f(x,y)=X2+4x+5y

toplama<-function(x,y){
  result=x+y
  return(result)
}

toplama(5,7)


f=function(){
  x=readline(prompt = 'enter first number')
  y=readline(prompt = 'enter second number')
  x<-as.numeric(x)
  y<-as.numeric(y)
  result=x+y
  return(result)
}


y=function(){
  a=readline(prompt = 'enter 1 for sum 2 for subs 3 for mult 4 for division')
  a=as.numeric(a)
  if(a==1){
    result=7+8
  }else if(a==2){
    result=7-8;
  }else if(a==3){
    result=7*8
  }else if(a==4){
    result=7/8
  }else{
    print('you entered wrong number!')
  }
  return(result)
}





a<-c(14,15,17,15,19)
yeni<-function(a){
  toplam=0;
  for(i in 1:length(a) ){
    a[i]=abs(a[i])
    a[i]=sqrt(a[i])*10
    
  }
  result=sum(a)
  return(result)
}
a<-rnorm(10)
yeni(a)


liste <- list('a' = c(7, 8, 9, 14), 'b' = c(7, 9, 5, 65))

fonk <- function(liste) {
  k <- c()
  y <- c()
  
  for (i in 1:length(liste)) {
    for (l in 1:length(liste[[i]])) {
      if (liste[[i]][l] > 5) {
        k <- c(k, liste[[i]][l])
      } else {
        y <- c(y, liste[[i]][l])
      }
    }
  }
  return(list(buyukler = k, kucukler = y))
}

fonk(liste)

install.packages("tidyverse")
library(tidyverse)
#data%>%select(v1)%>%filter(v1>5)




View(iris)
df<-iris%>%select(Sepal.Length,Sepal.Width)%>%slice(1:5)
df

#slice_min() ve slice_max() fonksiyonlar??

iris%>%slice_min(order_by = Sepal.Length,n=10)


iris%>%slice_max(order_by = Sepal.Length,n=10)

iris%>%slice_sample(n=10)

#rastegele de??erler alma 10 adet

iris%>%distinct(Species)
# unique de??erleri verir

iris%>%distinct(Species,keep_all=TRUE)



#arrange fonksiyonu
iris%>%arrange(Sepal.Width,Sepal.Length)

iris%>%arrange(desc(Sepal.Width),desc(Sepal.Length))

