# load packages ----
library(shiny)
library(palmerpenguins)
library(tidyverse)
library(DT)

# ui ----
ui <- fluidPage(
  
  #app title ----
  tags$h1("My app title"), #add html tags with R `tags` OR h1("title")
  
  #app subtitle ----
  tags$p(tags$strong("Exploring Antarctic Penguin Data")),
  
  #body mass slider input ----
  sliderInput(inputId = "body_mass_slider",
              label = "Select a range of penguin body masses (g): ",
              min = 2700,
              max = 6300, #hardcoding min and max isn't best practice!
              value = c(3000, 4000) #default values
              ), #END sliderInput
  
  #body mass plot output ----
  plotOutput(outputId = "body_mass_scatterplot"),
  
  # year checkbock input ----
  checkboxGroupInput(
    inputId = "year_checkbox",
    label = "Year",
    choices = c(2007, 2008, 2009),
    selected = c(2007, 2008)),
  
  # year checkbox output ----
  DT::dataTableOutput(outputId = "year_table")
  
) #END fluidPage

# server ----
server <- function(input, output) {
  
  # filter data ----
  body_mass_df <-
    #create reactive data frame
    reactive({
      penguins |> 
        filter(body_mass_g %in% input$body_mass_slider[1]:input$body_mass_slider[2])
    })

  #render scatter plot ----
  output$body_mass_scatterplot <-
    renderPlot({
      #code to generate plot
      ggplot(na.omit(body_mass_df()),
             aes(x = flipper_length_mm,
                 y = bill_length_mm,
                 color = species,
                 shape = species)) +
        geom_point() +
        scale_color_manual(values = c(
          "Adelie" = "#FEA346",
          "Chinstrap" = "#B251F1",
          "Gentoo" = "#4BA4A4")) +
        scale_shape_manual(values = c(
          "Adelie" = 19,
          "Chinstrap" = 17,
          "Gentoo" = 15
        ))
      
    }) #END render scatter plot
  
  #reactive filter DF
  filtered_years <- reactive({
    penguins |> 
      filter(year %in% c(input$year_checkbox))
  })
  
  #render data table ----
  output$year_table <-
    renderDT({
      DT::datatable(filtered_years())
    }) #END render data table
  
} #END server

# combine ui and server ----
shinyApp(ui = ui,
         server = server)

