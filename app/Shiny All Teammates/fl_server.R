if (!require("shiny")) {
  install.packages("shiny")
  library(shiny)
}
if (!require("leaflet")) {
  install.packages("leaflet")
  library(leaflet)
}
if (!require("leaflet.extras")) {
  install.packages("leaflet.extras")
  library(leaflet.extras)
}
if (!require("dplyr")) {
  install.packages("dplyr")
  library(dplyr)
}
if (!require("magrittr")) {
  install.packages("magrittr")
  library(magrittr)
}
if (!require("mapview")) {
  install.packages("mapview")
  library(mapview)
}
if (!require("leafsync")) {
  install.packages("leafsync")
  library(leafsync)
}

library(shiny)
library(shinythemes)
library(shinyWidgets)
library(tidyverse)
library(dplyr)
library(lubridate)
library(tibble)
library(leaflet)
library(fontawesome)
library(jsonlite)
library(RColorBrewer)

## choose palette
newPalette<-colorRampPalette(brewer.pal(9,"Blues"))(10)
geoData <- readLines("/Users/fuchengliu/Downloads/Borough Boundaries.geojson",warn=FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

## divide data into different event types
data_use <- read_csv("/Users/fuchengliu/Desktop/project 2/datause.csv")

sports <- map_data("Sports Event")
art <- map_data("Art Event")
street <- map_data("Street-based Events")
special <- map_data("Special Events")
volun <- map_data("Volunteering Events")


shinyServer(
  function(input, output) {
    output$left_map <- renderLeaflet({
      leaflet() %>%
        addTiles() %>%
        addProviderTiles("CartoDB.Positron") %>%  
        addAwesomeMarkers(lng = -73.9855530, lat = 40.7579990,
                          icon = awesomeIcons(markerColor = "orange",
                                              text = fa("street-view")),
                          label = "Times Square") %>%
        setView(lng = -73.9855530, lat = 40.757990, zoom = 11) 
    })
    output$right_map <- renderLeaflet({
      leaflet() %>%
        addTiles() %>%
        addProviderTiles("CartoDB.Positron") %>%  
        addAwesomeMarkers(lng = -73.9855530, lat = 40.7579990,
                          icon = awesomeIcons(markerColor = "orange",
                                              text = fa("street-view")),
                          label = "Times Square") %>%
        setView(lng = -73.9855530, lat = 40.757990, zoom = 11) 
    })
    
  
    observeEvent(input$Event_Type == "Sports",{
      leafletProxy("left_map") %>%
        addMarkers(lng = -73.9441579, lat = 40.6781784,label = "Brooklyn", popup ="count of events per month: 1827.8750") %>%
        addMarkers(lng = -73.9712488, lat = 40.7830603,label = "Manhattan", popup ="count of events per month:2107.0625") %>%
        addMarkers(lng = -73.8648268, lat = 40.8447819,label = "Bronx", popup ="count of events per month:567.6250") %>%
        addMarkers(lng = -73.7948516, lat = 40.7282239,label = "Queens", popup ="count of events per month:1526.6875") %>%
        addMarkers(lng = -74.1502007, lat = 40.5795317,label = "Staten Island", popup ="count of events per month:163.3125") %>%
        addGeoJSON(coloring(sports)$left)
      leafletProxy("right_map") %>%
        addMarkers(lng = -73.9441579, lat = 40.6781784,label = "Brooklyn", popup ="count of events per month:2250.4688") %>%
        addMarkers(lng = -73.9712488, lat = 40.7830603,label = "Manhattan", popup ="count of events per month:3009.0312") %>%
        addMarkers(lng = -73.8648268, lat = 40.8447819,label = "Bronx", popup ="count of events per month:878.0625") %>%
        addMarkers(lng = -73.7948516, lat = 40.7282239,label = "Queens", popup ="count of events per month:1935.5312") %>%
        addMarkers(lng = -74.1502007, lat = 40.5795317,label = "Staten Island", popup ="count of events per month:353.6875") %>%
        addGeoJSON(coloring(sports)$right)
    })
    
    
    observeEvent(input$Event_Type == "Art",{
      leafletProxy("left_map") %>%
        addMarkers(lng = -73.9441579, lat = 40.6781784,label = "Brooklyn", popup ="count of events per month: 7.18750
") %>%
        addMarkers(lng = -73.9712488, lat = 40.7830603,label = "Manhattan", popup ="count of events per month:107.68750") %>%
        addMarkers(lng = -73.8648268, lat = 40.8447819,label = "Bronx", popup ="count of events per month:1.31250") %>%
        addMarkers(lng = -73.7948516, lat = 40.7282239,label = "Queens", popup ="count of events per month:1.06250") %>%
        addMarkers(lng = -74.1502007, lat = 40.5795317,label = "Staten Island", popup ="count of events per month:1.50000") %>%
        addGeoJSON(coloring(art)$left)
      leafletProxy("right_map") %>%
        addMarkers(lng = -73.9441579, lat = 40.6781784,label = "Brooklyn", popup ="count of events per month:10.84375") %>%
        addMarkers(lng = -73.9712488, lat = 40.7830603,label = "Manhattan", popup ="count of events per month:36.43750") %>%
        addMarkers(lng = -73.8648268, lat = 40.8447819,label = "Bronx", popup ="count of events per month:2.00000") %>%
        addMarkers(lng = -73.7948516, lat = 40.7282239,label = "Queens", popup ="count of events per month:4.21875") %>%
        addMarkers(lng = -74.1502007, lat = 40.5795317,label = "Staten Island", popup ="count of events per month:0.28125") %>%
        addGeoJSON(coloring(art)$right)
    })
    
    observeEvent(input$Event_Type == "Street-based Event",{
      leafletProxy("left_map") %>%
        addMarkers(lng = -73.9441579, lat = 40.6781784,label = "Brooklyn", popup ="count of events per month: 154.81250") %>%
        addMarkers(lng = -73.9712488, lat = 40.7830603,label = "Manhattan", popup ="count of events per month:189.12500") %>%
        addMarkers(lng = -73.8648268, lat = 40.8447819,label = "Bronx", popup ="count of events per month:50.68750") %>%
        addMarkers(lng = -73.7948516, lat = 40.7282239,label = "Queens", popup ="count of events per month:94.31250") %>%
        addMarkers(lng = -74.1502007, lat = 40.5795317,label = "Staten Island", popup ="count of events per month:14.62500") %>%
        addGeoJSON(coloring(street)$left)
      leafletProxy("right_map") %>%
        addMarkers(lng = -73.9441579, lat = 40.6781784,label = "Brooklyn", popup ="count of events per month:93.18750
") %>%
        addMarkers(lng = -73.9712488, lat = 40.7830603,label = "Manhattan", popup ="count of events per month:136.46875") %>%
        addMarkers(lng = -73.8648268, lat = 40.8447819,label = "Bronx", popup ="count of events per month:37.12500") %>%
        addMarkers(lng = -73.7948516, lat = 40.7282239,label = "Queens", popup ="count of events per month:51.59375") %>%
        addMarkers(lng = -74.1502007, lat = 40.5795317,label = "Staten Island", popup ="count of events per month:6.40625") %>%
        addGeoJSON(coloring(street)$right)
    })
    
    observeEvent(input$Event_Type == "Special Event",{
      leafletProxy("left_map") %>%
        addMarkers(lng = -73.9441579, lat = 40.6781784,label = "Brooklyn", popup ="count of events per month: 574.6250") %>%
        addMarkers(lng = -73.9712488, lat = 40.7830603,label = "Manhattan", popup ="count of events per month:1343.0000") %>%
        addMarkers(lng = -73.8648268, lat = 40.8447819,label = "Bronx", popup ="count of events per month:307.5000") %>%
        addMarkers(lng = -73.7948516, lat = 40.7282239,label = "Queens", popup ="count of events per month:473.1250") %>%
        addMarkers(lng = -74.1502007, lat = 40.5795317,label = "Staten Island", popup ="count of events per month:138.1875") %>%
        addGeoJSON(coloring(special)$left)
      leafletProxy("right_map") %>%
        addMarkers(lng = -73.9441579, lat = 40.6781784,label = "Brooklyn", popup ="count of events per month:759.9062") %>%
        addMarkers(lng = -73.9712488, lat = 40.7830603,label = "Manhattan", popup ="count of events per month:1079.3125") %>%
        addMarkers(lng = -73.8648268, lat = 40.8447819,label = "Bronx", popup ="count of events per month:452.4062") %>%
        addMarkers(lng = -73.7948516, lat = 40.7282239,label = "Queens", popup ="count of events per month:454.8750") %>%
        addMarkers(lng = -74.1502007, lat = 40.5795317,label = "Staten Island", popup ="count of events per month:179.4375") %>%
        addGeoJSON(coloring(special)$right)
    })
    
    observeEvent(input$Event_Type == "Volunteering",{
      leafletProxy("left_map") %>%
        addMarkers(lng = -73.9441579, lat = 40.6781784,label = "Brooklyn", popup ="count of events per month: 14.87500") %>%
        addMarkers(lng = -73.9712488, lat = 40.7830603,label = "Manhattan", popup ="count of events per month:5.31250") %>%
        addMarkers(lng = -73.8648268, lat = 40.8447819,label = "Bronx", popup ="count of events per month:10.75000
") %>%
        addMarkers(lng = -73.7948516, lat = 40.7282239,label = "Queens", popup ="count of events per month:2.31250") %>%
        addMarkers(lng = -74.1502007, lat = 40.5795317,label = "Staten Island", popup ="count of events per month:0.06250") %>%
        addGeoJSON(coloring(volun)$left)
      leafletProxy("right_map") %>%
        addMarkers(lng = -73.9441579, lat = 40.6781784,label = "Brooklyn", popup ="count of events per month:7.59375") %>%
        addMarkers(lng = -73.9712488, lat = 40.7830603,label = "Manhattan", popup ="count of events per month:6.81250") %>%
        addMarkers(lng = -73.8648268, lat = 40.8447819,label = "Bronx", popup ="count of events per month:0.68750") %>%
        addMarkers(lng = -73.7948516, lat = 40.7282239,label = "Queens", popup ="count of events per month:2.03125") %>%
        addMarkers(lng = -74.1502007, lat = 40.5795317,label = "Staten Island", popup ="count of events per month:0.18750") %>%
        addGeoJSON(coloring(volun)$right)
    })
    
  }
  )
