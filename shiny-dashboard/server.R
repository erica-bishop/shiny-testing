server <- function(input, output) {
  
  #filter lake data ----
  filtered_lakes <- reactive({
    lake_data |> #start with data from global
      filter(Elevation >= input$elevation_slider_input[1] & Elevation <= input$elevation_slider_input[2])
    
  }) #end reactive df
  
  #build leaflet map ----
  output$lake_map <- renderLeaflet({
    
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
      addMarkers(data = filtered_lakes(),
                 lng = filtered_lakes()$Longitude,
                 lat = filtered_lakes()$Latitude,
                 popup = paste( #add labels with popup
                   "Site Name:", filtered_lakes()$Site, "<br>", #add breaks in paste function
                   "Elevation:", filtered_lakes()$Elevation, "meters (above SL)", "<br>",
                   "Avg Depth:", filtered_lakes()$AvgDepth, "meters", "<br>",
                   "Avg Lake Bed Temperature:", filtered_lakes()$AvgTemp, "°C"
                 )) 
    
  }) #END renderLeaflet
  
} #END Server