# dashboard header ----
header <- dashboardHeader(
  title = "Fish Creek WatershedLake Monitoring",
  titleWidth = 400
  
) #END dashboard header

# dashboard sidebar ----
sidebar <- dashboardSidebar(
  
  #sidebarMenu ----
  sidebarMenu(
    
    menuItem(text = "Welcome",
             tabName = "welcome", #tabname is an identifier
             icon = icon("star")),
    menuItem(text = "Dashboard",
             tabName = "dashboard",
             icon = icon("gauge"))
    
  ) #END sidebar menu
  
  
) #END dashboardSidebar

#dashboard body ----
body <- dashboardBody(
  
  #set theme ----
  fresh::use_theme("fresh_theme.css"),
  
  #tabItems ----
  #tab items should match menu items
  tabItems(
    
    #welcome tab item ----
    tabItem(tabName = "welcome",
            
            #left-hand column ----
            column(width = 6,
                   
                   #left box ----
                   box(width = NULL, #set width inside specified column width to null
                       title = tagList(icon("water"),
                                       tags$strong("Monitoring Fish Creek Watershed")),
                       includeMarkdown("text/intro.md"),
                       
                       #add image:
                       tags$img(src = "watershed_map.jpeg",
                                alt = "alt text",
                                style = "max-width: 100%;" #add css styling in-line
                                ), #END image tag
                       
                       tags$h6(tags$em(
                         "Map Source:",
                         tags$a(href = "http://www.fishcreekwatershed.org",
                                "FCWO")
                       ), #END tag em
                       
                       style = "text-align: center;"  
                       
                       ) #END tag h6
                       
                       ) #END left box
                   
                   ), #END left column
            
            #right-hand column ----
            column(width = 6,
                   
                   #top fluid row ----
                   fluidRow(
                     
                     box(width = NULL,
                         
                         "data citation here"
                         
                         )#END box
                     
                   ), #END top fluid row
                   
                   #bottom fluid row ----
                   fluidRow(
                     
                     box(width = NULL,
                         
                         "disclaimer here"
                         
                         )#end box
                     
                   ) #END botton fluid row
                   
                   ) #END right column
            
              ), #END welcome tab
    
    #dashboard tab item ----
    tabItem(tabName = "dashboard",
            
            #fluidRow ----
            fluidRow(
              
              #input box ----
              box(width = 4,
                  title = tags$strong("Adjust lake parameter ranges:"),
                  
                  #sliderInput ----
                  sliderInput(inputId = "elevation_slider_input",
                              label = "Elevation (meters above SL):",
                              min = min(lake_data$Elevation),
                              max = max(lake_data$Elevation),
                              value = c(min(lake_data$Elevation),
                                        max(lake_data$Elevation))
                              
                              ) #END sliderInput
                  
                  ), #END input box
              
              #leaflet box ----
              box(width = 8,
                  
                  title = tags$strong("Monitored lakes within Fish Creek Watershed"),
                  
                  #Leaflet Output ----
                  leafletOutput(
                    outputId = "lake_map",
                  ) |> #END leaflet Output
                    withSpinner( #add spinner to show data loading
                      type = 1,
                      color = "blue"
                    ) #END spinner
                  
                  ) #END leaflet box
              
            ) #END fluidRow
            
            ) #END dashbaord tab
    
  ) #END tabItems
  
) #END dashboardBody

#combine elements ----
dashboardPage(header, sidebar, body)