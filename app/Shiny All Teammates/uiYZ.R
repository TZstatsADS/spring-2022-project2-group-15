shinyUI(
  fluidPage(
    sidebarLayout(
      sidebarPanel(
        fluidRow(
            selectInput("category", label = "Select Event Category:",
                        choices = event_cat),
            
            selectInput("borough", label = "Select Borough:",
                        choices = borough_nyc,selected = "Brooklyn"),
            dateRangeInput("daterange",label = "Select Date Range:",
                           start = "2019-01-01",
                           min = "2016-05-01"
                           )
            )
      ),
        
      mainPanel(
        fluidRow(
          h2("Event List"),
          dataTableOutput("event_table")),
        fluidRow(
          h2("Up-to-date Covid-19 situation"),
          tableOutput("covid_table"))
      )
    )
  ))