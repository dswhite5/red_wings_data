## function to loop through files in data folded and load into environment
##need to load tidyverse to use str_c

library(tidyverse)

tables = c('roster', 'scoring_regular_season', 'team_analytics_5v5', 'team_statistics')
years = c(2021:2008)
file_folder_location = 'data\\DET'
team_designate = 'DET'


#This is fine for Detroit, but need to update loop to incorporate other teams. Maybe update loop to find folder for each year

for (table in tables){
  for (year in years){
    year = as.character(year)
    #print(year)
    file_name = str_c(table, team_designate, year, sep='_')
    #print(file_name)
    file_locale = str_c(file_folder_location,'\\',file_name,'.csv')
    #print(file_locale)
    assign(file_name,read_csv(file_locale)) #assigns table name in R to csv file read through read csv
  }
    
}
data_descrp <- read_csv('~/R/Shiny_apps/red_wings_data/data/scoring_stat_data_description.csv')
wings_stats_combined<-read_csv('~/R/Shiny_apps/red_wings_data/data/DET/wings_stats_combined.csv')
scoring_regular_season_DET_all <- read_csv('~/R/Shiny_apps/red_wings_data/data/DET/scoring_regular_season_DET_all.csv')



