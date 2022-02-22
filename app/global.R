# Importing Data files
#getwd()
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

source('../lib/map_data.R')
source('../lib/coloring.R')

library(readr)
library(data.table)
library(stringr)
library(ggthemes)
library(rsconnect)

events_data = read.csv('../data/events_data.csv')
events_data[['Start.Date.Time']] <- strptime(events_data[['Start.Date.Time']],
                                             format = "%Y-%m-%d %H:%M:%S")
events_data[['End.Date.Time']] <- strptime(events_data[['End.Date.Time']],
                                           format = "%Y-%m-%d %H:%M:%S")

all_time_covid = read.csv('../data/all_time_covid.csv')
all_time_covid[['date_of_interest']] <- strptime(all_time_covid[['date_of_interest']],
                                                 format = "%Y-%m-%d")

covid_borough = read.csv('../data/covid_borough.csv')
covid_city_cal<-colSums(covid_borough[,2:4])
covid_city<-data.frame(borough="city",people_tested=covid_city_cal[1], people_positive=covid_city_cal[2], percentpositivity_7day=round(covid_city_cal[2]/covid_city_cal[1]*100,3))

# Creating menu options

event_cat <- unique(events_data$Event_Category)
borough_nyc <- unique(events_data$Event.Borough)

## choose palette
newPalette<-colorRampPalette(brewer.pal(9,"Blues"))(10)
geoData <- readLines("../data/Borough Boundaries.geojson",warn=FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

## divide data into different event types
data_use <- read.csv("../data/events_data.csv")

data_use[['Start.Date.Time']] <- strptime(data_use[['Start.Date.Time']],
                                          format = "%Y-%m-%d %H:%M:%S")
data_use[['End.Date.Time']] <- strptime(data_use[['End.Date.Time']],
                                        format = "%Y-%m-%d %H:%M:%S")

sports <- map_data("Sports Event")
art <- map_data("Art Event")
street <- map_data("Street-based Events")
special <- map_data("Special Events ")
volun <- map_data("Volunteering Events")

