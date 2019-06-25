library(MASS)
table(Cars93$Type)
if(!require(doBy)) install.packages("doBy")
library(doBy)

mean_by_Type <- summaryBy(MPG.highway + RPM + Horsepower + Weight + Length + Price ~ Type, data=Cars93, FUN = c(mean))
mean_by_Type

if(!require(fmsb)) install.packages("fmsb")
library(fmsb)

df_radarchart <- function(df) {
  df <- data.frame(df)
  dfmax <- apply(df, 2, max) 
  dfmin <- apply(df, 2, min) 
  as.data.frame(rbind(dfmax, dfmin, df))
}

mean_by_Type_trans <- df_radarchart(scale(mean_by_Type[,c(2:7)]))

mean_by_Type_trans


radarchart(df = mean_by_Type_trans, # The data frame to be used to draw radarchart
           seg = 6, # The number of segments for each axis 
           pty = 16, # A vector to specify point symbol: Default 16 (closed circle)
           pcol = 1:6, # A vector of color codes for plot data
           plty = 1:6, # A vector of line types for plot data
           plwd = 2, # A vector of line widths for plot data
           title = c("radar chart by Car Types") # putting title at the top-middle
)

legend("topleft", legend = mean_by_Type$Type, col = c(1:6), lty = c(1:6), lwd = 2)

