#load libraries
library(fresh)

create_theme(
  
  adminlte_color( #define primary color of dashboard
    light_blue ="#ad03fc"  #shiny dashboard only recognizes some skin colors
  ),
  adminlte_global(
    content_bg = "#fac8ea" #body background
  ),
  adminlte_sidebar(
    width = "400px",
    dark_bg = "#e8d2fc",
    dark_hover_bg = "#eb1ceb",
    dark_color = "#d10687"
  ),
  
  output_file = "shiny-dashboard/www/fresh_theme.css"
  
  
) #END create theme