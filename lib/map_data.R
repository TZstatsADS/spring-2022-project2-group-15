map_data <- function(event_type){
  event_left <- data_use %>%
    filter(`Event_Category` == event_type) %>%
    filter(year(`Start Date/Time`) == 2019 |
             (year(`Start Date/Time`) == 2020 & month(`Start Date/Time`) < 5)) %>%
    group_by(`Event Borough`) %>%
    summarize(count_per_month = n()/16) %>%
    mutate(`Time` = "before")
  
  event_right <- data_use %>%
    filter(`Event_Category` == event_type) %>%
    filter(year(`Start Date/Time`) > 2020 |
             (year(`Start Date/Time`) == 2020 & month(`Start Date/Time`) >= 5)) %>%
    group_by(`Event Borough`) %>%
    summarize(count_per_month = n()/32) %>%
    mutate(`Time` = "after")
  event <- rbind(event_left, event_right)
  return(event)
}