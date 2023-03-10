# load packages ----
library(shiny)
library(shinyWidgets)
library(lterdatasampler)
library(tidyverse)
library(shinycssloaders)

#Wrangle data ----
#better to wrangle data in global rather than server
clean_trout <-
  and_vertebrates |> 
  filter(species == "Cutthroat trout") |> 
  select(sampledate,
         section,
         species,
         length_mm = length_1_mm,
         weight_g,
         channel_type = unittype) |> 
  mutate(
    section = case_when(
      section == "CC" ~ "clear cut forest",
      section == "OG" ~ "old growth forest"
    )
  ) |> 
  drop_na()