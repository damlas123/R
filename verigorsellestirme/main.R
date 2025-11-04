boxplot(mtcars[,c("drat","wt","qsec")],
        names=c("Drat","Wt degiskeni","Qsecond degiskeni"),
        col=c("orange","gray","cyan"))
boxplot(mtcars$mpg ~ mtcars$gear,
        main="Box plot",
        xlab="Vites De??erleri",
        ylab="MPG de??erleri",
        col=c("orange"),
              border="gray",
        pch=19,
        cex.axis=0.7,
        outline=T
              )


#heatmap grafi??i
mrcars_1<-as.matrix(mtcars)
heatmap(mrcars_1,scale="column")
install.packages("RColorBrewer")
library(RColorBrewer)
heatmap(mrcars_1,scale="column",Colv=NA,Rowv=NA,
        col=colorRampPalette(brewer.pal(9,"Blues"))(25))
