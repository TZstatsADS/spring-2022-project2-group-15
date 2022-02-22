shinyUI(
  navbarPage(
    strong("Daily Life in NYC",style="color: white;"), 
    theme=shinytheme("cosmo"),

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
    
    tabPanel("Events", 
             icon = icon("running"),
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
             )
             
            
    )
      
)
)