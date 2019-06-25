if(!require(rgdal)) install.packages("rgdal") ;library(rgdal)
if(!require(ggplot2)) install.packages("ggplot2") ;library(ggplot2)
if(!require(rgeos)) install.packages("rgeos") ;library(rgeos)
if(!require(maptools)) install.packages("maptools") ;library(maptools)
if(!require(grid)) install.packages("grid") ;library(grid)
if(!require(gridExtra)) install.packages("gridExtra") ;library(gridExtra)
if(!require(mapproj)) install.packages("mapproj") ;library(mapproj)

map.det<- readOGR("F:/대전발표자료/day3/CTPRVN_201703/TL_SCCO_CTPRVN.shp")
plot(map.det)

map.det@data

#get centroids
map.test.centroids <- gCentroid(map.det, byid=T)
map.test.centroids <- as.data.frame(map.test.centroids)
map.test.centroids$CTPRVN_CD <- map.det@data$CTPRVN_CD

head(map.det@data)
#create df for ggplot
kt_geom <- fortify(map.det, region="CTPRVN_CD")
head(kt_geom)

#Plot map
map.test <- ggplot(kt_geom)+
  geom_polygon(aes(long, lat, group=group), fill="white")+
  # coord_fixed()+
  geom_path(color="gray48", mapping=aes(long, lat, group=group), size=0.2)+
  geom_point(data=map.test.centroids, aes(x=x, y=y), size=2, alpha=6/10)

map.test

set.seed(1)
geo_data <- data.frame(who=rep(c(1:length(map.det$CTPRVN_CD)), each=2),
                       value=as.numeric(sample(1:100, length(map.det$CTPRVN_CD)*2, replace=T)),
                       id=rep(c(1:length(map.det$CTPRVN_CD)), 2))

bar.testplot_list <- 
  lapply(1:length(map.det$CTPRVN_CD), function(i) { 
    gt_plot <- ggplotGrob(
      ggplot(geo_data[geo_data$id == i,])+
        geom_bar(aes(factor(id),value,group=who), fill = rainbow(length(map.det$CTPRVN_CD))[i],
                 position='dodge',stat='identity', color = "black") +
        labs(x = NULL, y = NULL) + 
        theme(legend.position = "none", rect = element_blank(),
              line = element_blank(), text = element_blank()) 
    )
    panel_coords <- gt_plot$layout[gt_plot$layout$name == "panel",]
    gt_plot[panel_coords$t:panel_coords$b, panel_coords$l:panel_coords$r]
  })

bar_annotation_list <- lapply(1:length(map.det$CTPRVN_CD), function(i) 
  annotation_custom(bar.testplot_list[[i]], 
                    xmin = map.test.centroids$x[map.test.centroids$CTPRVN_CD == as.character(map.det$CTPRVN_CD[i])] - 5e3,
                    xmax = map.test.centroids$x[map.test.centroids$CTPRVN_CD == as.character(map.det$CTPRVN_CD[i])] + 5e3,
                    ymin = map.test.centroids$y[map.test.centroids$CTPRVN_CD == as.character(map.det$CTPRVN_CD[i])] - 5e3,
                    ymax = map.test.centroids$y[map.test.centroids$CTPRVN_CD == as.character(map.det$CTPRVN_CD[i])] + 5e3) )

result_plot <- Reduce(`+`, bar_annotation_list, map.test)

result_plot
