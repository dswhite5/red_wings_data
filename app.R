#redwings project
#shiny app

library(tidyverse)
library(shiny)

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
                                              h2('Red Wings Statistics for 2008 and 2009'),
                                              tableOutput('combined_stats'),
                                              h2('Regular Season Scoring for 2008 and 2009'),
                                              tableOutput('scoring_all')
                                              )
                                    )
                          ),
                 tabPanel('Exploratory Data Analysis',
                          fluidPage(titlePanel(h1('What are We Looking at?')),
                                    mainPanel(h1('Exploratory Data Analysis'),
                                              p('This is a paragraph about EDA')
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
  #######Code for stat sumarry table on introduction page###############################3
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
  #########Code for data Explanation page#############
  #Combine stats summary Table
  output$combined_stats <- renderTable({
    wings_stats_combined%>%
      head(2)
  })
  #Scoring regular season DET all table
  output$scoring_all <- renderTable({
    scoring_regular_season_DET_all%>%
      head(2)
  })
  
}



#run the shiny app

shinyApp(ui = ui, server = server)