server <- function(input, output) {
  
  #create reactive df ----
  trout_filtered_df <-
    reactive({
      
      validate(
        need(
          length(input$channel_type_input) > 0, "Select at least one channel type to display data."
        ), #need returns statement if conditional is FALSE
        need(
          length(input$section_input) > 0, "Select at least one forest section type to display data."
        )
      )
      
        clean_trout |> 
        filter(
          channel_type %in% c(input$channel_type_input)
        ) |> 
        filter(
          section %in% c(input$section_input)
        )
     }
    )
  
  #plot trout output ----
  output$trout_scatterplot <-
    renderPlot({
      ggplot(
        trout_filtered_df(),
        aes(x = length_mm,
            y = weight_g,
            color = channel_type
        )
      ) +
        geom_point(
          alpha = 0.7,
          size = 5
        ) +
        scale_color_manual(
          values = c("R" = "blue",
                     "C" = "purple",
                     "S" = "black",
                     "P" = "yellow",
                     "SC" = "pink",
                     "I" = "orange",
                     "IP" = "red"
          )
        )
      
    }, alt = "interactive visualization of trout cutthroat trout weigths by length"
    ) #END renderPlot output

  
}