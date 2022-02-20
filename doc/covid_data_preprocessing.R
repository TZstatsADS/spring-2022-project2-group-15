#install packages
library(tidyverse)
library(readr)
library(dplyr)

#load the data
#read in the real-time covid data
urlfile="https://raw.githubusercontent.com/nychealth/coronavirus-data/master/latest/last7days-by-modzcta.csv"
covid_data<-read_csv(url(urlfile))

#read in the data about nyc zipcode corresponding borough
urlfile="https://data.beta.nyc/dataset/0ff93d2d-90ba-457c-9f7e-39e47bf2ac5f/resource/7caac650-d082-4aea-9f9b-3681d568e8a5/download/nyc_zip_borough_neighborhoods_pop.csv"
zipcode_borough<-read_csv(url(urlfile))

#add the label-borough
covid_data1<-cbind(covid_data,zipcode_borough[,2])

#calculate the postivity percentage by borough
covid_data1$percentpositivity_7day<-as.numeric(covid_data1$percentpositivity_7day)
covid_borough<-covid_data1 %>% 
  group_by(borough) %>%
  summarize(average_positive_rate=round(mean(percentpositivity_7day),2))

#store the date range
daterange<-covid_data1[1,"daterange"]
daterange

write.table(covid_data1,file="covid_data_zipcode.csv",row.names=FALSE,col.names=TRUE,sep=",")
write.table(covid_borough,file="covid_data_borough.csv",row.names=FALSE,col.names=TRUE,sep=",")

