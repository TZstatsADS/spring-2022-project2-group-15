#install.packages("shiny")
library(shiny)
library(dplyr)
library(tidyverse)
library(lubridate)
library(readr)
library(data.table)
library(stringr)
library(ggthemes)
library(shinythemes)
library(rsconnect)

shinyServer(function(input, output) {
  output$event_table = renderDataTable(
    #datatable(events_data, filter=list())
    events_data[(events_data$Event_Category == input$category) & (events_data$Event.Borough == input$borough) 
                & (events_data$Start.Date.Time>=input$daterange[1]&(events_data$End.Date.Time<=input$daterange[2])),c(1,2,3,4,5,6,7,8,10)],
    options = list(
      pageLength=5,
      autoWidth=T,
      scrollX=T
      )
  )
  output$covid_table = renderTable(
    rbind(covid_borough[covid_borough$borough == input$borough,],covid_city)
    
    
  )
})

