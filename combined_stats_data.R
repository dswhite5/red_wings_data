#Hockey Project
#Create combined Statistics data set

library(tidyverse)

team_analytics_combined <- bind_rows(team_analytics_5v5_DET_2008,
                                     team_analytics_5v5_DET_2009,
                                     team_analytics_5v5_DET_2010,
                                     team_analytics_5v5_DET_2011,
                                     team_analytics_5v5_DET_2012,
                                     team_analytics_5v5_DET_2013,
                                     team_analytics_5v5_DET_2014,
                                     team_analytics_5v5_DET_2015,
                                     team_analytics_5v5_DET_2016,
                                     team_analytics_5v5_DET_2017,
                                     team_analytics_5v5_DET_2018,
                                     team_analytics_5v5_DET_2019,
                                     team_analytics_5v5_DET_2020, 
                                     team_analytics_5v5_DET_2021)%>%
  filter(Team == 'Detroit Red Wings')%>%
  mutate(year = c(2008:2021))%>%
  rename(`S% 5v5` = `S%`,
         `SV% 5v5` = `SV%`,
         `PDO 5v5` = `PDO`,
         `GF 5v5` = `aGF`, 
         `GA 5v5` = `aGA`)

team_statistics_combined <- bind_rows(team_statistics_DET_2008,
                                      team_statistics_DET_2009,
                                      team_statistics_DET_2010,
                                      team_statistics_DET_2011,
                                      team_statistics_DET_2012,
                                      team_statistics_DET_2013,
                                      team_statistics_DET_2014,
                                      team_statistics_DET_2015,
                                      team_statistics_DET_2016,
                                      team_statistics_DET_2017,
                                      team_statistics_DET_2018,
                                      team_statistics_DET_2019,
                                      team_statistics_DET_2020, 
                                      team_statistics_DET_2021)%>%
  filter(Team == 'Detroit Red Wings')%>%
  mutate(year = c(2008:2021))

wings_stats_combined<-team_analytics_combined%>%
  inner_join(team_statistics_combined, by = c('year', 'Team'))%>%
  select(!c(`xGF`,`xGA`,`axDiff`:`HDCO%`,`GP`))%>% #these stats werent recorded until 2017 season, so removed from dataset
  mutate(year = round(year))


scoring_regular_season_DET_all <- bind_rows(scoring_regular_season_DET_2008,
                                        scoring_regular_season_DET_2009,
                                        scoring_regular_season_DET_2010,
                                        scoring_regular_season_DET_2011,
                                        scoring_regular_season_DET_2012,
                                        scoring_regular_season_DET_2013,
                                        scoring_regular_season_DET_2014,
                                        scoring_regular_season_DET_2015,
                                        scoring_regular_season_DET_2016,
                                        scoring_regular_season_DET_2017,
                                        scoring_regular_season_DET_2018,
                                        scoring_regular_season_DET_2019,
                                        scoring_regular_season_DET_2020,
                                        scoring_regular_season_DET_2021)

#write_csv(wings_stats_combined, '~/R/Shiny_apps/red_wings_data/data/DET/wings_stats_combined.csv')
#write_csv(scoring_regular_season_DET_all, '~/R/Shiny_apps/red_wings_data/data/DET/scoring_regular_season_DET_all.csv')

# team analytics 5 v 5

# S% -- Shooting percentage at 5-on-5
# SV% -- Save percentage at 5-on-5
# PDO -- PDO
# Shooting % + Save %
#   CF -- Corsi For at 5 on 5
# Shots + Blocks + Misses
# CA -- Corsi Against at 5 on 5
# Shots + Blocks + Misses
# CF% -- Corsi For % at 5 on 5
# CF / (CF + CA)
# Above 50% means the team was controlling the
# puck more often than not with this player on the
# ice in this situation.
# xGF -- 'Expected Goals For' given where shots came from, for and against, while this player was on the ice at even strength.
# It's based on where the shots are coming from, compared to the league-wide shooting percentage for that shot location.
# xGA -- 'Expected Goals Against' given where shots came from, for and against, while this player was on the ice at even strength.
# It's based on where the shots are coming from, compared to the league-wide shooting percentage for that shot location.
# aGF -- Actual goals for (5-on-5)
#   aGA -- Actual goals against (5-on-5)
# axDiff -- Actual goal differential minus expected goal differential. A positive differential would indicate a team is converting or stopping an inordinate amount of good chances compared to league average. A negative differential would indicate a team is getting more good chances, but not converting or is allowing more than league norms.
# SCF -- Scoring chances for. Scoring chances are all shot attempts from within a certain range from the net.
# SCA -- Scoring chances against
# SCF% -- Percentage of scoring chances in this team's favor
# HDF -- High-danger scoring chances for. High-danger chances include shot attempts from the 'slot' area and rebounds, approximately.
# HDA -- High-danger scoring chances against
# HDF% -- Percentage of high-danger scoring chances in this team's favor
# HDGF -- High-danger scoring chances for that lead to goals
# HDC% -- Percentage of high-danger scoring chances that are converted to goals, for this team
# HDGA -- High-danger scoring chances against that lead to goals
# HDCO% -- Percentage of high-danger scoring chances that are converted to goals, for this team's opponents


#team Statistics

# AvAge -- Average age of team weighted by time on ice.
# GP -- Games Played
# W -- Wins
# L -- Losses
# OL -- Overtime/Shootout Losses (2000 season onward)
# PTS -- Points
# PTS% -- Points percentage (i.e., points divided by maximum points)
# GF -- Goals For
# GA -- Goals Against
# SRS -- Simple Rating System; a team rating that takes into account average goal differential and strength of schedule. The rating is denominated in goals above/below average, where zero is average.
# SOS -- Strength of Schedule; a rating of strength of schedule. The rating is denominated in goals above/below average, where zero is average.
# GF/G -- Goals For Per Game
# GA/G -- Goals Against Per Game
# PP -- Power Play Goals
# PPO -- Power Play Opportunities
# PP% -- Power Play Percentage
# PPA -- Power Play Goals Against
# PPOA -- Power Play Opportunities Against
# PK% -- Penalty Killing Percentage
# SH -- Short-Handed Goals
# SHA -- Short-Handed Goals Against
# S -- Shots on Goal
# S% -- Shooting Percentage
# SA -- Shots Against
# SV% -- Save Percentage
# PDO -- PDO
# Shooting % + Save %
#   SO -- Shutouts
