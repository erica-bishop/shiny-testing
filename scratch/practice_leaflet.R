#load library
library(tidyverse)
library(leaflet)

#read in processed data
filtered_lakes <- read_csv("shiny-dashboard/data/lake_data_processed.csv")


leaflet() |> #initialize leaflet
  
  #add tiles
  addProviderTiles("Esri.WorldImagery") |> 
  #set view to area of interest
  setView(lng = -152,
          lat = 70,
          zoom = 6) |> 
  #add mini map
  addMiniMap(toggleDisplay = TRUE,
             minimized = TRUE) |> 
  #add markers
  addMarkers(data = filtered_lakes,
             lng = filtered_lakes$Longitude,
             lat = filtered_lakes$Latitude,
             popup = paste( #add labels with popup
               "Site Name:", filtered_lakes$Site, "<br>", #add breaks in paste function
               "Elevation:", filtered_lakes$Elevation, "meters (above SL)", "<br>",
               "Avg Depth:", filtered_lakes$AvgDepth, "meters", "<br>",
               "Avg Lake Bed Temperature:", filtered_lakes$AvgTemp, "°C"
             )) 

#practice filtering
lakes_new <- filtered_lakes |> 
  filter(AvgTemp >= 4 & AvgTemp <= 6)



