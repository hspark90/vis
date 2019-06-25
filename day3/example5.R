# incompleted code (연구 진행중)

setwd("C:/Users/USER/Dropbox/R-work/vis/day3")


if(!require(stringr)) install.packages("stringr");library(stringr)
if(!require(mapdata)) install.packages("mapdata");library(mapdata)
if(!require(maps)) install.packages("maps");library(maps)
if(!require(ggmap)) install.packages("ggmap");library(ggmap)
if(!require(gstat)) install.packages("gstat");library(gstat)
if(!require(sp)) install.packages("sp");library(sp)
if(!require(RCurl)) install.packages("RCurl");library(RCurl)
if(!require(e1071)) install.packages("e1071");library(e1071)
if(!require(randomForest)) install.packages("randomForest");library(randomForest)
if(!require(caret)) install.packages("caret");library(caret)

load(file="data/a.data1.rda") # 과거 해상사고 위험지수 부여
load(file="data/public_data2.rda") # 과거 해상사고 일자의 기상과, 관측소 위치


#기상관련, 기상비관련, 관측소 위치 지도#
a1.data <- a.data1[a.data1$type=="기타" & a.data1$weather != "양호" | a.data1$reason=="기상악화",]
a2.data <- a.data1[!(a.data1$type=="기타" & a.data1$weather != "양호" | a.data1$reason=="기상악화"),]

kor <- c(left = 124, bottom = 33, right = 132, top = 39)
hdf <- get_stamenmap(kor, zoom = 6, maptype = "toner-lite")

a<-ggmap(hdf) + geom_point(data=a2.data, aes(a2.data$lon, a2.data$lat), shape= 10,colour="tan", size=1) 
a2<-a+geom_point(data=a1.data, aes(a1.data$lon, a1.data$lat), shape= 16,colour="yellow", size=1) 
a3<-a2+geom_point(data=buoy.stat2, aes(buoy.stat2$lon, buoy.stat2$lat), shape= 12,colour="blue", size=1)
a4<-a3+geom_point(data=light.stat2, aes(light.stat2$lon, light.stat2$lat), shape= 16,colour="purple", size=1)
a5<-a4+geom_point(data=wave.stat2, aes(wave.stat2$lon, wave.stat2$lat), shape= 10,colour="red1", size=1)
a5


###해양기상부이-실시간###
url1 <- paste0("http://www.weather.go.kr/mini/marine/inner_marine_buoy.jsp")
line1 <- readLines(url1, encoding = "euc-kr")   #HTML source code 불러오기
line2<-line1[133:149]

line2 <- gsub("</td>|\t", "", line2) 
line2 <- gsub("&nbsp;", "", line2) 

buoy.real <- matrix(rep(NA,17*12),ncol=12)

for(i in 1:17){
  list.locate<-str_locate_all(line2[i],"<td>")
  buoy.real[i,1] <- substr(line2[i],(list.locate[[1]][1,2]+1),(list.locate[[1]][2,1]-1))
  buoy.real[i,2] <- substr(line2[i],(list.locate[[1]][2,2]+1),(list.locate[[1]][3,1]-1))
  buoy.real[i,3] <- substr(line2[i],(list.locate[[1]][3,2]+1),(list.locate[[1]][4,1]-1))
  buoy.real[i,4] <- substr(line2[i],(list.locate[[1]][4,2]+1),(list.locate[[1]][5,1]-1))
  buoy.real[i,5] <- substr(line2[i],(list.locate[[1]][5,2]+1),(list.locate[[1]][6,1]-1))
  buoy.real[i,6] <- substr(line2[i],(list.locate[[1]][6,2]+1),(list.locate[[1]][7,1]-1))
  buoy.real[i,7] <- substr(line2[i],(list.locate[[1]][7,2]+1),(list.locate[[1]][8,1]-1))
  buoy.real[i,8] <- substr(line2[i],(list.locate[[1]][8,2]+1),(list.locate[[1]][9,1]-1))
  buoy.real[i,9] <- substr(line2[i],(list.locate[[1]][9,2]+1),(list.locate[[1]][10,1]-1))
  buoy.real[i,10] <- substr(line2[i],(list.locate[[1]][10,2]+1),(list.locate[[1]][11,1]-1))
  buoy.real[i,11] <- substr(line2[i],(list.locate[[1]][11,2]+1),(list.locate[[1]][12,1]-1))
  buoy.real[i,12] <- substr(line2[i],(list.locate[[1]][12,2]+1),(list.locate[[1]][13,1]-1))
}

buoy.real

###파고부이-실시간###
url1<-paste0("http://www.weather.go.kr/mini/marine/marine_buoy_cosmos.jsp")
raw = iconv(readLines(url1), from="EUC-KR", to='UTF-8')
location <- raw[which(str_detect(raw, "<td>"))]
raw2<-location[1:168]
raw2<-gsub("\t\t\t\t\t\t\t\t\t\t<td>", "", raw2) 
raw2<-gsub("</td>", "", raw2) 
raw2
d<-data.frame(seq(1,163,6),seq(6,168,6))

for(i in 1:nrow(d))
  assign(paste0('a',i),raw2[d[i,1]:d[i,2]])

raw2<-rbind(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28)
raw2

###관측소 위치####
buoy.stat <- read.csv("data/buyeo_stnInfo.csv",header=T)
mbuoy.stat2 <- buoy.stat[,c(4,6,7)]
names(mbuoy.stat2) <-c("region","lat","lon")

light.stat <- read.csv("data/lighthouse_stnInfo.csv",header=T)
mlight.stat2 <- light.stat[,c(4,6,7)]
names(mlight.stat2) <-c("region","lat","lon")

wave.stat <- read.csv("data/wave_stnInfo.csv",header=T)
wave.stat1 <- wave.stat[is.na(wave.stat$종료일),]
mwave.stat2 <- wave.stat1[,c(4,6,7)]
names(mwave.stat2) <-c("region","lat","lon")

####격자 데이터###
lon.1 <- seq(124,132,0.2)
lat.1 <- seq(32,38.5,0.2)

lonlat<-expand.grid(lon.1,lat.1)
u <- map.where(database="worldHires", x=lonlat$Var1, y=lonlat$Var2)
a <- rep(0, nrow(lonlat))
a[u %in% c("South Korea","North Korea")] <- 1
lonlat2 <- lonlat[a==0,]
#plot(lonlat2, pch=16, col=rep(2:5, each=350))
colnames(lonlat2)<-c("lon","lat")
coordinates(lonlat2) <- ~lon+lat
plot(lonlat2)

#IDW로 실시간 기상예측#
lonlat2$ws<-idw(ws~1, fdata[complete.cases(fdata$ws),], newdata=lonlat2)$var1.pred
lonlat2$gust<-idw(gust~1, fdata[complete.cases(fdata$gust),], newdata=lonlat2)$var1.pred
lonlat2$temp<-idw(temp~1, fdata[complete.cases(fdata$temp),], newdata=lonlat2)$var1.pred
lonlat2$SST<-idw(SST~1, fdata[complete.cases(fdata$SST),], newdata=lonlat2)$var1.pred
lonlat2$max_wave<-idw(max_wave~1, fdata[complete.cases(fdata$max_wave),], newdata=lonlat2)$var1.pred
lonlat2$sig_wave<-idw(sig_wave~1, fdata[complete.cases(fdata$sig_wave),], newdata=lonlat2)$var1.pred
lonlat2$pri_wave<-idw(pri_wave~1, fdata[complete.cases(fdata$pri_wave),], newdata=lonlat2)$var1.pred

lonlat3<-as.data.frame(lonlat2)

# https://www.data.go.kr/dataset/3043630/fileData.do

load(file="data/a.temp2.rda") #a.temp2
load(file="data/a.data1.rda")
head(a.temp) # 과거 사고 일자의 기상을 idw 이용해서 예측한 자료
head(a.data1) # 과거 사고의 위험지수 표시

t.data <- merge(a.data1, a.temp, by="date")
head(t.data)

table(t.data$score) # 기상관련해서 위험하면 1 아니면 0으로 위험지수 재설정
t.data[t.data$score==3,"score"]=1
t.data[t.data$score==2,"score"]=1


t.data1 <- t.data[t.data$reason.x != "정비불량" & t.data$reason.x != "화기취급부주의" &
                    t.data$reason.x != "연료고갈" &t.data$reason.x != "적재불량" &
                    t.data$reason.x != "운항부주의" ,] 

t.data2<-t.data1[,c(-1:-16,-18:-29)]
head(t.data2)

set.seed(2352135)
s1 <- sample(1:nrow(t.data2),nrow(t.data2)*0.7)

train.data <- t.data2[s1,]
test.data <- t.data2[-s1,]


set.seed(67365437)
rf <- randomForest(score ~ ., data=train.data, importance=TRUE,
                   proximity=TRUE, ntree=1000)
print(rf)
## Look at variable importance:
round(importance(rf), 2)
varImpPlot(rf)

pred1<-as.numeric(round(predict(rf, newdata=train.data),0))
pred2<-as.numeric(round(predict(rf, newdata=test.data),0))

confusionMatrix(as.factor(train.data$score),as.factor(pred1))
confusionMatrix(as.factor(test.data$score),as.factor(pred2))

