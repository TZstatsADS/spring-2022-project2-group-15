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

events_data = read.csv('events_data.csv')
events_data[['Start.Date.Time']] <- strptime(events_data[['Start.Date.Time']],
                                             format = "%Y-%m-%d %H:%M:%S")
events_data[['End.Date.Time']] <- strptime(events_data[['End.Date.Time']],
                                           format = "%Y-%m-%d %H:%M:%S")

all_time_covid = read.csv('all_time_covid.csv')
all_time_covid[['date_of_interest']] <- strptime(all_time_covid[['date_of_interest']],
                                                 format = "%Y-%m-%d")

covid_borough = read.csv('covid_borough.csv')

# Creating menu options

event_cat <- unique(events_data$Event_Category)
borough_nyc <- unique(events_data$Event.Borough)


# Define UI for application that draws a histogram
ui <- navbarPage("Events NYC", collapsible = TRUE, inverse = TRUE, theme = shinytheme("superhero"),
                 tabPanel("Summary",
                          fluidPage(
                            
                            # Application title
                            titlePanel("Events Summary for NYC in COVID"),
                            
                            # Sidebar with dropdown
                            
                            sidebarLayout(
                              sidebarPanel(
                                selectInput(inputId = "event_cat", choices = event_cat,
                                            label = "Select Event Category", multiple = FALSE),
                                selectInput(inputId = "borough", choices = borough_nyc,
                                            label = "Select Borough", multiple = FALSE),
                                width = 2
                              ),
                              
                              # Show a plot of the generated distribution
                              mainPanel(
                                fluidRow(
                                  splitLayout(cellWidths = c("100%"), plotOutput("Plot1"))
                                ),
                                fluidRow(
                                  splitLayout(cellWidths = c("30%","70%"), plotOutput("Plot2"), plotOutput("Plot3"))
                                ),
                                fluidRow(
                                  splitLayout(cellWidths = c("100%"), plotOutput("Plot4"))
                                ),
                                width = 8
                              )
                            ))
                 ),
                 tabPanel("Geo Maps"),
                 tabPanel("Event Details")
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$Plot1 <- renderPlot({
    data = events_data[events_data$Event_Category == input$event_cat & events_data$Event.Borough == input$borough,]
    plt_data = setNames(data.frame(table(date(data$End.Date.Time))),c("End_Date","Event_Count"))
    
    ggplot(data = plt_data, mapping = aes(x = date(End_Date), y = Event_Count)) + 
      geom_line(color = "blue") +
      scale_shape_tableau() +
      scale_x_date(date_breaks = "1 month", date_labels =  "%b %Y", limits = as.Date(c("2019-01-01", "2022-12-31"))) +
      labs(x = "Date", y = "Number of Events")+
      theme(axis.text.x=element_text(angle=90, hjust=1)) 
  })
  
  output$Plot2 <- renderPlot({
    data = events_data[events_data$Event_Category == input$event_cat & events_data$Event.Borough == input$borough,]
    
    ggplot(data = data, mapping = aes(x = end_year, color=end_year)) + 
      geom_bar() +
      scale_shape_tableau() +
      labs(x = "Year", y = "Number of Events")+
      theme(axis.text.x=element_text(angle=0, hjust=1)) 
  })
  
  output$Plot3 <- renderPlot({
    data = events_data[events_data$Event_Category == input$event_cat & events_data$Event.Borough == input$borough,]
    plt_data = setNames(data.frame(table(month(data$End.Date.Time), data$end_year)),c("Month","Year", "Event_Count"))
    
    ggplot(data = plt_data, mapping = aes(x = Month, y = Event_Count, group=Year, color = Year)) + 
      geom_line(size=1) +
      scale_shape_tableau() +
      labs(x = "Month", y = "Number of Events")+
      theme(axis.text.x=element_text(angle=0, hjust=1)) +
      theme(legend.position = c(0.1, 0.8))
  })
  
  output$Plot4 <- renderPlot({
    plt_data = setNames(aggregate(all_time_covid$case_count, list(date(all_time_covid$date_of_interest)), sum), c("Date","Case_Count"))
    
    ggplot(data = plt_data, mapping = aes(x = Date, y = Case_Count)) + 
      geom_line(size = 1, color = 'maroon') +
      scale_shape_tableau() +
      labs(x = "Dates", y = "Number of COVID Cases")+
      theme(axis.text.x=element_text(angle=0, hjust=1)) +
      theme(legend.position = c(0.1, 0.8))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

