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
                            ))),
                 tabPanel("Geo Maps"),
                 tabPanel("Event Details",
                          fluidPage(
                            sidebarLayout(
                              sidebarPanel(width = 2,
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
                            )))
)