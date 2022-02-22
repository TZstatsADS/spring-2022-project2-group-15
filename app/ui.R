# Define UI for application that draws a histogram
ui <- navbarPage(strong("Events NYC"), collapsible = TRUE, inverse = TRUE, theme = shinytheme("superhero"),
                 tabPanel("Home", icon = icon("home"), 
                          fluidPage(
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            style = "background-image: url('https://upload.wikimedia.org/wikipedia/commons/4/47/New_york_times_square-terabass.jpg');
                       background-repeat:no-repeat;
                       background-size:cover;
                       opacity: 0.8;
                       background-position :center;"
                          ),
                          mainPanel(
                            br(),
                            h1("Where to Go After School/Work in NYC?"),
                            br(),
                            br(),
                            p("- Covid-19 affects people's daily life in all kinds of aspects.",
                              style = "font-size: 20px"),
                            br(),
                            p("- As there're so many events and activities taking place everyday in NYC, 
                 are people's leisure life affected seriously by the epidemic?",
                              style = "font-size: 20px" ),
                            br(),
                            p("- What to do or where to go for pleasure under the serious epidemic condition?",
                              style = "font-size: 20px")
                          )
                 ),
                 tabPanel(strong("Summary"),
                          icon = icon("chart-bar"),
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
                 tabPanel(strong("Geo Maps"),
                          icon = icon("bandcamp"),
                          div(class = 'outer',
                              splitLayout(cellWidths = c("50%", "50%"), 
                                          leafletOutput("left_map",width="100%",height=1200),
                                          leafletOutput("right_map",width="100%",height=1200))),
                          
                          absolutePanel(
                            id = "selection", class = "panel panel-default", fixed = TRUE, draggable = TRUE,
                            top = 200, left = 50, right = "auto", bottom = "auto", width = 285, height = "auto",
                            tags$h4('Count of Events in NYC Taking Place', align = "center"),
                            tags$h5('Pre-covid(Left)/ During covid(Right)', align = "center"), 
                            selectInput(
                              "Event_Type",
                              label = h5("Event Type",align = "center"), 
                              choices = list("--",
                                             "Sports",
                                             "Art", 
                                             "Street-based Event",
                                             "Volunteering",
                                             "Special Event"),
                              
                            ),
                            style = "opacity: 0.80"
                          )),
                 tabPanel(strong("Event Details"),
                          icon = icon("running"),
                          fluidPage(
                            sidebarLayout(
                              sidebarPanel(width = 2,
                                fluidRow(
                                  selectInput("category", label = "Select Event Category:",
                                              choices = event_cat),
                                  
                                  selectInput("Borough", label = "Select Borough:",
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