# http://www.newsa.co.kr/news/articleView.html?idxno=175599#09Xb

y1 <- c(41.8, 37.1, 37.6, 40.2, 36.6, 36.1, 32, 35.1, 40.3, 29.9, 30.3)

barplot(y1)

barplot(y1, names.arg = c("서울","부산","대구", "인천","광주","울산","세종","경기","강원","충북","충남"))

barplot(y1, names.arg = c("서울","부산","대구", "인천","광주","울산","세종","경기","강원","충북","충남"), ylim=c(0,60))

col <- ifelse(y1>35,"orange","blue")

barplot(y1, names.arg = c("서울","부산","대구", "인천","광주","울산","세종","경기","강원","충북","충남"), ylim=c(0,60), col=col)

barplot(y1, names.arg = c("서울","부산","대구", "인천","광주","울산","세종","경기","강원","충북","충남"),
        ylim=c(0,60), col=col, ylab="평균 출근 소요시간")

bar1<-barplot(y1, names.arg = c("서울","부산","대구", "인천","광주","울산","세종","경기","강원","충북","충남"),
              ylim=c(0,60), col=col, ylab="평균 출근 소요시간")

text(bar1,y1+1, labels=y1)

y2<-c(54.6, 48.1, 50.5, 51.8, 48.2, 47, 43.5, 43.9, 51.4, 39.4, 40.2)
col2 <- ifelse(y2>42, "red","gold")
bar1<-barplot(y1, names.arg = c("서울","부산","대구", "인천","광주","울산","세종","경기","강원","충북","충남"),
              ylim=c(0,60), col=col, ylab="평균 출근 소요시간", main="출퇴근 시간 그림")
text(bar1,y1+1, labels=y1)
lines(bar1, y2, type="o", pch=16, cex=3, col=col2)
text(bar1, y2+3, labels=y2)

# https://news.joins.com/article/21140868 
# 지역별 인구 증감 현황 


# 공공데이터 https://data.go.kr/visual/content/661?filtered=true

data <- read.csv(choose.files()) # bmi.csv
head(data)

data1 <- data[data$gender=="합계",]
unique(data1$age)
data2 <- as.matrix(data1[,3:7])
row.names(data2)<-unique(data1$age)
data2
data3 <- t(data2)
data3

barplot(data2, beside=TRUE, legend.text=row.names(data2))
barplot(data3, beside=TRUE, legend.text=row.names(data3))