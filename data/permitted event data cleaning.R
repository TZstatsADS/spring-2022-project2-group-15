library(dplyr)
library(tidyverse)
library(lubridate)

##deal with data
#load the data set
data <- read_csv("/Users/fuchengliu/Desktop/project 2/NYC_Permitted_Event_Information.csv")

#remove the repeating rows
data2 <- data %>%
  distinct()
#remove the data with NA event id
data_rm_na_id <- data2 %>%
  filter(is.na(`Event ID`) == FALSE)


#event borough
borough_stat <- data_rm_na_id %>%
  group_by(`Event Borough`) %>%
  summarize(n = n())

#see data with NA event type
event_type_na <- data_rm_na_id %>%
  filter(is.na(`Event Type`))

#deal with the NA event
e21124 <- unlist(strsplit(event_type_na$`Event Name`, split = "|", fixed = T))
e21124 <- c(21124, e21124)
e21124[3] <- c("08/28/2010 01:00 PM")
data_use <- rbind(data_rm_na_id, e21124) %>%
  filter(is.na(`Event Type`) == FALSE) %>%
  arrange(`Event ID`)

write.table(data_use,"data_use.csv",row.names=FALSE,col.names=TRUE,sep=",")

#choose data from 2019 to 2021
data_final <- data_use %>%
  mutate(Year = substr(`Start Date/Time`,7,10)) %>%
  dplyr::select(`Event ID`,`Event Name`, Year, `Event Agency`, `Event Type`, `Event Borough`, `Event Location`) %>%
  arrange(Year) %>%
  filter(Year >= 2019) %>%
  distinct()