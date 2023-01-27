#load packages
library(palmerpenguins)
library(tidyverse)
library(DT)

#filter data ----
body_mass_df <-
  penguins |> 
  filter(body_mass_g %in% 3000:4000) #filter for observations with body mass between 3-4 thousand



#plot

ggplot(na.omit(body_mass_df), #get rid of all na rows in penguins dataset
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

# practice with creating a datatable
DT::datatable(penguins)

#make new df with year filter
filtered_years <- penguins |> 
  filter(year %in% c(2007, 2008))

DT::datatable(filtered_years)


