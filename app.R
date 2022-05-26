#redwings project
#shiny app
#source('load_csv_to_r.R')
#library(tidyverse)
#library(shiny)
#library(GGally)

ui <- navbarPage('Red wings Data Analysis',
#################Tab panel for introduction##############################################################                 
                 tabPanel('Introduction',
                          fluidPage(titlePanel(h1('Detroit Red Wings')),
                                    mainPanel(h1('A Statistical Look at the Detroit Red Wings'),
                                              p('This app will try to take a statistica look at the Detroit Red Wings, their decline over the past 14 years and whether
                                                they will continue to improve. The attempt will be to find something more insightful than "they need to score more goals", 
                                                but that may be the very thing the redwings need to do. this will also look at the league as a whole and try and determine
                                                a couple of statistics that help make a team a good nhl team and a playoff contender. Obviously there is more than one
                                                component tat make a team good. This app tries to find the most important one or two qualities that an NHL team needs to 
                                                succeed.'),
                                              p('As a beginning to understanding the data, look below to find the team leader in different statistics for each year. It is
                                                interesting to note that as the years get closer to 2021 and the team gets worse, not only do the player who lead the team 
                                                each year change, but the numbers get lower as well. Henrik Zetterberg Scores 43 goals in 2008 and no player has scored more 
                                                since then.'),
                                              fluidRow(column(4,                 # input box to select desired year
                                                              selectInput('Year', #name to call inputs
                                                                          label = 'Select Year', #label in app
                                                                          choices = c(2008:2021), # choices in Select box
                                                                          selected = 2008 #initial selection
                                                                          )
                                                              ),
                                                       column(4,                 # input box for to select desired stat
                                                              selectInput('stat', #name to call inputs
                                                                          label = 'Select Stat', #label in app
                                                                          choices = c('Goals', # choices in select box
                                                                                      'Assists',
                                                                                      'Points',
                                                                                      'PIM'
                                                                                      )
                                                                          )
                                                       )
                                                      ),
                                              tableOutput('stat_table')
                                              )
                                    )
                          ),
######Data Panel starts Here########################################################################
                 tabPanel('Data Description',
                          fluidPage(titlePanel(h1('Statistics and Stuff')),
                                    mainPanel(h1('Hockey Data'),
                                              p("Sports statistics can be tricky and confusing, especially when the terms are not given a detailed description. Sports 
                                                Statistics can also seem uncessary as it doesn't take Scotty Bowman(famous NHL and Redwings Coach) to say the current wings 
                                                need to score more and get scored on less. But the statistics can still help provide insights and those insights are easier
                                                to see when you have a good understanding of what the data consists of. So this page will take a look at the data this app 
                                                will be using and what the information in each sheet means."),
                                              p('Below are the two main tables that will be used for analysis on this site. The data was scraped from project-hockey.com.
                                                Below the tables are explinations for the terms used in analysis on this site and some of the more commonly used hockey
                                                statistics.'),
                                              h2('Red Wings Statistics for 2008 and 2009'),
                                              tableOutput('combined_stats_1st'), #plot stats table
                                              tableOutput('combined_stats_2nd'),
                                              h2('Regular Season Scoring for 2008 and 2009'),
                                              tableOutput('scoring_all_1st'), #Plot scoring table
                                              tableOutput('scoring_all_2nd'),
                                              p('S% -- Shooting percentage at 5-on-5, a shot is anytime the puck would have went in the net for a goal but the goalie stopped
                                                it. misses, blocked shots, or hitting the post do not count as shots. Shooting percentage then is the number of goals made
                                                divided by the number of shots. Essentially how often do you score per 100 shots.'),
                                              p('SV% -- Save percentage at 5-on-5. A save is anytime the puck the would have gone in the net but the goalie prevents it. So 
                                                save percentage is the number of saves made divided by total shots taken. It is essentially number of saves made out of every
                                                100 shots'),
                                              p('CF -- Corsi For at 5 on 5. Corsi is the total of all shot attempts. Shots and blocks and misses all combined together.
                                                So Corsi For is the total of all shot blocks and misses for the particular team(in this case the Red wings.'),
                                              p('CA -- Corsi Against at 5 on 5. Corsi is the total of all shot attempts. Shots and blocks and misses all combined together.
                                                So Corsi Against is the total of all shots blocks and misses against a particular team(in this case the Red Wings).'),
                                              p('CF% -- Corsi For % at 5 on 5. The percentage of shots that that are for the particular team out of all shot taken.
                                                Calculated with CF / (CF + CA)'),
                                              p('W -- Wins'),
                                              p('PPO -- Power Play Opportunities. The number of times the team had a power play'),
                                              p('PP% -- Power Play Percentage. The number of times the team scored on the power play.'),
                                              p('SH -- Short Handed Goals')
                                              )
                                    )
                          ),
                 tabPanel('Exploratory Data Analysis',
                          fluidPage(titlePanel(h1('What are We Looking at?')),
                                    mainPanel(h1('Exploratory Data Analysis'),
                                              p('This is a paragraph about EDA'),
                                              p('Lets Talk about this first plot'),
                                              plotOutput('Goals_20'),
                                              p('gonna talk about this plot too'),
                                              plotOutput('ggpairs_corsi'),
                                              p('Lets talk about this second plot'),
                                              plotOutput('ggpairs_shots'),
                                              p('Lets talk about this third plot'),
                                              plotOutput('GF_v_W'),
                                              p('lets talk about this 4th plot'),
                                              plotOutput('CF_percent_v_W')
                                              )
                                    )
                          ),
                 tabPanel('Statistical Analysis',
                          fluidPage(titlePanel(h1('What Does the Data Say?')),
                                    mainPanel(h1('Linear Regression'),
                                              p('Lets Talk about linear regression!')
                                              )
                                    )
                          )
                 )

server <- function(input, output){
  #######Code for stat sumarry table on introduction page###################################################################
  name <- reactive({input$stat}) #use variable in if else statements
  output$stat_table <- renderTable({
  if (name() == 'Goals'){
    scoring_regular_season_DET_all%>% #summary table for max goals scored in selected year
      filter(year == input$Year)%>%
      filter(Goals == max(Goals))%>%
      select(`Player Name`, Goals)
  }else if (name() == 'Assists'){
    scoring_regular_season_DET_all%>%  # summary table to max assists scored in selected year
      filter(year == input$Year)%>%
      filter(Assists == max(Assists))%>%
      select(`Player Name`, Assists)
    
  }else if (name() == 'Points'){
    scoring_regular_season_DET_all%>% # summary table for max point in selected year
      filter(year == input$Year)%>%
      filter(Points == max(Points))%>%
      select(`Player Name`, Points)
  }else if (name() == 'PIM'){
    scoring_regular_season_DET_all%>% # summary table for max PIM in selected year
      filter(year == input$Year)%>%
      filter(PIM == max(PIM))%>%
      select(`Player Name`, PIM)
  }
    
  })
  #########Code for data Explanation page#################################################################
  #Combine stats summary Table 2008 and 2009 1st half
  output$combined_stats_1st <- renderTable({
    wings_stats_combined%>%
      select(1:18)%>%
      mutate(year = as.integer(year))%>%
      head(2)
  })
  #Combine stats Table 2008 and 2009 2nd half
  output$combined_stats_2nd <- renderTable({
    wings_stats_combined%>%
      select(1,19:36)%>%
      head(2)
  })
  
  #Scoring regular season DET all table 2008 and 2009 1st half
  output$scoring_all_1st <- renderTable({
    scoring_regular_season_DET_all%>%
      select(1:14)%>%
      head(2)
  })
  #Scoring regular season DET all table 2008 and 2009 2nd half
  output$scoring_all_2nd <- renderTable({
    scoring_regular_season_DET_all%>%
      select(1,15:27)%>%
      mutate(year = as.integer(year))%>%
      head(2)
  })
  ########output for EDA tab#################################################################################
  ##box showing number of 20 goal scorers per season
  output$Goals_20 <- renderPlot({
    scoring_regular_season_DET_all%>%
      filter(Goals >= 20)%>%
      ggplot()+
      geom_bar(mapping = aes(x= year), )+
      labs(title = 'Number of Players with More than 20 Goals per Season',
           x = 'Final year of Season',
           y = 'Number of players')+
      scale_x_continuous(breaks =c(2008:2021))
  })
  
  #ggpairs(correlation matrix) for selected columns
  output$ggpairs_corsi <- renderPlot({
    wings_stats_combined%>%
      select(c(12,2:7))%>%
      ggpairs()+
      labs(title = 'Correlation Matrix for Selected Columns Red Wings Statistical Data' )
  })
  #ggpairs(correlation matrix) for selected columns
  output$ggpairs_shots <- renderPlot({
    wings_stats_combined%>%
      select(c(12,30:36))%>%
      ggpairs()+
      labs(title = 'Correlation Matrix for Selected Columns Red Wings Statistical Data' )
  })
  #scatter plot of CF% against Wins
  output$CF_percent_v_W <- renderPlot({
    wings_stats_combined%>%
      ggplot()+
      geom_point(mapping = aes(x=`CF%`, y = W))+ #change titles of scatter plot and axis
      labs(title = 'Scatter plot of Corsi For Percentage and Wins for the Detroit Red Wings', 
           subtitle = 'For the 2007-2008 season till the 2020-2021 season',
           x = 'Corsi For Percentage (Percentage of shot attempts made by Red Wings)',
           y = 'Wins for the Detroit Red Wings')+
      scale_y_continuous(n.breaks = 8)+ # number of ticks on axes to 8
      scale_x_continuous(n.breaks = 8)+
      theme_classic()
  })
  output$GF_v_W <- renderPlot({
    wings_stats_combined%>%
      ggplot()+
      geom_point(mapping = aes(x=`GF`, y = W))+ #change titles of scatter plot and axis
      labs(title = 'Scatter plot of Goals For and Wins for the Detroit Red Wings', 
           subtitle = 'For the 2007-2008 season till the 2020-2021 season',
           x = 'Goals For(number of Goals scored by the Detroit Red Wings',
           y = 'Wins for the Detroit Red Wings')+
      scale_y_continuous(n.breaks = 8)+ # number of ticks on axes to 8
      scale_x_continuous(n.breaks = 8)+
      theme_classic()
  })
}



#run the shiny app

shinyApp(ui = ui, server = server)