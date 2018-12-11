setwd("~/Documents/Master's/eDNA-reptileMap")

sites<-read.csv("sites.csv")
head(sites)

library(ggplot2)
library(ggmap)
library(ggrepel)
library(RgoogleMaps)
library(maps)
library(plyr)
library(sp)

require ("ggmap")
library ("png")
library(iptools)
library(rgeolocate)
library(tidyverse)

library("ggmap")
library(maptools)
library(maps)


wrld <- map_data("world")

wrld <- map_data("world") %>%
  filter(region != "Antarctica")

gg1 <- ggplot() + geom_polygon(data = wrld, aes(x=long, y = lat, group = group)) +
  coord_fixed(1.0)

gg1 +
  geom_point(data = sites, aes(x = Long, y = Lat, shape=Type, color=Study), size = 4)+labs(x="Longitude", y="Latitude")+theme(axis.text=element_text(size=15), axis.title=element_text(size=25,face="bold")) +
  theme(legend.position="bottom")

