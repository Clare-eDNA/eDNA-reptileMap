#Uni of Otago map

library(tidyverse)
library(dplyr)
library(ggplot2)
library(raster)
library(rasterVis)
library(scales)
library(rgeos)
library(rgdal)

nz <- map_data("nz")
map('nz')
map('nz', xlim = c(166, 179), ylim = c(-48, -34))

labs <- data.frame(
  long = c(170.513889),
  lat = c(-45.865556),
  names = c("University of Otago"),
  stringsAsFactors = FALSE
)

gg1 <- ggplot() + geom_polygon(data = nz, aes(x=long, y = lat, group = group)) +
  coord_fixed(1.3)

gg1 +
  geom_point(data = labs, aes(x = long, y = lat), color = "red", size = 4)+labs(x="Longitude", y="Latitude")+theme(axis.text=element_text(size=10), axis.title=element_text(size=18,face="bold"))+theme_bw()
