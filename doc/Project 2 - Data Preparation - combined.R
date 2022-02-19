library(dplyr)
library(tidyverse)
library(lubridate)
library(readr)

##deal with data
#load the data set

data <- read_csv("C:/Users/aakan/Downloads/NYC_Permitted_Event_Information.csv")
nrow(data)
str(data)

data[['Start Date/Time']] <- strptime(data[['Start Date/Time']],
                                 format = "%m/%d/%Y %H:%M:%S")
data[['End Date/Time']] <- strptime(data[['End Date/Time']],
                                      format = "%m/%d/%Y %H:%M:%S")

data <- data %>% mutate(end_year = year(data$`End Date/Time`))

#remove the repeating rows
data2 <- data %>%
  distinct()
nrow(data2)

#Keeping 2019 and above years
data3 = data2[data2$end_year > 2018,]
nrow(data3)

#remove the data with NA event id
data_rm_na_id <- data3 %>%
  filter(is.na(`Event ID`) == FALSE)

#event borough
borough_stat <- data_rm_na_id %>%
  group_by(`Event Borough`) %>%
  summarize(n = n())

#see data with NA event type
event_type_na <- data_rm_na_id %>%
  filter(is.na(`Event Type`))

#write.table(event_type_na,"data_use.csv", row.names=FALSE, col.names=TRUE, sep=",")

# Covid Data

#load the data
#read in the real-time covid data

urlfile="https://raw.githubusercontent.com/nychealth/coronavirus-data/master/latest/last7days-by-modzcta.csv"
covid_data<-read_csv(url(urlfile))

#read in the data about nyc zipcode corresponding borough
urlfile="https://data.beta.nyc/dataset/0ff93d2d-90ba-457c-9f7e-39e47bf2ac5f/resource/7caac650-d082-4aea-9f9b-3681d568e8a5/download/nyc_zip_borough_neighborhoods_pop.csv"
zipcode_borough<-read_csv(url(urlfile))

#add the labels borough
covid_data1<-cbind(covid_data,zipcode_borough[,2])

#covid by borough
covid_borough<-covid_data1 %>% 
  group_by(borough)








