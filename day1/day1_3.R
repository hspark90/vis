# 3장 데이터 시각화 함수

# 3.1.2 벡터라이제이션 : 벡터의 연산 과정인 입력, 연산, 출력에서 벡터를 원소 하나씩 반복적으로 처리하지 않고 통째로 처리하는 기법 

# 3.2 graphics 패키지

# 3.2.1 barplot() 함수

## https://www.statmethods.net/graphs/bar.html

# 막대그림
counts <- table(mtcars$gear)
barplot(counts, main="Car Distribution", xlab="Number of Gears") 

# 수평 막대그림
counts <- table(mtcars$gear)
barplot(counts, main="Car Distribution", horiz=TRUE,
        names.arg=c("3 Gears", "4 Gears", "5 Gears"))

# 벡터가 아닌 행렬자료는 비중까지 그려짐
counts <- table(mtcars$vs, mtcars$gear)
barplot(counts, main="Car Distribution by Gears and VS",
        xlab="Number of Gears", col=c("darkblue","red"),
        legend = rownames(counts)) 

# beside 옵션을 주면 비중이 아닌 집단 막대그림
counts <- table(mtcars$vs, mtcars$gear)
barplot(counts, main="Car Distribution by Gears and VS",
        xlab="Number of Gears", col=c("darkblue","red"),
        legend = rownames(counts), beside=TRUE)

counts <- table(mtcars$gear)
barplot(counts, main="Car Distribution", horiz=TRUE, names.arg=c("3 Gears", "4 Gears", "5   Gears"), cex.names=0.8)

par(las=2) # make label text perpendicular to axis
barplot(counts, main="Car Distribution", horiz=TRUE, names.arg=c("3 Gears", "4 Gears", "5   Gears"), cex.names=0.8)

par(las=1)

# 막대그림의 옵셥들
set.seed(1)
bar.x <- round(runif(12) * 50)
bar.x
barplot(bar.x) # 막대그림은 빈도 자료의 벡터를 사용하여 그림
title(main = "Vector Barplot")

barplot(-bar.x) # 음수로 줄 경우 상하가 반전
title(main = "Vector Barplot(Negative Value)")

set.seed(2);bar.y <- matrix(bar.x, ncol = 3, byrow = T)
bar.y
barplot(bar.y, main = "Matrix Barplot")

barplot(bar.y, beside = TRUE, main = "Matrix Barplot by beside = TRUE")

bar.width <- rep(1:3, 4)
bar.width

barplot(bar.x, width = bar.width) #막대의 폭 변경
title(main = "Vector Barplot by width 1:3")

barplot(bar.x, space = 2) # 막대 그림 사이의 공간
title(main = "Vector Barplot by space = 2")

barplot(bar.y, beside = TRUE, space = c(0.5, 2)) # 그룹별 공간을 준 그림 
title(main="Vector Barplot by space = c(0.5, 2)")

rownames(bar.y) <- paste("row", 1:4)
colnames(bar.y) <- paste("col", 1:3)
bar.y #행렬에 이름이 있으면...

barplot(bar.y)
title(main = "Matrix Barplot using default names.arg")

barplot(bar.x, names.arg = letters[1:length(bar.x)])
title(main = "Vector Barplot using names.arg")

barplot(bar.x, legend.text = letters[1:length(bar.x)])
title(main = "Vector Barplot using legend.text")

barplot(bar.y, legend.text = T)
title(main = "Matrix Barplot using legend.text = T")

barplot(bar.x, horiz = T, density = 5)
title(main = "Vector Barplot by horiz = T, density = 5")

barplot(bar.x, density = 15, angle = 135)
title(main = "Vector Barplot by density = 15, angle = 135")

barplot(bar.x, col = rainbow(length(bar.x)))
title(main = "Vector Barplot by rainbow color")

barplot(bar.y, border = "red",
          col = c("lightblue", "mistyrose","lightcyan", "lavender"))
title(main = "Matrix Barplot by col, border")

barplot(bar.x, axes = FALSE)
title(main = "Vector Barplot by axes = FALSE")

barplot(bar.y, cex.axis = 1.8, ylim = c(0, 90))
title(main = "Matrix Barplot by cex.axis,ylim")

barplot(bar.y, axisnames = T, cex.names = 1.8, axis.lty = 2)
title(main = "Matrix Barplot by cex.names, axis.lty")


# 3.2.2 boxplot() 함수
# https://www.statmethods.net/graphs/boxplot.html

# Boxplot of MPG by Car Cylinders 
head(mtcars)
str(mtcars)

boxplot(mpg~cyl,data=mtcars, main="Car Milage Data", 
        xlab="Number of Cylinders", ylab="Miles Per Gallon") 


# Notched Boxplot of Tooth Growth Against 2 Crossed Factors
# boxes colored for ease of interpretation 
str(ToothGrowth)
head(ToothGrowth)
boxplot(len~supp*dose, data=ToothGrowth, notch=TRUE, 
        col=(c("gold","darkgreen")),
        main="Tooth Growth", xlab="Suppliment and Dose") 


# Violin Plots
if(!require(vioplot)) install.packages("vioplot"); library(vioplot)
x1 <- mtcars$mpg[mtcars$cyl==4]
x2 <- mtcars$mpg[mtcars$cyl==6]
x3 <- mtcars$mpg[mtcars$cyl==8]
vioplot(x1, x2, x3, names=c("4 cyl", "6 cyl", "8 cyl"), col="gold")
title("Violin Plots of Miles Per Gallon")


# Bagplot - A 2D Boxplot Extension 
# Violin Plots
# Example of a Bagplot
if(!require(aplpack)) install.packages("aplpack"); library(aplpack)
bagplot(mtcars$wt,mtcars$mpg, 
        xlab="Car Weight", ylab="Miles Per Gallon",
        main="Bagplot Example") 


# 상자그림의 옵션
set.seed(1)
norm1 <- round(rnorm(100, 3, 2), digits = 2)
set.seed(2)
norm2 <- round(rnorm(100, 3, 3), digits = 2)

boxplot(norm1, main="boxplot of one vector")

boxplot(norm1, norm2, main="boxplot of two vectors")

# 리스트로 저장된 자료도 상자 그림으로 그려짐
list1 = list(data1 = norm1, data2 = norm2, data3 = rnorm(100, 7, 4))
list1
boxplot(list1)
title("boxplot of simple list")

InsectSprays
dim(InsectSprays)
unique(InsectSprays$spray)

boxplot(count ~ spray, data = InsectSprays, col = "lightgray")
title("boxplot of dataframe by formula")

head(ToothGrowth)
boxplot(len ~ dose, data = ToothGrowth, main="len ~ dose")

boxplot(len ~ supp, data = ToothGrowth, main="len ~ supp")

boxplot(len ~ dose + supp, data = ToothGrowth, main="len ~ dose + supp")

boxplot(len ~ supp == "VC", data = ToothGrowth) #원하는 자료만 선택
title("len ~ supp == \"VC\"")

boxplot(len ~ dose, data = ToothGrowth, subset = supp == "VC") # subset 옵션 사용 가능
title("len ~ dose, subset = supp == \"VC\"")

boxplot(len[supp == "VC"] ~ dose[supp == "VC"], data = ToothGrowth)
title("len[supp == \"VC\"] ~ dose[supp == \"VC\"]")


set.seed(3)
z <- round(rnorm(50) * 10)
summary(z)
z[50] <- 40       # 50번째 데이터를 40으로 치환하여 이상치를 만듦
summary(z)
boxplot(z)
title(main="range = default(1.5)")

boxplot(z, range = 0) # 이상치 없이 최대 최소 모두 그리기
title(main="range = 0")

boxplot(z, range = 1.0) # IQR 범위까지 상자 그리기기
title(main="range = 1.0")

boxplot(z, range = 2.0) # IQR * 2 범위까지 상자 그리기
title(main="range = 2.0")


x1 <- runif(20)
x2 <- runif(20)
x3 <- runif(20)
x4 <- runif(20)
x5 <- runif(20)
x <- list(x1, x2, x3, x4, x5)

y1 <- runif(10)
y2 <- runif(40)
y3 <- runif(90)
y4 <- runif(160)
y <- list(y1, y2, y3, y4)

boxplot(x)
title(main = "default")
boxplot(x, width = 1:5)
title(main = "width = 1:5")

str(y)
boxplot(y, varwidth = T)
title(main = "varwidth = T")

boxplot(y, varwidth = T, width = 4:1)
title(main = "varwidth = T & width = 4:1")

boxplot(y)
title(main = "notch = default(FALSE)")
boxplot(y, notch = T, main = "notch = TRUE")
boxplot(z, main = "outline = default(TRUE)")
boxplot(z, outline = F, main = "outline = FALSE")

# names 인수를 사용할 경우
xname <- c("x1", "x2", "x3", "x4", "x5")
boxplot(x, names = xname)
title(main = "using names argument")

# names attributes를 이용할 경우
names(x) <- c("x1", "x2", "x3", "x4", "x5")
boxplot(x)
title(main = "using names attributes")
boxplot(x, boxwex = 0.3)
title(main = "boxwex = 1")
boxplot(x, staplewex = 2)
title(main = "staplewex = 2")

boxplot(x, plot = FALSE)

boxplot(z, plot = FALSE)

boxplot(x, border = "magenta", col = c("lightblue", "mistyrose", "lightcyan", "lavender"))
title(main = "use border, col")

boxplot(x, horizontal = TRUE)
title(main = "horizontal = TRUE")

# at을 통해 원하는 위치에 상자그림을 그릴 수 있음
boxplot(len ~ dose, data = ToothGrowth, boxwex = 0.25, at = 1:3 - 0.2,
          subset = supp == "VC", col = "yellow", main = "Guinea Pigs' Tooth Growth",
          xlab = "Vitamin C dose mg", ylab = "tooth length", ylim = c(0, 35))

boxplot(len ~ dose, data = ToothGrowth, add = TRUE, boxwex = 0.25, at = 1:3 + 0.2,
          subset = supp == "OJ", col = "orange")

legend(2, 9, c("Ascorbic acid", "Orange juice"), fill = c("yellow", "orange"))

# 참고로 알아두면 좋은 옵션들
boxplot(x, log = "y", main = "log = \"y\"")
boxplot(x, log = "x", main = "log = \"x\"")

boxplot(x)
boxplot(y, add = TRUE)
title(main = "add = TRUE(y is added to x)")

boxplot(y, staplelty = 3)
title(main = "staplelty = 3")

boxplot(z, outpch = 2)
title(main = "outpch = 2")


# 3.2.3 dotchart() 함수
# https://www.statmethods.net/graphs/dot.html

# Simple Dotplot
dotchart(mtcars$mpg,labels=row.names(mtcars),cex=.7,
         main="Gas Milage for Car Models", 
         xlab="Miles Per Gallon")


# Dotplot: Grouped Sorted and Colored
# Sort by mpg, group and color by cylinder 
x <- mtcars[order(mtcars$mpg),] # sort by mpg
x$cyl <- factor(x$cyl) # it must be a factor
x$color[x$cyl==4] <- "red"
x$color[x$cyl==6] <- "blue"
x$color[x$cyl==8] <- "darkgreen" 
dotchart(x$mpg,labels=row.names(x),cex=.7,groups= x$cyl,
         main="Gas Milage for Car Models\ngrouped by cylinder",
         xlab="Miles Per Gallon", gcolor="black", color=x$color) 


# dotchart의 다양한 옵션
month <- matrix(1:12, ncol = 3)
rownames(month) <- paste("Row", 1:4)
colnames(month) <- paste("Col", 1:3)
month
# (1) 벡터
dotchart(as.vector(month), label = month.abb)
title(main = "x is a vector")

# (2) 행렬
dotchart(month)
title(main = "x is a matrix")

# (3) group
quarter.name <- c("1QT", "2QT", "3QT", "4QT")
quarter <- factor(row(month), label = quarter.name)
quarter
dotchart(month, groups = quarter)
title(main = "groups = quarter")

# (4) groups, labels
name <- c("1st", "2nd", "3rd")
month
dotchart(month, groups = quarter, labels = name)
title(main = "groups = quarter, labels = name")

dotchart(month, group = quarter, labels = month.abb)
title(main = "group=quarter, labels=month.abb")
gmean <- tapply(month, quarter, mean)
gmean
dotchart(month, group = quarter, labels = month.abb, gdata = gmean)
title(main = "group=quarter, labels=month.abbngdata=gmean")

dotchart(month, labels = month.abb, main = "default cex")
dotchart(month, labels = month.abb, cex = 1.1, main = "cex = 1.1")
dotchart(month, labels = month.abb, pch = 2, main = "pch = 2")
dotchart(month, labels = month.abb, groups = quarter, pch = 2, gpch = 5, gdata = gmean)
title(main = "pch = 2, gpch = 5")

dotchart(month, cex = 1.1, bg = "red", main = "bg = \"red\"")

dotchart(month, cex = 1.1, bg = "red", color = "blue")
title(main = "bg = \"red\", color = \"blue\"")

dotchart(month, cex = 1.1, color = "red", gcolor = "blue", groups = quarter,
           gdata = gmean)

title(main = "color = \"red\", gcolor = \"blue\"")
dotchart(month, cex = 1.1, lcolor = "red", gcolor = "blue", groups = quarter,
           gdata = gmean)
title(main = "lcolor = \"red\", gcolor = \"blue\"")

VADeaths
dotchart(VADeaths)
title(main = "Death Rates in Virginian(Population group)")
dotchart(t(VADeaths), xlim = c(0, 100))
title(main = "Death Rates in Virginian(Age group)")

# 3.2.4 hist() 함수
# https://www.statmethods.net/graphs/density.html

# Simple Histogram
hist(mtcars$mpg)

# Colored Histogram with Different Number of Bins
hist(mtcars$mpg, breaks=12, col="red") 

# Add a Normal Curve 
x <- mtcars$mpg 
h<-hist(x, breaks=10, col="red", xlab="Miles Per Gallon", 
        main="Histogram with Normal Curve") 
xfit<-seq(min(x),max(x),length=40) 
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="blue", lwd=2) 

# Kernel Density Plot
d <- density(mtcars$mpg) # returns the density data 
plot(d) # plots the results 

# Filled Density Plot
d <- density(mtcars$mpg)
plot(d, main="Kernel Density of Miles Per Gallon")
polygon(d, col="red", border="blue") 

# Compare MPG distributions for cars with 
#4,6, or 8 cylinders
if(!require(sm)) install.packages("sm"); library(sm)
attach(mtcars)

# create value labels 
cyl.f <- factor(cyl, levels= c(4,6,8),
                labels = c("4 cylinder", "6 cylinder", "8 cylinder")) 

# plot densities 
sm.density.compare(mpg, cyl, xlab="Miles Per Gallon")
title(main="MPG Distribution by Car Cylinders")

# add legend via mouse click
colfill<-c(2:(2+length(levels(cyl.f)))) 
legend("topright", levels(cyl.f), fill=colfill) 

detach()


set.seed(7)
hist.data <- rnorm(100, 3, 2)
hist.data <- round(hist.data, digits = 2)
summary(hist.data)

# # Sturges 공식으로 구해진 계급의 수
# class.n <- ceiling(log(length(hist.data), base = 2) +1 )
# class.n
# 
# # pretty 함수로 구한 breaks
# hist.breaks <- pretty(hist.data, class.n)
# hist.breaks
# 
# hist(hist.data, main = "breaks = default")
# hist(hist.data, breaks = class.n, main = "nclass = class.n")
# hist(hist.data, breaks = hist.breaks, main = "breaks = hist.breaks")
# hist(hist.data, nclass = hist.breaks, main = "nclass = hist.breaks")
# 
# # 도수분포표 계산
# freq <- integer(length(hist.breaks) - 1)
# for (i in seq(freq)) {
#       freq[i] <- sum(hist.breaks[i] < hist.data & hist.data <= hist.breaks[i + 1])
#   }
# freq
# 
# nclass.Sturges(hist.data)
# nclass.scott(hist.data)
# nclass.FD(hist.data)
# pretty(hist.data, nclass.Sturges(hist.data))
# pretty(hist.data, nclass.scott(hist.data))
# pretty(hist.data, nclass.FD(hist.data))
# pretty(hist.data, 10)
# 
# hist(hist.data, breaks = "Sturges", main = "breaks = \"Sturges\"")
# hist(hist.data, breaks = "Scott", main = "breaks = \"Scott\"")
# hist(hist.data, breaks = nclass.FD, main = "breaks = nclass.FD")
# hist(hist.data, breaks = 10, main = "breaks = 10")
# 
# 
# hist.interval <- cut(hist.data, breaks = hist.breaks)
# hist.interval
# table(hist.interval)

hist(hist.data, labels = T, main = "freq = default")
hist(hist.data, freq = F, labels = T, main = "freq = FALSE, labels = T")
hist(hist.data, probability = TRUE, main = "probability = TRUE")
hist(hist.data, labels = LETTERS[1:10], main = "labels = LETTERS[1:10]")

hist(hist.data, right = FALSE, main = "right = FALSE")
hist(hist.data, xlim = c(1, 5), main = "xlim = c(1, 5)")
hist(hist.data, density = 20, col = "red", angle = 135, border = "blue")
hist(hist.data, axes = FALSE, main = "axes = FALSE")

hist(hist.data, plot = FALSE)


# 3.2.5 pie() 함수
# https://www.statmethods.net/graphs/pie.html

# Simple Pie Chart
slices <- c(10, 12,4, 16, 8)
lbls <- c("US", "UK", "Australia", "Germany", "France")
pie(slices, labels = lbls, main="Pie Chart of Countries")

# Pie Chart with Percentages
slices <- c(10, 12, 4, 16, 8) 
lbls <- c("US", "UK", "Australia", "Germany", "France")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct)# add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Countries") 

# 3D Exploded Pie Chart
if(!require(plotrix)) install.packages("plotrix"); library(plotrix)
slices <- c(10, 12, 4, 16, 8) 
lbls <- c("US", "UK", "Australia", "Germany", "France")
pie3D(slices,labels=lbls,explode=0.1,
      main="Pie Chart of Countries ")

# Pie Chart from data frame with Appended Sample Sizes
mytable <- table(iris$Species)
lbls <- paste(names(mytable), "\n", mytable, sep="")
pie(mytable, labels = lbls, 
    main="Pie Chart of Species\n (with sample sizes)") 

# 원도표의 옵션
set.seed(5)
pie.data <- sample(7)
pie.data

pie(pie.data, main = "default")
pie(pie.data, labels = LETTERS[1:7], main = "labels = LETTERS[1:7]")
pie(pie.data, edges = 10, main = "edges = 10")
pie(pie.data, edges = 20, main = "edges = 20")

pie(pie.data, main = "default radius")
pie(pie.data, radius = 0.5, main = "radius = 0.5")
pie(pie.data, radius = 1.5, main = "radius = 1.5")
pie(pie.data, radius = 0, main = "radius = 0")


# 3.2.6 stripchart() 함수 *

set.seed(1)
x <- round(rnorm(50), 1)
set.seed(2)
y <- round(rnorm(50), 1)
set.seed(3)
z <- round(rnorm(50), 1)
strip.data <- list(x, y, z)

stripchart(x, main = "a single vector")                   # 벡터

stripchart(strip.data, main = "a list having 3 vectors")  # 리스트
with(OrchardSprays, stripchart(decrease ~ treatment,      # formula
       main = "formula decrease ~ treatment ", xlab = "treatment", ylab = "decrease"))

set.seed(3)
x <- rnorm(50)
xr <- round(x, 1)

stripchart(x)
m <- mean(par("usr")[1:2])
text(m, 1.04, "stripchart(x, \"overplot\")")

stripchart(xr, method = "stack", add = TRUE, at = 1.2)
text(m, 1.35, "stripchart(round(x, 1), \"stack\")")

stripchart(xr, method = "jitter", add = TRUE, at = 0.7)
text(m, 0.85, "stripchart(round(x,1), \"jitter\")")


with(OrchardSprays, stripchart(decrease ~ treatment, method = "jitter",
       jitter = 0.2, col = "red", pch = 16, cex = 1.5, vertical = TRUE, log = "y",
       main="stripchart(Orchardsprays)", xlab = "treatment", ylab = "decrease",
       group.names = paste(LETTERS[1:8], "group")))
with(OrchardSprays, stripchart(decrease ~ treatment, method = "stack",
       offset = 1/2, col = 1:8, pch = 15, cex = 1.5, main = "stripchart(Orchardsprays)"))


# Create some linked plots 
if(!require(iplots)) install.packages("iplots"); library(iplots)

ihist(mtcars$mpg) # histogram 
ibar(mtcars$carb) # barchart
iplot(mtcars$mpg, mtcars$wt) # scatter plot
ibox(mtcars[c("qsec","disp","hp")]) # boxplots 
ipcp(mtcars[c("mpg","wt","hp")]) # parallel coordinates
 

# 참고로 알면 좋은 함수
# (1) Expression
curve(x ^ 3 - 3 * x, -2, 2)
title(main = "User defined expression")
myfun <- function(x) x ^ 2 + 2

# (2) User Function
curve(myfun, -pi, pi)
title(main = "User defined function")

# (3) R Function
curve(dnorm, from = -3, to = 3)
title(main = "Normal distribution density")

# (4) plot Function
plot(dnorm, from = -3, to = 3)
title(main = "curve by plot function")


curve(dnorm, from = -3, to = 3, n = 10)
title(main = "dnorm by n = 10")
curve(dnorm, from = -1, to = 1, xlim = c(-3, 3))
title(main = "dnorm by from=-1, to=1, xlim=c(-3,3)")
curve(sin, from = -2 * pi, to = 2 * pi, lty = 1, col = "red")
curve(cos, from = -2 * pi, to = 2 * pi, lty = 2, col = "blue", add = T)
title(main = "add = TRUE")
curve(dnorm, from = -3, to = 3, log = "y")
title(main = "dnorm by log = \"y\"")


# 3.2.8 matplot(), matpoints(), matlines() 함수 *그룹별 그림을 그릴때

set.seed(10)
y1 <- rnorm(20, mean = -3, sd = 1)
set.seed(20)
y2 <- rnorm(20, mean = 0, sd = 1)
set.seed(30)
y3 <- rnorm(20, mean = 3, sd = 1)

mat <- cbind(y1, y2, y3)
mat

matplot(y1, type = "l", main = "One vecter argument")
matplot(y1, y2, main = "Two vecter arguments")
matplot(mat, main = "Matrix argument")
matplot(mat, type = "n", main = "Add matlines, matpoints")
matlines(mat)
matpoints(mat)


matplot(mat, type = "lSo", main = "type = \"lSo\"")
matplot(mat, type = c("l","S","o"), main = "type = c(\"l\", \"S\", \"o\")")
matplot(mat, col = c("red","blue","green"), cex = c(1, 1.2, 1.4))
title(main = "c(\"red\", \"blue\", \"green\"), cex=c(1, 1.2, 1.4)")
matplot(mat, type = "l", lty = 3:5, lwd = 1:3)
title(main = "lty = 3:5, lwd = 1:3")

matplot(mat)
matplot(rnorm(20), type = "l", add = TRUE)
title(main = "matplot add matplot")

matplot(mat, type = "n")
matlines(rnorm(20), type = "p")
title(main = "matlines type = \"p\"")

matplot(mat, type = "n")
matpoints(rnorm(20), type = "l")

title(main = "matpoints type = \"l\"")
matplot(mat, pch = 1:3, col = 3:5, verbose = TRUE) # matplot 정보가 출력됨
title(main = "pch = 1:3")


# 3.2.9 qqnrom(), qqline(), qqplot() 함수 * 분위수 그림 (생략)
data1 <- round(rnorm(100, 3, 2), 2)
set.seed(2)
data2 <- round(rnorm(100, 3, 2), 2)

qqplot(data1, data2, main = "Q-Q 플롯")
abline(0,1)

plot(sort(data1), sort(data2), main = "plot of sorted data")
abline(0,1)



x <- round(rnorm(10), 2)
y <- round(rnorm(10), 2)
qqplot(x, y, plot.it = FALSE)
.Last.value

qq <- qqplot(x, y, plot.it = FALSE)
qq

set.seed(1)
data1 <- rnorm(100, 3, 2)
set.seed(2)
data3 <- round(rnorm(50), 2)
qqplot(data1, data3, main = "Q-Q 플롯 length(data1) != length(data3)")
abline(-3/2, 1/2)
abline(0, 1, lty = 2)
seq.odd <- seq(1, 99, 2)
seq.even <- seq(2, 100, 2)
data.odd <- sort(data1)[seq.odd]
data.even <- sort(data1)[seq.even]
data.mean <- (data.odd + data.even ) / 2
plot(data.mean, sort(data3), main = "plot of modified data")
abline(-3/2, 1/2)
abline(0, 1, lty = 2)

set.seed(4)
data4 <- rnorm(50)
seq.norm <- seq(1, 99, 2) / 100    # 분위수를 구하기 위한 시퀀스
qnorm.data <- qnorm(seq.norm)  # 표준 정규분포의 분위수 계산
par(mfrow = c(2,1))
qqnorm(data4, main = "Q-Q Norm")
used.qqnorm <- .Last.value    # qqnorm이 사용한 데이터 추출
abline(0, 1)
qqline(data4, lty = 2)
plot(qnorm.data, sort(data4), main = "using seq")
abline(0, 1)
qqline(data4, lty = 2)
sort(data4)        # data4를 정렬한 순서통계량
sort(used.qqnorm$y)      # qqnorm이 사용한 y 좌표값
qnorm.data        # 표준 정규분포의 분위수
sort(used.qqnorm$x)      # qqnorm이 사용한 x 좌표값


# 3.2.10 sunflowerplot() 함수

x <- NULL
y <- NULL
for (i in 1:50) {
      x <- c(x, rep(ifelse(i%%10 == 0, 10, i %%10), i))
      y <- c(y, rep((i-1) %/% 10 + 1, i))
  }
# (1)
t(table(x, y))
layout(matrix(c(1, 1, 2, 3), ncol = 2, byrow = T))
sunflowerplot(x, y, ylim = c(0.5, 5.2))
title(main = "sunflowerplot's petals")
text(x=ifelse(1:50 %% 10==0, 10, 1:50 %% 10), y=((1:50 - 1)%/%10+1) - 0.5,
       as.character(1:50))

plot(x, y, pch = 16)
title(main = "scatter plot by plot")

plot(jitter(x), jitter(y), pch = 16)
title(main = "scatter plot by plot using jitter")

par(mfrow=c(1,1))
set.seed(101)
x <- sample(1:5, 200, replace = T)
set.seed(102)
y <- sample(1:5, 200, replace = T)

sunflowerplot(x, y)

sunflowerplot(1:10, rep(1, 10), ylim = c(0.5, 5.5), number = 1:10,
                pch = 21, col = "blue", bg = "green", cex = 2)
text(5, 1.3, "number = 1:10, pch = 21, col = \"blue\", bg = \"green\", cex = 2", adj = 0.5)

sunflowerplot(1:10, rep(2, 10), add = T, number = 1:10,
                seg.col = "gold", size = 1/3, seg.lwd = 2.5)
text(5, 2.3, "add = T, number = 1:10, seg.col = \"gold\", size = 1/3, seg.lwd = 2.5", adj = 0.5)

sunflowerplot(1:10, rep(3, 10), add = T, number = 1:10, cex.fact = 0.5)
text(5, 3.3, "add = T, number = 1:10, cex.fact = 0.5", adj = 0.5)

sunflowerplot(1:10, rep(4, 10), add = T, number = 1:10, cex.fact = 2.0)
text(5, 4.3, "add = T, number = 1:10, cex.fact = 2.0", adj = 0.5)

sunflowerplot(1:10, rep(5, 10), add = T, number = 1:10, rotate = TRUE)
text(5, 5.3, "add = T, number = 1:10, rotate = TRUE", adj = 0.5)


# 3.2.11 symbols() 함수 : 다차원의 자료를 2차원 그림으로 표현
x <- round(rnorm(20), 2)
y <- round(rnorm(20), 2)
z1 <- abs(round(rnorm(20), 2))
z2 <- abs(round(rnorm(20), 2))
z3 <- round(runif(20), 2)
z4 <- round(runif(20), 2)
z5 <- round(runif(20), 2)

symbols(x, y, circles = abs(x), inches = 0.2, bg = 1:20)
title(main = "symbols are circles")

symbols(x, y, squares = abs(x), inches = 0.2, bg = 1:20)
title(main = "symbols are squares")

symbols(x, y, rectangles = cbind(abs(x), abs(y)), inches = 0.2, bg = 1:20)
title(main = "symbols are rectangles")

symbols(x, y, stars = cbind(abs(x), abs(y), z1, z2, z3), inches = 0.2, bg=1:20)
title(main = "symbols are stars")

symbols(x, y, thermometers = cbind(abs(x), abs(y), z4), inches=0.2, bg=1:20)
title(main = "symbols are thermometers")

symbols(x, y, boxplots = cbind(abs(x), abs(y), z3, z4, z5), inches=0.2, bg=1:20)
title(main = "symbols are boxplots")


N <- nrow(trees)
palette(rainbow(N, end = 0.9))
with(trees, {
    symbols(Height, Volume, circles = Girth/16, inches = FALSE, bg = 1:N,
            fg = "gray30", main = "symbols(*, circles = Girth/16, inches = FALSE)")
    symbols(Height, Volume, circles = Girth/16, inches = TRUE, bg = 1:N,
            fg = "gray30", main = "symbols(*, circles = Girth/16,inches = TRUE)")
    symbols(Height, Volume, circles = Girth/16, inches = 0.1, bg = 1:N,
            fg = "gray30", main = "symbols(*, circles = Girth/16, inches = 0.1)")
})
palette("default")


# 3.2.12 assocplot() 함수 : 서로 다른 2개의 범주형 자료의 시각화

 HairEyeColor
x <- margin.table(HairEyeColor, c(1, 2))
x
assocplot(x, main = "Relation between hair and eye color")
chisq.test(x)


# 3.2.13 fourfolodplot() 함수

admis <- aperm(UCBAdmissions, c(2, 1, 3))
dimnames(admis)[[2]] <- c("Yes", "No")
names(dimnames(admis)) <- c("Sex", "Admit?", "Department")
admis
ftable(admis) # 전공, 성별, 합격유무

# (1) 성별 합격여부의 데이터
admis.sex <- margin.table(admis, c(1, 2))
admis.sex
# (2) 성별 합격/불합격 비율
prop.table(admis.sex, 1)

# (3)
fourfoldplot(admis.sex)

# (4)
fourfoldplot(admis)

# (5)
fourfoldplot(admis, margin = 2)

prop.table(admis[,,1], 1)
prop.table(admis[,,2], 1)
prop.table(admis[,,3], 1)
prop.table(admis[,,4], 1)
prop.table(admis[,,5], 1)
prop.table(admis[,,6], 1)

# 학부별 합격률
round(prop.table(margin.table(admis, c(2, 3)), 2) * 100, 2)


# 3.2.14 mosaiocplot() 함수

mosaicplot(admis.sex, color = FALSE, las = 0, main = "color = FALSE, las = 0")
mosaicplot(admis.sex, color = TRUE, las = 1, dir = c("h", "v"),
           xlab = "Admit?", ylab = "Sex",
           main = "color = T, las = 1,dir = c(\"h\", \"v\"), xlab, ylab")
mosaicplot(~ Gender + Admit, data = UCBAdmissions, sort = c(2, 1),
           color = 2:3, las = 2,
           main = "formula, sort = c(2, 1), color = 2:3, las = 2")
mosaicplot(admis.sex, off = c(5, 20), las = 3, shade = TRUE,
            main = "off = c(5, 20), las = 3, shade = TRUE")

mosaicplot(admis, sort = c(3, 1, 2), shade = T, margin = list(c(1, 3), c(2, 3)),
    xlab = "Department", main = "Sex, Admit?, Department Mosaic Plots")

# 3.2.15 paris() 함수

pairs(~ Fertility + Education + Catholic, data = swiss,
    subset = Education < 20, main = "Swiss data, Education < 20",
    col = 1 + (swiss$Agriculture > 50), cex = 1.2,
    pch = 1 + (swiss$Agriculture > 50))

pairs(iris[1:4], main = "Anderson's Iris Data--3 species",
    pch = 21, bg = c("red", "green3", "blue")[unclass(iris$Species)])


# 대각 패널 함수의 정의
panel.hist <- function(x, ...)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(usr[1:2], 0, 1.5) )
    h <- hist(x, plot = FALSE)
    breaks <- h$breaks; nB <- length(breaks)
    y <- h$counts; y <- y/max(y)
    rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}

pairs(USJudgeRatings[1:3], panel = panel.smooth,
    cex = 1.5, pch = 24, bg = "light blue",
    diag.panel = panel.hist, cex.labels = 2, font.labels = 2)


panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    r <- abs(cor(x, y))
    txt <- format(c(r, 0.123456789), digits = digits)[1]
    txt <- paste(prefix, txt, sep = "")

    if(missing(cex.cor)) cex <- 0.8 / strwidth(txt)
    text(0.5, 0.5, txt, cex = cex * r)
}

pairs(USJudgeRatings[1:3], row1attop = FALSE, gap = 2,
    lower.panel = panel.smooth, upper.panel = panel.cor )


# 3.2.16 coplot() 함수

length(quakes$depth)
summary(quakes$depth)
inter <- co.intervals(quakes$depth, number = 4, overlap = 0.1)
inter
inter[, 2] - inter[, 1]      # 등 간격이 아님
length.inter <- as.numeric(0)
for (i in 1:4)
    length.inter[i] <- length(quakes$depth[inter[i, 1] <= quakes$depth &
                              quakes$depth <= inter[i, 2]])
length.inter                # 도수의 분포가 균일하게 나눔
sum(length.inter)            # 도수의 합이 1000을 넘음


dim(quakes)
is.data.frame(quakes)
names(quakes)
coplot(lat ~ long | depth, data = quakes)


dim(iris)
is.data.frame(iris)
names(iris)
table(iris$Species)

coplot(Sepal.Length ~ Sepal.Width | Species, data = iris)


formulas <- lat ~ long | depth * mag
coplot(formulas, data = quakes, col = "red", pch = 2,
         number = c(3, 4), bar.bg = c(num = "green", fac = "blue"))


# 3.2.17 satrs() 함수

op <- par(no.readonly = TRUE)
WESTarrests <- USArrests[state.region == "West",]                           # (1)
par(mfrow = c(2, 2))
stars(WESTarrests, draw.segments = FALSE, len = 0.7, key.loc = c(7, 2))     # (2)
title(main = "Stars Plot, unit key, len = 0.7")
stars(WESTarrests, draw.segments = TRUE, full = FALSE, key.loc = c(7, 2))   # (3)
title(main = "Segments Plot,unit key, full = F")
stars(WESTarrests, locations = c(0, 0), scale = TRUE, radius = FALSE,
        col.stars = 0, key.loc = c(0, 0))                                     # (4)
title(main = "Spider Plot,unit key, scale = T, radius = F")
stars(WESTarrests, locations = 0:1, scale = TRUE, draw.segments = TRUE,
        col.segments = 0, col.stars = 0, key.loc = 0:1)                       # (5)
title(main = "Radar Plot,unit key, scale = T")
par(op)


# 3.2.18 persp() 함수 # 3차원 함수

# (1) sinc 함수를 정의함
x <- seq(-10, 10, length = 30)
y <- x
f <- function(x, y) { r <- sqrt(x ^ 2 + y ^ 2); 10 * sin(r) / r }
z <- outer(x, y, f)
z[is.na(z)] <- 1        # 결측치의 값을 1로 바꾼다.

# (2) sinc 함수를 투시도로 그림
persp(x, y, z, theta = 30, phi = 30, expand = 0.5, col = "lightblue",
        ltheta = 120, shade = 0.75, ticktype = "detailed",
        xlab = "X", ylab = "Y", zlab = "Sinc( r )") -> res
title(main="Perspective Plots with Sinc Function")
round(res, 3)      # persp() 함수의 반환 값

# (3) 3차원 좌표로 변환하는 함수
trans3d <- function(x, y, z, pmat) {
    tr <- cbind(x, y, z, 1) %*% pmat
    list(x = tr[,1] / tr[,4], y = tr[,2] / tr[,4])
}

xE <- c(-10,10); xy <- expand.grid(xE, xE)
points(trans3d(xy[,1], xy[,2], 6, pm = res), col = 2, pch = 16)
lines (trans3d(x, y =10, z = 6 + sin(x), pm = res), col = 3)

phi <- seq(0, 2 * pi, len = 201)
r1 <- 7.725
xr <- r1 * cos(phi)
yr <- r1 * sin(phi)
lines(trans3d(xr, yr, f(xr, yr), res), col = "pink", lwd = 2)



z <- 2 * volcano        # Exaggerate the relief
x <- 10 * (1:nrow(z))   # 10 meter spacing (S to N)
y <- 10 * (1:ncol(z))   # 10 meter spacing (E to W)

par(bg = "lavender")
persp(x, y, z, theta = 135, phi = 30, col = "green3", scale = FALSE,
        ltheta = -120, shade = 0.75, border = NA, box = FALSE)
title("Perspective Plots with volcano")


# 3.2.19 contour() 함수
rx <- range(x <- 10 * 1:nrow(volcano))
ry <- range(y <- 10 * 1:ncol(volcano))
ry <- ry + c(-1, 1) * (diff(rx) - diff(ry)) / 2
tcol <- terrain.colors(12)
plot(x = 0, y = 0, type = "n", xlim = rx, ylim = ry, xlab = "", ylab = "")
u <- par("usr")
rect(u[1], u[3], u[2], u[4], col = tcol[8], border = "red")
contour(x, y, volcano, col = tcol[2], lty = "solid", add = TRUE,
          vfont = c("sans serif", "plain"))
title("A Topographic Map of Maunga Whau", font = 4)
abline(h = 200 * 0:4, v = 200 * 0:4, col = "lightgray", lty = 2, lwd = 0.1)


line.list <- contourLines(x, y, volcano)  # (1) contourLines 호출
plot(x = 0, y = 0, type = "n", xlim = rx, ylim = ry, xlab = "", ylab = "")
rect(u[1], u[3], u[2], u[4], col = tcol[8], border = "red")
is.list(line.list)                        # (2) 리스트 여부 확인
length(line.list)                          # (3) 성분의 개수
names(line.list[[1]])                      # (4) 성분의 이름
line.list[[1]]                            # (5) 첫 번째 성분 출력

templines <- function(clines) {                # (6) 등고선과 라벨 출력 함수 정의
    lines(clines[[2]], clines[[3]])
    text(clines[[2]][1], clines[[3]][1], clines[[1]][1], cex = 0.5, col = "blue")
}
invisible(lapply(line.list, templines))        # (7) 등고선을 그린다.
title("A Topographic Map of Maunga Whau by contourLines", font=4)
abline(h = 200 * 0:4, v = 200*0:4, col = "lightgray", lty = 2, lwd = 0.1)


# 3.2.20 image() 함수

image(volcano, zlim = c(150, 200), xaxs = "r", yaxs = "r",
        xlab = "West to East", ylab = "South to North")
image(volcano, zlim = c(0, 150), add = T, col = cm.colors(12),
        xlab = "0 to 1", ylab = "0 to 1")
title(main = "image & add image")


x <- 10 * (1:nrow(volcano))
y <- 10 * (1:ncol(volcano))
image(x, y, volcano, col = terrain.colors(100), axes = FALSE)
contour(x, y, volcano, levels = seq(90, 200, by = 5),
          add = TRUE, col = "peru")
axis(1, at = seq(100, 800, by = 100))
axis(2, at = seq(100, 600, by = 100))
box()
title(main = "Maunga Whau Volcano", font.main = 4)


# 3.2.21 filled.contour 함수()

x <- 10 * 1:nrow(volcano)
y <- 10 * 1:ncol(volcano)
filled.contour(x, y, volcano, color = terrain.colors,
                 plot.title = title(main = "The Topography of Maunga Whau",
                                    xlab = "Meters North", ylab = "Meters West"),
                 plot.axes = { axis(1, seq(100, 800, by = 100))
                               axis(2, seq(100, 600, by = 100)) },
                 key.title = title(main = "Heightn(meters)"),
                 key.axes = axis(4, seq(90, 190, by = 10)))
