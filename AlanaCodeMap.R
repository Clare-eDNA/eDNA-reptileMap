# Required libraries including maps
library(tidyverse)
library(maps)

# Data location
setwd("~/Documents/Master's/eDNA-reptileMap")

# Reading in data as tibble rather than data frame (more elegantly handles strings)
sites<-read_csv("sites.csv")
sites

wrld <- map_data("world")

wrld <- map_data("world") %>%
  filter(region != "Antarctica")

gg1 <- ggplot() + geom_polygon(data = wrld, aes(x=long, y = lat, group = group)) +
  coord_fixed(1.0)

cbbPalette <- c("#FFFF6D", "#24FF24","#004949", "#924900","#009292", "#FF6DB6", "#FFB6DB", "#6e0092", "#006DDB", "#B66DFF","#6DB6FF", "#B6DBFF", "#920000",  "#DB6D00")

# Creating new variable which is what we'll actually "plot"
sites <- sites %>% mutate(plotgroup = paste(Type,Study)) %>% arrange(plotgroup)

# Getting a shape vector the same length as our Type vector to use for point shapes
shapevector <- rep(NA,length(sites$Type))

for (i in 1:length(unique(sites$Type))) {
  shapevector[which(sites$Type==unique(sites$Type)[i])] <- 20+i
}

# Intitalize plot with shape and fill by plotgroup
# calling geom_jitter directly, because calling it after geom_point is the same
# increased the positional jitter, because sites were still overlapping
initialplot <- gg1 +
  geom_jitter(data = sites, aes(x = Long, y = Lat, shape=plotgroup, fill=plotgroup), size = 5, stroke=0.5, position=position_jitter(width = 5)) +
  labs(x="Longitude", y="Latitude") +
  theme(axis.text=element_text(size=15), axis.title=element_text(size=25,face="bold"))

initialplot

# Create a new variable with duplicate names distinguished by spaces for legend
# Cannot have exactly the same names repeated in order for the finalplot call to work
labelnames <- NULL
for (i in 1:length(sites$Study)) {
  temp <- sites$Study[i]
  if (temp %in% labelnames) {
    temp <- paste(temp," ",sep="")
  }
  labelnames <- c(labelnames,temp)
}

# We use scale_shape and scale_fill manual. The vectors we feed as values must
# be the same length as sites$plotgroup
# Defining by colour (e.g. point outline) as well causes issues probably because
# of a similar issue to
# https://stackoverflow.com/questions/12488905/why-wont-the-ggplot2-legend-combine-manual-fill-and-scale-values

finalplot <- initialplot +
  scale_shape_manual(name="Legend",values = shapevector, labels=labelnames) +
  scale_fill_manual(name="Legend",values = cbbPalette, labels=labelnames)+theme(legend.position="bottom")

finalplot
