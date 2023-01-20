ui <- navbarPage(
  
  title = "LTER Animal Data Explorer",
  
  #page 1: intro tab pabel ----
  tabPanel(
    title = "About this App",
    "Background info here"
  ), #End p1 intro tab
 
  #Page 2: data tab panel ----
  tabPanel(
    title = "Explore the Data",
    
    #tabset panel ----
    tabsetPanel(
      
      #trout tab ----
      tabPanel(
        title = "Trout",
        
        #trout sidebar ----
        sidebarLayout(
          
          #trout sidebarpanel ----
          sidebarPanel(
            
            # channel type picker input ----
            shinyWidgets::pickerInput(
              inputId = "channel_type_input",
              label = "Select channel type",
              choices = unique(clean_trout$channel_type),
              options = pickerOptions(actionsBox = TRUE),
              selected = c("C", "S"),
              multiple = TRUE #allows multiple options at once
            ), #END picker input
            
            #checkbox group button input ----
            shinyWidgets::checkboxGroupButtons(
              inputId = "section_input",
              label = "Select sampling section",
              choices = unique(clean_trout$section),
              selected = c("clear cut forest"),
              individual = FALSE,
              justified = TRUE,
              checkIcon = list(
                yes = icon("ok", lib = "glyphicon"),
                no = icon("remove", lib = "glyphicon")
              )
              
            ) #END checkboxgroupinputs
            
          ), #END trout sidebarPanel
          
          #trout mainpanel ----
          mainPanel(
            
            plotOutput(
              outputId = "trout_scatterplot"
              
            ) #END plot output
            
          ) #END trout mainPanel
          
        ) #END sidebarlayout
        
      ), #END trout tab panel
      
      #penguin tab ----
      tabPanel(
        title = "Penguins",
        
        #penguins sidebar ----
        sidebarLayout(
          
          #Penguin sidebarpanel ----
          
          sidebarPanel(
            
            "penguin inputs here"
            
          ), #END penguin sidebar panel
          
          mainPanel(
            
            "penguin outputs here"
            
          ) #END penguin main panel
          
        )#END penguins sidebarlayout
        
      ) #END penguin tab panel
      
    ) #END tabset Panel
    
  ) #END p2 data tab
  
  

  
) #END navbar page