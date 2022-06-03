## function to loop through files in data folded and load into environment
##need to load tidyverse to use str_c

library(tidyverse)


data_descrp <- read_csv('~/R/Shiny_apps/red_wings_data/data/scoring_stat_data_description.csv') #table with description for each variable in the stats and scoring data sets
wings_stats_combined<-read_csv('~/R/Shiny_apps/red_wings_data/data/DET/wings_stats_combined.csv') # table wtih statistics for the Team detroit redwings for seasons 2008 to 2021
scoring_regular_season_DET_all <- read_csv('~/R/Shiny_apps/red_wings_data/data/DET/scoring_regular_season_DET_all.csv') # table with stats for players on redwings from 2008 to 2021



