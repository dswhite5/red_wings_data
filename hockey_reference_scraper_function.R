## function for scraping hockeyreference.com

library(tidyverse)
library(rvest)

hockey_scraper<-function(website, file_folder_location){
  web_page <- read_html(website)
  
  #roster information scraping starts here
  #finds html objects from indicated website and scrapes data information
  
  player_number <- web_page %>%
    html_nodes("#roster tbody th") %>%
    html_text() %>%
    as.numeric()
  
  player_position <- web_page %>%
    html_nodes("#roster td:nth-child(4)") %>%
    html_text()
  
  player_name <- web_page %>%
    html_nodes("#roster a") %>%
    html_text()
  
  player_age <- web_page %>%
    html_nodes("#roster .center+ td.center") %>%
    html_text() %>%
    as.numeric()
  
  player_height <- web_page %>%
    html_nodes("#roster .right:nth-child(6)") %>%
    html_text()
  
  player_weight <- web_page %>%
    html_nodes("#roster .right+ .right") %>%
    html_text() %>%
    as.numeric()
  
  player_shoots <- web_page %>%
    html_nodes("#roster .right~ .right+ .center") %>%
    html_text()
  
  player_exp <- web_page %>%
    html_nodes("#roster .right:nth-child(9)") %>%
    html_text() %>%
    as.numeric()
  
  player_birth_date <- web_page %>%
    html_nodes("#roster .right+ .left") %>%
    html_text()
  
  #creates tibble of data collected called roster
  
  roster <- tibble(Number = player_number,
                   Name = player_name,
                   Position = player_position,
                   Age = player_age,
                   Height = player_height,
                   weight = player_weight,
                   Shoots = player_shoots,
                   Experience = player_exp,
                   Birth_Date = player_birth_date
                   )

  #team stats scraping starts here
  #finds html objects from indicated website and scrapes data information
  
  team_stats <- web_page %>%
    html_nodes("#team_stats tr:nth-child(1) td , #team_stats tbody tr:nth-child(1) .left") %>%
    html_text()
  
  team_stats_labels <- web_page %>%
    html_nodes("#team_stats .poptip") %>%
    html_text()
  
  team_stats_league_average <- web_page %>%
    html_nodes("#team_stats tr+ tr .right , #team_stats tr+ tr .left") %>%
    html_text()
  
  #this code creates tibble of data collected and then rotates table to appropriate format, lose tibble format and becomes data frame in transition
  
  team_statistics <- tibble(labels = team_stats_labels,
                            Team_Stats = team_stats,
                            League_Ave = team_stats_league_average
  )
  
  team_statistics<-team_statistics %>%    #transposes tibble
    t()%>%
    data.frame()
  
  names(team_statistics) <- team_statistics[1,]   # the next two take the top row of data frame and convert it to variable names
  
  team_statistics <- team_statistics[-1,]
  
  #Team analytics spread sheet scraping starts here
  #finds html objects from indicated website and scrapes data information
  
  #Thia downloads all of the data from the team row
  
  team_analytics_team <- web_page %>%
    html_nodes("#team_stats_adv tbody tr:nth-child(1) .left , #team_stats_adv tr:nth-child(1) td") %>%
    html_text()
  
  #This downloads all of the data from the league row
  team_analytics_league <- web_page %>%
    html_nodes("#team_stats_adv tr+ tr .right , #team_stats_adv tr+ tr .left") %>%
    html_text()
  
  #this downloads the column labels
  team_analytics_label <- web_page %>%
    html_nodes("#team_stats_adv .poptip") %>%
    html_text()
  
  #this code creates tibble of dtat collected and then rotates table to appropriate format, lose tibble format and becomes data frame in transition
  
  team_analytics_5v5 <- tibble(labels = team_analytics_label,
                               Team_Analytics = team_analytics_team,
                               League_Ave_analytics = team_analytics_league
  )
  
  #this transposes data_frame to proper orientation
  team_analytics_5v5<-team_analytics_5v5 %>%
    t()%>%
    data.frame()
  
  #Changes labels from row to labels in new tibble and then changes number data from characters to numeric type data
  names(team_analytics_5v5) <- team_analytics_5v5[1,]
  
  team_analytics_5v5 <- team_analytics_5v5[-1,]
  
  team_analytics_5v5 <- team_analytics_5v5%>%
    as_tibble()%>%
    mutate_at(c(2:22), ~ as.numeric(.))
  
    
  #Regular season scoring starts here
  #finds html objects from indicated website and scrapes data information
  
  player_rank <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(1)")%>%
    html_text()%>%
    as.numeric()
  
  player_name_scoring <- web_page%>%
    html_nodes("#skaters a")%>%
    html_text()
  
  player_games <- web_page%>%
    html_nodes("#skaters tbody .center+ .right")%>%
    html_text()%>%
    as.numeric()
  
  player_goals_total <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(6)")%>%
    html_text()%>%
    as.numeric()
  
  player_assists_total <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(7)")%>%
    html_text()%>%
    as.numeric()
  
  player_points <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(8)")%>%
    html_text()%>%
    as.numeric()
  
  player_plusminus <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(9)")%>%
    html_text()%>%
    as.numeric()
  
  player_penalty_minutes <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(10)")%>%
    html_text()%>%
    as.numeric()
  
  player_goals_even <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(11)")%>%
    html_text()%>%
    as.numeric()
  
  player_goals_PP <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(12)")%>%
    html_text()%>%
    as.numeric()
  
  player_goals_SH <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(13)")%>%
    html_text()%>%
    as.numeric()
  
  player_goals_GW <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(14)")%>%
    html_text()%>%
    as.numeric()
  
  player_assists_EV <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(15)")%>%
    html_text()%>%
    as.numeric()
  
  player_assists_PP <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(16)")%>%
    html_text()%>%
    as.numeric()
  
  player_assists_SH <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(17)")%>%
    html_text()%>%
    as.numeric()
  
  player_shots <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(18)")%>%
    html_text()%>%
    as.numeric()
  
  player_shots_percentage <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(19)")%>%
    html_text()%>%
    as.numeric()
  
  player_TOI <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(20)")%>%
    html_text()%>%
    as.numeric()
  
  player_average_TOI <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(21)")%>%
    html_text()
  
  player_offensive_point_shares <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(22)")%>%
    html_text()%>%
    as.numeric()
  
  player_defensive_point_shares <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(23)")%>%
    html_text()%>%
    as.numeric()
  
  player_point_shares <- web_page%>%
    html_nodes("#skaters tbody .right:nth-child(24)")%>%
    html_text()%>%
    as.numeric()
  
  player_blocks <- web_page%>%
    html_nodes("#skaters tbody td:nth-child(25)")%>%
    html_text()%>%
    as.numeric()
  
  player_hits <- web_page%>%
    html_nodes("#skaters tbody td:nth-child(26)")%>%
    html_text()%>%
    as.numeric()
  
  player_faceoff_wins <- web_page%>%
    html_nodes("#skaters tbody td:nth-child(27)")%>%
    html_text()%>%
    as.numeric()
  
  player_faceoff_losses <- web_page%>%
    html_nodes("#skaters tbody td:nth-child(28)")%>%
    html_text()%>%
    as.numeric()
  
  #creates tibble of data collected
  
  scoring_regular_season <- tibble(`Player Name` = player_name_scoring,
                                   `Games Played` = player_games,
                                   Goals = player_goals_total,
                                   Assists = player_assists_total,
                                   Points = player_points,
                                   `+/-` = player_plusminus,
                                   PIM = player_penalty_minutes,
                                   `Goals Even` = player_goals_even,
                                   `Goals Short` = player_goals_SH,
                                   `Goals Power Play` = player_goals_PP,
                                   `Goals Game Winner` = player_goals_GW,
                                   `Assists Even` = player_assists_EV,
                                   `Assists Short` = player_assists_SH,
                                   `Assists Power Play` = player_assists_PP,
                                   Shots = player_shots,
                                   `Shot Percentage` = player_shots_percentage,
                                   TOI = player_TOI,
                                   `Average TOI` = player_average_TOI,
                                   `Offensive Point Share` = player_offensive_point_shares,
                                   `Defensive Point Share` = player_defensive_point_shares,
                                   `Point Shares` = player_point_shares,
                                   Blocks = player_blocks,
                                   Hits = player_hits,
                                   `Faceoff Wins` = player_faceoff_wins,
                                   `Faceoff Losses` = player_faceoff_losses,
                                   `Faceoff Percentage` = player_faceoff_wins/(player_faceoff_wins+player_faceoff_losses),
                                   year = as.numeric(str_sub(website,44,48))
  )
  
  
  
  #table and file writing starts here
  
  tables <- list(roster, team_statistics, team_analytics_5v5, scoring_regular_season)
  table_names <- list("roster", "team_statistics", "team_analytics_5v5", "scoring_regular_season")
  file_names  <- c()   #not sure if I want this as a vector or a list yet
  
  # for loop for iterating created data tables through write function to create data tables to be imported later
  # use file_names to create vector/list of file names created for easy looping through them when I eventually want to load and use the tables in the another program
  i=1
  for (table in tables){
    file_name_str = str_c(file_folder_location,     # file_folder_location given as argument into function
                          '\\',
                          table_names[i],
                          '_',
                          str_sub(website,40,42),   # website given as argument into function
                          '_',
                          str_sub(website,44,48),
                          'csv',
                          sep = '')
    write_csv(table,
              file_name_str
              )
    file_names[i] <- file_name_str
    i = i + 1
  }
  return(file_names)
  
}

##need to move items below this to somewhere else

# need to loop through these, I thought I had these somewhere else. Need to add folder for different team, can R make Folders?
#hockey_scraper('https://www.hockey-reference.com/teams/DET/2021.html', 'data/DET')
#hockey_scraper('https://www.hockey-reference.com/teams/DET/2020.html', 'data/DET')
#hockey_scraper('https://www.hockey-reference.com/teams/DET/2019.html', 'data/DET')
#hockey_scraper('https://www.hockey-reference.com/teams/DET/2008.html', 'data/DET')

years = c(2021:2008)
website = 'https://www.hockey-reference.com/teams/DET/'
folder = 'data/DET'

#loop through years of redwings hockey
for (year in years){
  site = str_c(website, year, '.html', sep = '')
  hockey_scraper(site, folder)
}

