library(dplyr)
library(tidyverse)
library(lubridate)
library(readr)
library(data.table)
library(stringr)

# Deal with Events data
## Load the data set

events_data_processing <- function(filelocation) {
  data <- read_csv(filelocation)
  nrow(data)
  str(data)
  
  print("Beginning Data Cleaning")
  
  # Data Cleaning 
  data[['Start Date/Time']] <- strptime(data[['Start Date/Time']],
                                   format = "%m/%d/%Y %H:%M:%S")
  data[['End Date/Time']] <- strptime(data[['End Date/Time']],
                                        format = "%m/%d/%Y %H:%M:%S")
  
  data <- data %>% mutate(end_year = year(data$`End Date/Time`))
  
  ## Remove the repeating rows
  data2 <- data %>%
    distinct()
  nrow(data2)
  
  ## Keeping 2019 to 2022
  data3 = data2[data2$end_year > 2018,]
  data3 = data3[data3$end_year < 2023,]
  nrow(data3)
  
  ## Remove the data with NA event id
  data_rm_na_id <- data3 %>%
    filter(is.na(`Event ID`) == FALSE)
  
  ## Updating Type of event categories
  data_use = data_rm_na_id %>%
    mutate(`Event Type` = str_trim(`Event Type`)) 
  
  data_use = data_use %>%
    mutate(Event_Category = case_when(
      `Event Type` %in% c("Athletic Race / Tour", "Stickball", "Athletic", "Health Fair", "Marathon", "Sport - Youth", "Sport - Adult", "Athletic - Charitable") ~ "Sports Event",
      `Event Type` %in% c("Public Program / Exhibitions", "Production Event", "Theater Load in and Load Outs", "Shooting Permit", "Open Culture", "Filming/Photography") ~ "Art Event",
      `Event Type` %in% c("Plaza Event", "Plaza Partner Event", "Parade", "Street Event", "Farmers Market", "Sidewalk Sale", "Block Party", "Rally", "Street Festival", "Single Block Festival", "Weekend Walk") ~ "Street-based Events",
      `Event Type` %in% c("Press Conference", "Stationary Demonstration") ~ "Gathering Events",
      `Event Type` %in% c("Religious Event", "Clean-Up", "Play Streets") ~ "Volunteering Events",
      `Event Type` %in% c("Construction", "Embargo", "Rigging Permit", "Miscellaneous") ~ "Other Events",
      `Event Type` %in% c("Special Event") ~ "Special Events "
    )) 
  data_use = data_use %>%
    mutate(Event_Category = ifelse(data_use$`Event Name` %like% "COVID", "Covid Testing Site", Event_Category))
  
  ## Event borough stats
  borough_stat <- data_use %>%
    group_by(`Event Borough`) %>%
    summarize(n = n())
  
  print("Data Cleaning Complete")
  return(data_use)
}

events_data = events_data_processing("C:/Users/aakan/Downloads/NYC_Permitted_Event_Information.csv")
sum(is.na(events_data$Event_Category))

# dropping used columns
drop_columns = c("Event Street Side", "Street Closure Type", "Community Board", "Police Precinct")
events_data = events_data[,!(names(events_data) %in% drop_columns)]

# Covid Data

## Load the data
## Read in the real-time covid data

urlfile="https://raw.githubusercontent.com/nychealth/coronavirus-data/master/latest/last7days-by-modzcta.csv"
covid_data <- read_csv(url(urlfile))

## read in the data about nyc zipcode corresponding borough

urlfile = "https://raw.githubusercontent.com/nychealth/coronavirus-data/master/totals/data-by-modzcta.csv"
zipcode_borough <- read_csv(url(urlfile))
zipcode_borough = zipcode_borough[!duplicated(zipcode_borough[c(1,3)]),][,c(1,3)]

## Add the labels borough
covid_data1 = merge(x = covid_data, y = zipcode_borough, by.x = "modzcta", by.y = "MODIFIED_ZCTA", all.x = TRUE)

## Covid info by borough
covid_data2 = covid_data1[,c(7,8,12)]
covid_borough <- aggregate(cbind(people_tested = covid_data2$people_tested, people_positive = covid_data2$people_positive), by=list(borough=covid_data2$BOROUGH_GROUP), FUN=sum)

covid_borough = covid_borough %>%
  mutate(percentpositivity_7day = round(people_positive/people_tested,5)*100)

## All time covid data
all_time_covid = read.csv('https://data.cityofnewyork.us/resource/rc75-m7u3.csv')
nrow(all_time_covid)
all_time_covid[['date_of_interest']] <- strptime(all_time_covid[['date_of_interest']],
                                      format = "%Y-%m-%dT%H:%M:%S")
## Exporting processed files
write.table(events_data, "../data/events_data.csv", row.names=FALSE, col.names=TRUE, sep=",")
write.table(covid_borough, "../data/covid_borough.csv", row.names=FALSE, col.names=TRUE, sep=",")
write.table(all_time_covid, "../data/all_time_covid.csv", row.names=FALSE, col.names=TRUE, sep=",")

