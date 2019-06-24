setwd('C:/Users/USER/Dropbox/R-work/vis/day2/practice')

#csv 파일 불러오기
d<- read.csv('실업률.csv', stringsAsFactors=F)
d<- d[,-c(1,2)]
d

#행, 열 이름 제거
colnames(d)<-NULL
rownames(d)<-NULL
d

#행이름 지정
year <- paste0(2007:2018,'년')
d<- cbind(year,d)
colnames(d) <- c('연도',paste0(seq(20,60,by=10),'대'))
d

#연도기준 melt하기
if(!require(reshape2)) install.packages('reshape2');library(reshape2) 
if(!require(ggplot2))install.packages('ggplot2'); library(ggplot2)

d1<- melt(id=1,data=d)
head(d1)

colnames(d1) <- c('연도','연령별','실업률')
head(d1)

#geom_line 그리기

ggplot(data=d1, aes(x=연도, y=실업률, group=연령별)) + geom_line()

#연령별 색깔 구분
#선 굵기 변경 : size

ggplot(data=d1, aes(x=연도, y=실업률, group=연령별, color= 연령별))+
  geom_line(size=1.2)

#배경 설정 : them_bw()
#점 추가 : geom_point
#y 범위 설정 : ylim
#y축 이름 설정 : ylab
#제목 설정 : ggtitle()
#ggtitle 관련설정 : theme(plot.title=element_text())

ggplot(data=d1, aes(x=연도, y=실업률, group=연령별, color=연령별))+
  geom_line(size=1.2) + theme_bw() + geom_point(size=2) +
  ylim(0,10) + ylab("실업률(%)") +
  xlab("") + ggtitle("연도별 실업률") + 
  theme(plot.title=element_text(size=25))

# 두번째 그림

data<-read.csv('temp_4.csv')  #temp_4.csv
head(data)
str(data)

#데이터 조작
#일자 column 추가
#factor(level, order): order를 통해 factor의 순서 부여
D <- paste0(1:30,"일")
data2 <- data.frame("일"=D,data)
data2$일<-factor(data2$일, levels=D, order=T)
head(data2)
str(data2)

#ggplot을 그리기 위해 melt사용
#최고기온과 최저기온이 열로 들어간다.
library(reshape2)
m_data2 <- melt(data2, id.var=c("일"))
head(m_data2)

colnames(m_data2) <- c("일","분류","온도")
head(m_data2)

#ggplot_area()그리기
#alpha : 투명도 조절
#position=stack : 누적
library(ggplot2)

ggplot(m_data2, aes(x=일, y=온도, fill=분류, group=분류)) +
  geom_area(colour=NA, alpha=0.5) 


ggplot(m_data2, aes(x=일, y=온도, fill=분류, group=분류)) +
  geom_area(colour=NA, alpha=0.5) + 
  scale_fill_brewer(palette = "Blues") +
  geom_line(position = "stack", size=0.3) +
  ggtitle("4월 최저, 최고기온 area plot")

#### 세번째 그림

data<-read.csv('temp_5.csv')  #temp_5.csv
head(data)
str(data)

#데이터 조작
#일자 column 추가
#factor(level, order): order를 통해 factor의 순서 부여
D <- paste0(1:30,"일")
data2 <- data.frame("일"=D,data)
data2$일<-factor(data2$일, levels=D, order=T)
head(data2)
str(data2)

#최저기온의 전날과의 차이 구하기
#diff함수 사용
if(!require(dplyr)) install.packages("dplyr"); library(dplyr)
data2<-arrange(data2, 일) #정렬하기

data2_diff<-diff(data2$최저기온, lag=1)
data2_diff

day <- data2[-1,1] #첫번째 행을 제외한 첫번째 열 선택
day

data3 <- data.frame(day, diff=data2_diff)
head(data3)

#plus_minus 열 만들기(0보다 크면 plut, 작으면 minus)
data3$plus_minus <- ifelse(data3$diff >= 0, "plus", "minus")
head(data3)

#ggplot2 그리기
#geom_bar(stat, position은 필수요소임)
ggplot(data3, aes(x=day, y=diff, fill=plus_minus)) +
  geom_bar(stat="identity", position = "identity", width = 0.2)

#scale_fill_manual을 통해 색깔 설정
#guide=F: 범례 제거
ggplot(data3, aes(x=day, y=diff, fill=plus_minus)) +
  geom_bar(stat="identity", position = "identity", width = 0.2) +
  scale_fill_manual(values=c("blue","red"), guide=F)

#ylab : y축 이름 설정
#xlab : x축 이름 설정
ggplot(data3, aes(x=day, y=diff, fill=plus_minus)) +
  geom_bar(stat="identity", position = "identity", width = 0.2) +
  scale_fill_manual(values=c("blue","red"), guide=F) +
  ylab("이전 날과의 온도차") +
  xlab("2007년 4월")

### 네번째 그림

# 패키지 로딩
if(!require(dplyr)) install.packages('dplyr'); library(dplyr)
if(!require(tidyr)) install.packages('tidyr'); library(tidyr)
library(ggplot2)

df_file <- read.csv('2012년 요일별 시간대별 교통사고.csv') #2012년 요일별 시간대별 교통사고.csv

# 변수이름변경
names(df_file) <- c('date', 'type', 'h2', 'h4', 'h6', 'h8', 'h10', 'h12', 'h14', 'h16',
                    'h18', 'h20', 'h22', 'h24')

# gather(데이터, 키, 값, 제외컬럼 목록)
df_long <- gather(df_file, hour, count, -date, -type)

# 요일별, 시간대별 레벨을 조정해야 한다. 그래프 그릴때 순서적으로 보여진다.
# ordered=TRUE 옵션을 사용한다.
df_long$date <- factor(df_long$date, levels=c("일", "월", "화", "수", "목", "금", "토"), ordered=TRUE)
df_long$hour <- factor(df_long$hour, levels=c("h2", "h4", "h6", "h8", "h10", "h12", "h14", "h16", "h18", "h20", "h22", "h24"), ordered=TRUE)

g <- ggplot(df_long, aes(x = date, y = count, colour=type)) + geom_point() +
  theme(text = element_text(family='나눔명조'))
g

df_wounded <- filter(df_long, type == "부상자수")
head(df_wounded)

# geom_line 사용 시 date를 그룹값으로 설정한다.
g <- ggplot(df_wounded, aes(x = hour, y = count, colour=date)) + 
  geom_point() + geom_line(aes(group=date)) +
  theme(text = element_text(family="나눔명조"))
g