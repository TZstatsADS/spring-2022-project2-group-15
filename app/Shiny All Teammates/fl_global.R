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

source('map_data.R')
source('coloring.R')

## choose palette
newPalette<-colorRampPalette(brewer.pal(9,"Blues"))(10)
geoData <- readLines("Borough Boundaries.geojson",warn=FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

## divide data into different event types
data_use <- read.csv("events_data.csv")

data_use[['Start.Date.Time']] <- strptime(data_use[['Start.Date.Time']],
                                             format = "%Y-%m-%d %H:%M:%S")
data_use[['End.Date.Time']] <- strptime(data_use[['End.Date.Time']],
                                           format = "%Y-%m-%d %H:%M:%S")

sports <- map_data("Sports Event")
art <- map_data("Art Event")
street <- map_data("Street-based Events")
special <- map_data("Special Events ")
volun <- map_data("Volunteering Events")

