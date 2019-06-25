if(!require(ggplot2)) install.packages("ggplot2")
library(ggplot2)

if(!require("gridExtra"))install.packages("gridExtra")
library(gridExtra)

a <- ggplot(data=mtcars, aes(x=wt, y=mpg))
a <- a + geom_point()
a <- a + geom_line(colour="red")
a <- a + stat_smooth(method="lm", se=TRUE, colour="blue")

b <- ggplot(data=mtcars, aes(x=disp, y=mpg))
b <- b + geom_point()
b <- b + geom_line(colour="red")
b <- b + stat_smooth(method="lm", se=TRUE, colour="blue")

c <- ggplot(data=mtcars, aes(x=hp, y=mpg))
c <- c + geom_point()
c <- c + geom_line(colour="red")
c <- c + stat_smooth(method="lm", se=TRUE, colour="blue")

d <- ggplot(data=mtcars, aes(x=drat, y=mpg))
d <- d + geom_point()
d <- d + geom_line(colour="red")
d <- d + stat_smooth(method="lm", se=TRUE, colour="blue")

e <- ggplot(data=mtcars, aes(x=qsec, y=mpg))
e <- e + geom_point()
e <- e + geom_line(colour="red")
e <- e + stat_smooth(method="lm", se=TRUE, colour="blue")

f <- ggplot(data=mtcars, aes(x=cyl, y=mpg))
f <- f + geom_point()
f <- f + geom_line(colour="red")
f <- f + stat_smooth(method="lm", se=TRUE, colour="blue")

grid.arrange(a,b,c,d,e,f, nrow=2, ncol=3)