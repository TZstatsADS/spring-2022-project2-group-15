#install packages
library(tidyverse)
library(readr)


#read in the real-time data from github
urlfile="https://raw.githubusercontent.com/nychealth/coronavirus-data/master/latest/last7days-by-modzcta.csv"
covid_data<-read_csv(url(urlfile))

#
