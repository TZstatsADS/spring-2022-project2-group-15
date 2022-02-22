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
      theme(axis.text.x=element_text(angle=90, hjust=1), plot.title = element_text(size = 16, face = "bold")) +
      ggtitle("Timeline of Number of Events [2019 - 2022]")
  })
  
  output$Plot2 <- renderPlot({
    data = events_data[events_data$Event_Category == input$event_cat & events_data$Event.Borough == input$borough,]
    
    ggplot(data = data, mapping = aes(x = end_year, color=end_year)) + 
      geom_bar() +
      scale_shape_tableau() +
      labs(x = "Year", y = "Number of Events")+
      theme(axis.text.x=element_text(angle=0, hjust=1), plot.title = element_text(size = 16, face = "bold")) +
      ggtitle("Year-over-Year Number of Events")
  })
  
  output$Plot3 <- renderPlot({
    data = events_data[events_data$Event_Category == input$event_cat & events_data$Event.Borough == input$borough,]
    plt_data = setNames(data.frame(table(month(data$End.Date.Time), data$end_year)),c("Month","Year", "Event_Count"))
    
    ggplot(data = plt_data, mapping = aes(x = Month, y = Event_Count, group=Year, color = Year)) + 
      geom_line(size=1) +
      scale_shape_tableau() +
      labs(x = "Month", y = "Number of Events")+
      theme(axis.text.x=element_text(angle=0, hjust=1)) +
      theme(legend.position = c(0.1, 0.8), plot.title = element_text(size = 16, face = "bold")) +
      ggtitle("Month-over-month comparison") +
      scale_x_discrete(limit = c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"), 
                       labels = c("Jan","Feb","Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))
    
  })
  
  output$Plot4 <- renderPlot({
    plt_data = setNames(aggregate(all_time_covid$case_count, list(date(all_time_covid$date_of_interest)), sum), c("Date","Case_Count"))
    
    ggplot(data = plt_data, mapping = aes(x = Date, y = Case_Count)) + 
      geom_line(size = 1, color = 'maroon') +
      scale_shape_tableau() +
      labs(x = "Dates", y = "Number of COVID Cases")+
      theme(axis.text.x=element_text(angle=0, hjust=1), plot.title = element_text(size = 16, face = "bold")) +
      ggtitle("NYC Covid cases Trendline")
  })
  
  output$event_table = renderDataTable(
    events_data[(events_data$Event_Category == input$category) & (events_data$Event.Borough == input$Borough) 
                & (events_data$Start.Date.Time>=input$daterange[1]&(events_data$End.Date.Time<=input$daterange[2])),c(1,2,3,4,5,6,7,8,10)],
    options = list(
      pageLength=5,
      autoWidth=T,
      scrollX=T)
  )
  
  output$covid_table = renderTable(
    rbind(covid_borough[covid_borough$borough == input$Borough,],covid_city)
    )
}


