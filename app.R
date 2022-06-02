#redwings project
#shiny app
library(tidyverse)
library(shiny)
library(GGally)
#source('load_csv_to_r.R')
source('static_content.R')

ui <- navbarPage('Red wings Data Analysis',
#################Tab panel for introduction##############################################################     
#########################################################################################################

                 tabPanel('Introduction',
                          fluidPage(titlePanel(h1('Detroit Red Wings')),
                                    mainPanel(h1('A Statistical Look at the Detroit Red Wings'),
                                              p('The Detroit Red Wings are a historic original six Ice hockey team in the National Hockey League(NHL). They were the premier 
                                                franchise in the NHL for many years but have for the last decade or so been declining. Eventually they hit bottom and were the
                                                worse team in the NHL by far. This app will try to take a statistical look at the Detroit Red Wings, their decline over the 
                                                past 14 years and whether they will continue to improve. The attempt will be to find something more insightful than 
                                                "they need to score more goals", but that may be the very thing the redwings need to do. this will also look at the league
                                                as a whole and try and determine a couple of statistics that help make a team a good nhl team and a playoff contender. Obviously
                                                there is more than one component that makes a team good. This app tries to find the most important one or two qualities that an 
                                                NHL team needs to succeed.'),
                                              p('As a beginning to understanding the data, look below to find the team leader in different statistics for each year. It is
                                                interesting to note that as the years get closer to 2021 and the team gets worse, not only does the player who leads the team 
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
####################################################################################################
                 tabPanel('Data Description',
                          fluidPage(titlePanel(h1('Statistics and Stuff')),
                                    mainPanel(h1('Hockey Data'),
                                              p("Sports statistics can be tricky and confusing, especially when the terms are not given a detailed description. Sports 
                                                Statistics can also seem uncessary as it doesn't take Scotty Bowman(famous NHL and Redwings Coach) to say the current wings 
                                                need to score more and get scored on less. But the statistics can still help provide insights and those insights are easier
                                                to see when you have a good understanding of what the data consists of. So this page will take a look at the data this app 
                                                will be using and what that information means."),
                                              p('Below are the two main tables that will be used for analysis on this site. The data was scraped from hockey-reference.com.
                                                Below the tables is a selection box with explinations for the terms in the different columns.'),
                                              h2('Red Wings Statistics for 2008 and 2009'),
                                              p('The Statistic table below contains stats for Detroit Red Wings the regular season for the seasons 2007-2008 and 2008-2009, 
                                                the year in the table is the last year of the season. The data for this site contains data from the 2008 season till the 2021 
                                                season. The stats below are overall team statistics. Meaning that the S% 5v5 is the average shooting percentage 5 on 5 for the
                                                entire team in the indicated year '
                                                ),
                                              tableOutput('combined_stats_1st'), #plot stats table
                                              tableOutput('combined_stats_2nd'),
                                              h2('Regular Season Scoring for 2008 season'),
                                              p('The regular Season Scoring Table is for the 2008 season. The stats below are for individual players for an individual season.
                                                So Game Played is the number of games played by an individual player for that specific season.This site uses the data on all of
                                                the players for every season from 2008 to 2021.'),
                                              tableOutput('scoring_all_1st'), #Plot scoring table
                                              tableOutput('scoring_all_2nd'),
                                              selectInput('attributes', #this is the selection input to pick a statistic for description
                                                          label = 'Select Attribute',
                                                          choices = names(data_descrp), #names from data_description table from write_csv
                                                          selected = 'Team'
                                                          ),
                                              textOutput('attributes'),
                                              br(),
                                              br(),
                                              br(),
                                              br(),
                                              br(),
                                              br(),
                                              br(),
                                              br(),
                                              br()
                                              
                                              )
                                    )
                          ),
########################EDA PAge####################################################################################
####################################################################################################################

                 tabPanel('Exploratory Data Analysis',
                          fluidPage(titlePanel(h1('What are We Looking at?')),
                                    mainPanel(h1('Exploratory Data Analysis'),
                                              p('The next step after getting to know what the data consists of, meaning what data you have and what the attributes are, is to try and
                                                find out a little of what the data might be able to say. Meaning what insights can you glean from the data, is there anything interesting, 
                                                can the data be shaped into something new? This part of the process is called Exploratory Data Analysis and it is exactly like what it 
                                                like, exploring. Eventually this site is going to move toward a linear regression of multiple variables to try and determine which variables
                                                lead to more wins, which is what every sports team wants. But first use the select box below to peruse through some other graphs and to get an
                                                idea of what else might be interesting in this data set.'),
                                              p('The plots below show a variety of things that might be looking into, I think the idea of seeing how many 20 goal scorers a team have could be
                                                interesting, does having a lot of mid level scorers lead to wins? Or having one or two really good scorers? The red wings dont really have either
                                                of those at the moment. One season was shortened, I think due to a lock out. Can you find it in these graphs?'),
                                              selectInput('eda_graphs',
                                                          label = 'Select Graph',
                                                          choices = c('20 Goals Scorers',
                                                                      'Max Goals by Player'),
                                                          selected = '20 Goals Scorers'
                                                          ),
                                              plotOutput('graphs'),
                                              p('Once you have done a little exploring its time to start heading a direction. The direction this site takes is towards trying to find out what statistic
                                                drives winning. To do that I created what is called a scatterplot matrix. The one below is for 6 of the variables in the Red Wings Stats data and 
                                                compares thosecvariables to W, the number of wins. There are other matrices not shown but if the matrix is too large the site moves to slow. What 
                                                the matrix shows is a scatter plot for each variable with W and gives the correlation coefficient(C) for each pairing. C is from -1 to 1 with the
                                                sign giving whether is positively or negatively correlated and the value giving whether the variables are linearly correlated. The closer C is to 1
                                                the more correlated the variables. So a C of -0.9 would have a strong negative linear correlation. This can be seen in the corresponding scatter 
                                                plots. W and CF% have a correlation coefficient of 0.854, indiciating a strong positive linear relationship, and in the scatterplot of those two 
                                                variables the points look like a line with an upward slope. Looking at W and S% 5v5, those variables have a low C value of 0.212, that scatter plot
                                                does not have the obvious trend of W and CF%'),
                                              plotOutput('ggpairs_corsi'),
                                              #p('Lets talk about this second plot'),
                                              #plotOutput('ggpairs_shots'),
                                              p('Lets talk a for brief moment as to why I am choosing linear regression as a stastical model and what that is. There are other models out there that might be a little
                                                newer, trendier, or more complex than a linear model, so why choose the old stand by. Well, partially because it is the old stand by, most people have
                                                taken an algebra class and had to plot two points and a line (even if they never enjoyed doing so or thought it would never be useful in real life)
                                                and at least recognize the equation y = mx +b. Which is what a linear model is. The dependent variable is y (its value depends on x), and x is the
                                                independent variable (its value is independent of any other variable). In a linear model a change in x leads to a proportional change in y, scaled by 
                                                the slope of the line m. the intercept b is the value of y when x = 0, which in real linear models doesnt always apply. So this leads to the second reason
                                                to choose a linear model, it is interperatable. The Red Wings are bad, I want to see what they can do to be good, which means I have to be able to easily
                                                apply the analysis and linear models are easily interperatble. For the model y= mx + b a change of 1 in x leads to an m size change in y. So a linear model
                                                seems like it will make easy to see which of the statistics in my data sets are needed to to make the number of wins go up. See the linear regession plot 
                                                of W vs CF% below for an example of what this looks like. This model would be interpreted as a 1% change in Corsi For Percentage leads to a change of 2.41 
                                                wins per season. It is interesting to note that the intercept in this case is not interperatable. The intercept is the number when the dependent variable 
                                                is equal to 0, not a realistic scenario, and that it would result in a -87 wins, an impossible scenario.'),
                                              plotOutput('reg_CFper_W'),
                                              p('So, I want to build a linear model because it is familiar and it is easy to interpret and I want to try and find what the wings can improve on to increase
                                                the number of wins. So I want a linear model with the dependent variable(the y variable in the previous equation) to be wins. So what is the x variable? Can
                                                there be more than one "x" variable? If I can do more than one "x" variable is it better to have several models with one independent variable or to have one
                                                model with several independent variables? The answer to the more than one independent variable (the "x" is the previous equation is yes, there can be more than
                                                one. The question of lots of single variable models vs one models with multiple variables is "it depends". The attributes(columns in the data sets) available
                                                to us seem to be related to each other. What I mean by that is that a change in one variable tends to lead to changes in other variables, if the variable S% 
                                                (shooting percentage) goes up, it is pretty likely that the number of goals is also going to go up. When the is interalted like this doing a lot of single
                                                variable models can be dangerous. There might be a model that looks great but the independent variable might just be correlated to a different variable that is
                                                driving the change. Lets say you modeled wins based on player number, you might find that wins go up if there is a number 13 on the ice, and so you say we need 
                                                another player with the number 13 and we need to give him lots of ice time. Well Pavel Datsyuk(he was very good) was number 13, and he is the variable driving the
                                                increase in the number of wins, not the number 13. So, to avoid this there are ways to select the variables that actually are related to the changes in the
                                                dependent variable, in this case the number of wins. For this site I am going to use a mixture of the correlation matrix above and a method called backward
                                                selection, where you start with some variables and eliminate the ones that arent contributing until you have a model based on independent variables(the "x"s) 
                                                that actually effect the dependent variable (the "y").'),
                                                p('Lets start with the correlation matrix. I should clarify that for this model I am only going to use the variables from the Red wings Statistics data as I 
                                                  can easily correlate with the number of wins. I am going to reveiw the C values for each variable combination with W, again not all of them are shown, and 
                                                  start with the variables that have a C value above 0.8. I could do backwards selection on all 36 variable in the data set, but that seems like tedious work
                                                  that I can skip based on how correlated the variables are with W. The variable I am picking are GF - goals for,  CF% - Corsi For Percentage, PPO-Power Play
                                                  Opportunities, S- shots, PP - Power play Goals, GF/G - Average Goals per Game, PPOA - Power Play Opportunities against. Once I have all of my variables I 
                                                  can start the backwards selections process to develop my linear model, which is done on the statistical analysis page.'),
                                              br(),
                                              br(),
                                              br()
                                              #I might take these plots out of here
                                              #plotOutput('GF_v_W'),
                                              #p('lets talk about this 4th plot'),
                                              #plotOutput('CF_percent_v_W')
                                              )
                                    )
                          ),
######################Statistical Analysis Page#####################################################################################
####################################################################################################################################

                 tabPanel('Statistical Analysis',
                          fluidPage(titlePanel(h1('What Does the Data Say?')),
                                    mainPanel(h1('Linear Regression'),
                                              h3('Model Descriptors'),
                                              p('So we have already talked about why we are doing linear regression, so let\'s get to doing the linear regression. We have alredy used the correlation matrix to pick
                                                7 intital variables. Now we are going to run some models and elminate variables based on whether they are contributing to the model. First, lets talk about some terms
                                                that we will be using to pick those variables and to decide whether the model we are testing is a good one. We will be using three descriptor terms to make judgements
                                                about which model and variables are good. R-squared, the F-statistic, and p-value.'), 
                                                p('First is the the R-squared statistic. R-squared, see the R-squared value in the summaries below, is a measure of how good an
                                                individual model is and is bewteen 0 and 1. I won\'t get too deep into the statistical derivation of R-squared but it is a measure of how much of the variability in
                                                data is accounted for in the model. So an R-squared value close to one, means a lot of the variability is accounted for. If R-squared is 0.97 lets says, then that means
                                                that model accounts for 97 percent of the variability in the data. That is an indication that the model being evaluated is a good one, at least typically, it still
                                                depends on the data that you are looking.'),
                                              
                                              p('Second, the p-value. Again, I dont want to get to technical with the statistics but a p-value is essentailly a measure or whether the variable in question is statistically
                                                significant. Meaning that it actually contributes to the variability in a dependent variable, sort of. The real meaning behind the p-value is that it is the probability that
                                                the value of the coefficient of the independent variable coefficient isnt due to chance. Typically we look for p-values under 5% or 0.05. As an example lets say the we have 
                                                the model W = m*S + n*GF + b. W is wins, S is shots, GF is goals for, m is the coefficient for S, n is the coefficient for GF and b is the intercept. Lets say m =10 and
                                                n = 3 and b = 7. The final model looks like this then. W = 10*S + 3*GF + 7. The p-value for m is 0.01, and the p-value for n is 0.2. What these mean is that there is a 1% 
                                                probability that the the value of m is due to chance, but there is a 20% probability that the value for n is due to chance. What do I mean by chance? Well we could ask how
                                                do we know that numbers that model gives us are accurate? Does the model really describe and predict the dependent variable in question or is the model just random? The 
                                                answer is we don\'t know! We cant really by sure. But the p-value in this case can give us an estimate of the probability of the coefficient of the particular independent 
                                                variable being due to chance. That is why we want a p-value less than 0.05. We want a less than 5% chance that the coefficients are just due to randomness. In the summaries 
                                                below, the p-value is under the column Pr(>|t|)'),
                                              
                                              p('Last is the F statistic. The F-statistic is similar to the p-value, but it is for the model as a whole. A p-value for a model can be calculated, but if there are multiple
                                                independent variables it can lead to a misleading p-value. One way to think of this is that if you are looking for at least one p-value to be less that 0.05 and you have 20
                                                independent variables, chances are there will be one p-value less than 0.05 just based on the number of variables. So F statistic does something similar to the p-value but
                                                but accounts for when there is more than one independent variable. That is a simplified explanation but it enough fo what we need right now. The value of the F stastic though
                                                is not a percentage, so it can get very large. The numbers we are looking for though are F-statistics significantly greater than 1 which indicates that at least one coefficient
                                                in the model is not equal to 0. Now the next question might be what does "significantly" mean but I will leave that for another time.'),
                                              
                                              h3('Backwards Selection'),
                                              p('Now that we have an idea of what all of the terms mean. We can start to do some backwards selection and develop the best model based on the chosen variables. First we start
                                                with a model that contains all of the variables we picked from the correlation matrix. This model is shown below. When there are more than 1 or two variables, it gets very 
                                                difficult to give a graphical representation of the model. So we are going to be using model summaries from here on out. We run the first model and check the F-statistic and
                                                then check p-values. We dont want any variable with a p-value greater than 0.05 in the model. This threshold is negotiable, but for this analysis we are using 0.05. Now if there
                                                are multiple variable with p-values greater than 0.05 we dont eliminate all of them, we eliminate the worst one and run the model. We repeat this process until every remaining
                                                variable meets the 5% threshold.'),
                                              
                                              p('Let\'s start with a model with all of the correlation matrix variables and see what that looks like. The model numbers are going to correspond with the number of independent 
                                                variables. So this first model is model 7.'),
                                              
                                              h4('Model 7'),
                                              verbatimTextOutput('all_var'),
                                              tableOutput('all_var_coeff'),
                                              p('For Model 7 we have an R-squared value of 0.971 and an F statistic of 28.2. I am not going to list all of the p-values but none of them are below 0.05. But this is not abnormal
                                                for a model of this size. Now we have a R-squared value close to one and an F-statistic far above 1, do we need to remove variables? The answer is yes. While a couple of variables
                                                are below a 10% threshold none of them are below the 5% threshhold. And remember, an F stastic above one doesnt mean the model is good, but means that it is likely that one of the 
                                                coefficients is non-zero. If you want to know more about what that means, look up hypothesis testing for multiple linear regression. So we are going to edit the model and we do this
                                                by removing the variable with the highest p-value and see what that model looks like. The varaible to be removed is PPOA which is power play opportunities against.'),
                                              
                                              h4('Model 6'),
                                              verbatimTextOutput('six_var'),
                                              tableOutput('six_var_coeff'),
                                              p('For model 6 PPOA is removed and we have 6 indpendent variables. We have an R-squared of 0.968 and an F-statisic of 35.1. Now at first glance we might think "hey the R-squared value
                                                went down, isnt that bad?" and the answer is technically yes, We are technically accounting for a little less of the variability in W. But it didn\'t go down very far. There is always
                                                going to be an increase in R-squared if you add another variable to your model, but how much it goes is important, if you eliminate a variable that might be making your model less 
                                                accurate, while only minimally reducing R-squared, that is a better overall model, even if the R-squared is smaller.'),
                                              p('Looking at the p-values the intercept is now below our threshold, but none of the independent variables are. So we eliminate another variable, this time its PPO or Power Play 
                                                Opportunities.'),
                                              
                                              h4('Model 5'),
                                              verbatimTextOutput('five_var'),
                                              tableOutput('five_var_coeff'),
                                              p('In Model 5 we finally get to two variable that meet the 5% threshold, but there are still several variables the do not. The r-squared and F-statistic still look good. So we eliminate
                                                another variable, this time S or shots. We repeat this process and eliminate PP or power play goals and then GF/G which is goals for per game. When we eventually get to model 2 we are
                                                left with only two variables that both meet the 5% threshold.'),
                                              
                                              h4('Model 4'),
                                              verbatimTextOutput('four_var'),
                                              tableOutput('four_var_coeff'),
                                              p(''),
                                              
                                              h4('Model 3'),
                                              verbatimTextOutput('three_var'),
                                              tableOutput('three_var_coeff'),
                                              p(''),
                                              
                                              h4('Model 2'),
                                              verbatimTextOutput('two_var'),
                                              tableOutput('two_var_coeff'),
                                              p('So now have a linear model that has a high R-squared value and high F-statisic. Both of the variables meet the less than 5% percent threshold. Both variables say 0.00 but this is just due
                                                rounding errors. The p-values are just very small. Lets first check and see what happens if we eliminate another variable. We can\'t see it on here due to rounding, but the p-value for CF% is
                                                smaller, so we eliminate GF and run one last model.'),
                                              
                                              h4('Model 1'),
                                              verbatimTextOutput('one_var'),
                                              tableOutput('one_var_coeff'),
                                              p('Notice when we run this model that the p-value is still below the threshold, but the F-statistic when down for the first time and the R-squared value is drastically different. This is
                                                an example of when the change in R-squared is big enough that the variable that was eliminated should be added back into the model. We account for a lot more of the variation in W with GF
                                                included and its p-value is below the desired threshold. So the linear model we are using is the Model 2 with GF and CF% as the independent variables.'),
                                              
                                              h3('What it all Means'),
                                              p('')
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
  # Text output for data attribute description
  attribute <- reactive(input$attributes)
  output$attributes <- renderText({
    data_descrp[attribute()][[1]]
  })
  ########output for EDA tab#################################################################################
  ##box showing number of 20 goal scorers per season
  graph = reactive(input$eda_graphs)
  output$graphs <- renderPlot({
    if(graph() == '20 Goals Scorers'){
      goals_scorers #code in static_content.R
    }else if(graph() == 'Max Goals by Player'){
      max_goals #code in static_content.r
  }
  })
  
  #ggpairs(correlation matrix) for selected columns
  output$ggpairs_corsi <- renderPlot({
    ggpairs_corsi #plot code is in static_content.R
  })
  
  #This second scatter plot/correlation matrix not necessary and slows program down
  #ggpairs(correlation matrix) for selected columns
  # output$ggpairs_shots <- renderPlot({
  #   wings_stats_combined%>%
  #     select(c(12,30:36))%>%
  #     ggpairs()+
  #     labs(title = 'Correlation Matrix for Selected Columns Red Wings Statistical Data' )
  #})
  
  #scatter plot of CF% against Wins
  output$CF_percent_v_W <- renderPlot({
    CF_percent_v_W #plot code is in static_content.R
  })
  output$GF_v_W <- renderPlot({
    GF_v_W #plot code is in static_content.R
  })
                             
  #Create scatter plot with linear regression line and formula on it
  output$reg_CFper_W <- renderPlot({
    reg_CFper_W # plot code is in static_content.R
    })
  
  ########For stats analysis tab##########################################
  
  #formula and statistics for multiple linear regression with all chosen variables
  output$all_var <- renderText({
    all_var_stat #code in static_content.R
  })
  output$all_var_coeff <- renderTable({
    all_var_coeff #code in static_content.R
  })
  
  #formula and statistics for multiple linear regression with 6 of the chosen variables
  output$six_var <- renderText({
    six_var_stat #code in static_content.R
  })
  output$six_var_coeff <- renderTable({
    six_var_coef #code in static_content.R
  })

  #formula and statistics for multiple linear regression with 5 of the chosen variables
  output$five_var <- renderText({
    five_var_stat #code in static_content.R
  })
  output$five_var_coeff <- renderTable({
    five_var_coef #code in static_content.R
  })
  #formula and statistics for multiple linear regression with 4 of the chosen variables
  output$four_var <- renderText({
    four_var_stat #code in static_content.R
  })
  output$four_var_coeff <- renderTable({
    four_var_coef #code in static_content.R
  })
  #formula and statistics for multiple linear regression with 3 of the chosen variables
  output$three_var <- renderText({
    three_var_stat #code in static_content.R
  })
  output$three_var_coeff <- renderTable({
    three_var_coef #code in static_content.R
  })
  #formula and statistics for multiple linear regression with 2 of the chosen variables
  output$two_var <- renderText({
    two_var_stat #code in static_content.R
  })
  output$two_var_coeff <- renderTable({
    two_var_coef #code in static_content.R
  })
  #formula and statistics for multiple linear regression with 1 of the chosen variables
  output$one_var <- renderText({
    one_var_stat #code in static_content.R
  })
  output$one_var_coeff <- renderTable({
    one_var_coef #code in static_content.R
  })

}

#run the shiny app

shinyApp(ui = ui, server = server)