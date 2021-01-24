# Set libraries to be used in this assignment
library(knitr)
library(leaflet)
library(fontawesome)
library(dplyr)
# Download ski data from public URL omitting rows with NA values and pre-process
skiURL <- "https://gist.githubusercontent.com/Ewiseman/b251e5eaf70ca52a4b9b10dce9e635a4/raw/9f0100fe14169a058c451380edca3bda24d3f673/ski_resort_stats.csv"
skiData <- na.omit(read.csv(url(skiURL)))
# Identify the highest percentage of slope types (green, blue or black)
skiData <- skiData %>% 
  mutate (slope_trend = 
            if_else(green_percent >= blue_percent, 
                    if_else(green_percent >= black_percent, 'green', 'black'), 
                    if_else(blue_percent >= black_percent, 'blue', 'black')))
# Create map using ad-hoc icons from font awesome: https://github.com/rstudio/fontawesome
# Markers will be colored according to slope_trend
# Markers will have as pop-up the ski resort_name
skiMap <- leaflet(data = skiData) %>% 
  addTiles() %>% 
  addAwesomeMarkers(~lon, ~lat,
                    icon = makeAwesomeIcon(text = fa(name = "skiing",
                                                     fill = "white"), 
                                           markerColor = ~slope_trend),
                    popup = ~resort_name)
# Create secondary map using cluster options to simplify map
# Legend will be added to show meaning of markers' color
skiLegend <- c("#72AF26", "#36A4D5", "#303030")
skiMapCluster <- leaflet(data = skiData) %>% 
  addTiles() %>% 
  addAwesomeMarkers(~lon, ~lat,
                    icon = makeAwesomeIcon(text = fa(name = "skiing",
                                                     fill = "white"), 
                                           markerColor = ~slope_trend),
                    popup = ~resort_name,
                    clusterOptions = markerClusterOptions()) %>%
  addLegend(position = "bottomright", title = "Resort slopes' difficulty",
            labels = c("Easy", "Medium", "Hard"), 
            colors = skiLegend)
