data1 <- read.csv(choose.files()) #data.csv
data1

str(data1)

a <- cbind('전국평균',mean(data1$X2009),mean(data1$X2012),mean(data1$X2016))
colnames(a)<-c('area','X2009','X2012','X2016')
rownames(a)<-c('전국평균')

data2 <- rbind(data1,a)

data2$X2009<-as.numeric(data2$X2009)
data2$X2012<-as.numeric(data2$X2012)
data2$X2016<-as.numeric(data2$X2016)

cols <- ifelse(data2$area == "전국평균", "blue", "gray")

par(mfrow=c(1,3))

bar1 <- barplot(data2$X2009, horiz = T, names.arg = data2$area, las=1, xlim=c(0,60), col = cols, xlab="2009년")
text(data2$X2009+4, bar1, data2$X2009)
abline(v=22.17, col='red')

bar2 <- barplot(data2$X2012, horiz = T, names.arg = data2$area, las=1, xlim=c(0,60), col = cols, xlab="20012년")
text(data2$X2012+4, bar2, data2$X2012)
abline(v=24.94, col='red')

bar3 <- barplot(data2$X2016, horiz = T, names.arg = data2$area, las=1, xlim=c(0,60), col = cols, xlab="2016년")
text(data2$X2016+4, bar3, data2$X2016)
abline(v=21.07, col='red')
