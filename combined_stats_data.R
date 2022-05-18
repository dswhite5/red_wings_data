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
  select(!c(`xGF`,`xGA`,`axDiff`:`HDCO%`,`GP`)) #these stats werent recorded until 2017 season, so removed from dataset