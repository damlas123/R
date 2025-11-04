5==5
if(5==5){
  print('dogru')
}


if(5>=1){
  print('Dogru')
}else{
  print('false')
}







for(i in 1:10){
  print(5)
}



x<-c(14,15,16,17)
for(i in x){
  print(i)
}


for(i in 1:length(x)){
  print(x[i])
}


for(i in 1: nrow(iris)){
  print(iris$Species[i])
  
}
pas<-""
paste(5,'deneme',6)
y<-c('a','b','c','d')
for(u in 1:length(y)){
  pas=paste(pas,'-',y[u])
}
pas

z<-c(74,85,96,14,25)
for(i in z){
  if(i%%2==0){
    d<-paste(i,'is even number')
  }
  else{
    d<-paste(i,"is pld number")
  }
  print(d)
}





