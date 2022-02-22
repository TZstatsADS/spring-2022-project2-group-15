# Importing Data files
#getwd()
library(dplyr)
library(tidyverse)
library(lubridate)
library(readr)
library(data.table)
library(stringr)
library(ggthemes)
library(shiny)
library(shinythemes)
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

