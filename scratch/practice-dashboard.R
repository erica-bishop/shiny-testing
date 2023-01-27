#load packages
library(tidyverse)
library(leaflet)

#read in raw data ----
lake_monitoring_data <- read_csv("raw-data/FCWO_lakemonitoringdata_2011_2022_daily.csv")

#calculate averages ----
avg_depth_temp <- lake_monitoring_data |> 
  select(Site, Depth, BedTemperature) |> 
  filter(Depth != "NaN") |> 
  drop_na(BedTemperature) |> #specifying column makes this function only drop rows where na is in that variable (otherwise would drop rows with nas in any column)
  group_by(Site) |> 
  summarize(
    AvgDepth = round(mean(Depth), 1),
    AvgTemp = round(mean(BedTemperature), 1)
  )

#join averages to lake monitoring data ----

lake_monitoring_data <- full_join(lake_monitoring_data, avg_depth_temp)

unique_lakes <- lake_monitoring_data |> 
  select(Site, Latitude, Longitude, Elevation, AvgDepth, AvgTemp) |> 
  distinct() #pull out distinct rows

write_csv(unique_lakes, "shiny-dashboard/data/lake_data_processed.csv")

