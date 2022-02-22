
coloring <- function(event){
  event <- event %>%
  arrange(`count_per_month`,desc=TRUE) %>%
  mutate(color = c(1:10))
  
  for(i in 1:10){
  event$color[i] <- newPalette[i]
  }
  
  left1 <- event %>%
   filter(Time == "before")
  right1 <- event %>%
   filter(Time == "after")
  
  left1 <- as.data.frame(left1)
  right1 <- as.data.frame(right1)
  
  geodataleft <- geoData
  for(i in 1:5){
    for(j in 1:5){
    if(geodataleft$features[[i]]$properties$boro_name == left1[j,1]){
       geodataleft$features[[i]]$properties$style$fillColor <- list(left1[j,4])
      }
    }
  }
  
  
  geodataright <- geoData
  for(i in 1:5){
    for(j in 1:5){
    if(geodataright$features[[i]]$properties$boro_name == right1[j,1]){
       geodataright$features[[i]]$properties$style$fillColor <- list(right1[j,4])
      }
    }
  }
  geodataright$style = list(
    weight = 0.7,
    color ="gray",
    opacity = 0.8,
    fill = TRUE,
    fillOpacity = 0.6
  )
  geodataleft$style = list(
    weight = 0.7,
    color ="gray",
    opacity = 0.8,
    fill = TRUE,
    fillOpacity = 0.6
  )
  eventgeodata <- list("left" = geodataleft,
                       "right" = geodataright)
  return(eventgeodata)
}
