##Red wings data
##Static Content




######EDA Content

##Graph for max goals by player

max_goals<-scoring_regular_season_DET_all%>%
  group_by(year)%>%
  filter(Goals == max(Goals))%>%
  ggplot()+
  geom_col(mapping = aes(x=year, y = Goals), fill = 'blue')+
  labs(title = 'Max Goals by Player per Year',
       x= 'Last year of Season',
       y= 'Number of Goals')+
  theme_classic()+
  scale_x_continuous(breaks =c(2008:2021))

##graph for 20 goal scorers
goals_scorers<-scoring_regular_season_DET_all%>%
  filter(Goals >= 20)%>%
  ggplot()+
  geom_bar(mapping = aes(x= year), fill = 'blue')+
  labs(title = 'Number of Players with More than 20 Goals per Season',
       x = 'Final year of Season',
       y = 'Number of players')+
  theme_classic()+
  scale_x_continuous(breaks =c(2008:2021))



ggpairs_corsi <- wings_stats_combined%>%
  select(c(12,2:7))%>%
  ggpairs()+
  labs(title = 'Correlation Matrix for Selected Columns Red Wings Statistical Data' )

CF_percent_v_W <- wings_stats_combined%>%
  ggplot()+
  geom_point(mapping = aes(x=`CF%`, y = W), color = 'blue')+ #change titles of scatter plot and axis
  labs(title = 'Scatter plot of Corsi For Percentage and Wins for the Detroit Red Wings', 
       subtitle = 'For the 2007-2008 season till the 2020-2021 season',
       x = 'Corsi For Percentage (Percentage of shot attempts made by Red Wings)',
       y = 'Wins for the Detroit Red Wings')+
  scale_y_continuous(n.breaks = 8)+ # number of ticks on axes to 8
  scale_x_continuous(n.breaks = 8)+
  theme_classic()





GF_v_W<-wings_stats_combined%>%
  ggplot()+
  geom_point(mapping = aes(x=`GF`, y = W),color = 'blue')+ #change titles of scatter plot and axis
  labs(title = 'Scatter plot of Goals For and Wins for the Detroit Red Wings', 
       subtitle = 'For the 2007-2008 season till the 2020-2021 season',
       x = 'Goals For(number of Goals scored by the Detroit Red Wings',
       y = 'Wins for the Detroit Red Wings')+
  scale_y_continuous(n.breaks = 8)+ # number of ticks on axes to 8
  scale_x_continuous(n.breaks = 8)+
  theme_classic()




######Statistical Analysis content############################

#linear regression formula for one variable CF%

lin_reg_CF_percent<- lm(W~`CF%`, data = wings_stats_combined) # linear Regression Formula for Corsi Percent v W

#Create string for linear regression formula
corsi_percent_form<- paste('Wins = ', 
                           as.character(round(lin_reg_CF_percent$coefficients[2],2)),
                           'CF% + ',
                           as.character(round(lin_reg_CF_percent$coefficients[1],2))
                           )



reg_CFper_W <- wings_stats_combined %>% 
  ggplot()+
  geom_point(mapping = aes(x=`CF%`,y=W), color = 'blue')+ # creates scatter plot
  labs(title = 'Linear Relation of Wins and CF%',
       subtitle = 'For the Detroit Red Wings 2008 - 2021',
       x = 'Corsi For Percentage',
       y = 'Number of Wins')+ #create labels
  geom_smooth(mapping = aes(x=`CF%`, y= W), se = FALSE, method = 'lm')+ #adds linear regression line
  theme_classic()+ #changes aesthetic
  annotate(geom = 'rect',  #adds linear regression formula as a string
           xmin = 55,
           xmax = 60, 
           ymin = 20, 
           ymax = 30, 
           fill = 'white')+
  annotate(geom = 'text',
           x = 57, #location in x and y corrdinates
           y = 27,
           label = corsi_percent_form, # string for formula
           color = "black")

lin_reg_CF_percent<- lm(W~`CF%`, data = wings_stats_combined) # linear Regression Formula for Corsi Percent v W

#Create string for linear regression formula
corsi_percent_form<- paste('Wins = ', 
                           as.character(round(lin_reg_CF_percent$coefficients[2],2)),
                           'CF% + ',
                           as.character(round(lin_reg_CF_percent$coefficients[1],2))
                           )

###Variable backward Selection ##########

all_var <- summary(lm(W~`GF` + `CF%` + `PPO`+`S`+`PP`+`GF/G`+`PPOA`, data = wings_stats_combined))

all_var_stat <- str_c(str_sub(as.character(all_var[1]),4,-31),
                      '\n',
                      'R-Squared Value = ', as.character(all_var[[8]][1]),
                      '\n',
                      'F-statistic = ',as.character(all_var[[10]][[1]]),
                      sep = ''
                      )

coef_lst<-all_var[4]

coef_table<-coef_lst[[1]]

all_var_coeff<-as.data.frame(coef_table)%>%
  rownames_to_column('names')%>%
  as_tibble

#function to generate output summaries for shiny app for various linear models
summary_output<-function(form_sum){
  form_stat <- str_c(str_sub(as.character(form_sum[1]),4,-31),
                     '\n',
                     'R-Squared Value = ', as.character(form_sum[[8]][1]),
                     '\n',
                     'F-statistic = ', as.character(form_sum[[10]][[1]]),
                     sep = ''
                     )
  coef_lst<- form_sum[4]
  
  coef_table<-form_sum[4][[1]]
  
  var_coef<-as.data.frame(coef_table)%>%
    rownames_to_column('names')
  
  return(list(form_stat, var_coef))
}

six_var_stat <- summary_output(summary(lm(W~`GF` + `CF%` + `PPO`+`S`+`PP`+`GF/G`, data = wings_stats_combined)))[[1]]
six_var_coef <- as_tibble(summary_output(summary(lm(W~`GF` + `CF%` + `PPO`+`S`+`PP`+`GF/G`, data = wings_stats_combined)))[[2]]) 

five_var_stat <- summary_output(summary(lm(W~`GF` + `CF%` +`S`+`PP`+`GF/G`, data = wings_stats_combined)))[[1]]
five_var_coef <- as_tibble(summary_output(summary(lm(W~`GF` + `CF%` +`S`+`PP`+`GF/G`, data = wings_stats_combined)))[[2]])

four_var_stat <- summary_output(summary(lm(W~`GF` + `CF%` +`PP`+`GF/G`, data = wings_stats_combined)))[[1]]
four_var_coef <- as_tibble(summary_output(summary(lm(W~`GF` + `CF%` +`PP`+`GF/G`, data = wings_stats_combined)))[[2]])

three_var_stat <- summary_output(summary(lm(W~`GF` + `CF%` +`GF/G`, data = wings_stats_combined)))[[1]]
three_var_coef <- as_tibble(summary_output(summary(lm(W~`GF` + `CF%` +`GF/G`, data = wings_stats_combined)))[[2]])

two_var_stat <- summary_output(summary(lm(W~`GF` + `CF%`, data = wings_stats_combined)))[[1]]
two_var_coef <- as_tibble(summary_output(summary(lm(W~`GF` + `CF%`, data = wings_stats_combined)))[[2]])

one_var_stat <- summary_output(summary(lm(W ~ `CF%`, data = wings_stats_combined)))[[1]]
one_var_coef <- as_tibble(summary_output(summary(lm(W ~ `CF%`, data = wings_stats_combined)))[[2]])
