#redwings project
#shiny app

library(tidyverse)
library(shiny)

ui <- navbarPage('Red wings Data Analysis',
#################Tab panel for introduction##############################################################                 
                 tabPanel('Introduction',
                          fluidPage(titlePanel(h1('Detroit Red Wings')),
                                    mainPanel(h1('Another title?'),
                                              p('a paragraph goes here'),
                                              fluidRow(column(4,
                                                              selectInput('Year',
                                                                          label = 'Select Year',
                                                                          choices = c(2008:2021),
                                                                          selected = 2008
                                                                          )
                                                              ),
                                                       column(4,
                                                              selectInput('stat',
                                                                          label = 'Select Stat',
                                                                          choices = c('Goals',
                                                                                      'Assists',
                                                                                      'Points',
                                                                                      '+/-',
                                                                                      'PIM'),
                                                                          selected = 'Goals'
                                                                          )
                                                       )
                                                      ),
                                              tableOutput('stat_table')
                                              )
                                    )
                          ),
                 tabPanel('Data Description',
                          fluidPage(titlePanel(h1('Statistics and Stuff')),
                                    mainPanel(h1('Paragraph Title'),
                                              p('a paragraph here'),
                                              )
                                    )
                          )
                 )

server <- function(input, output){
  output$stat_table <- renderTable(scoring_regular_season_DET_2008%>%
                                     filter(Goals == max(Goals))%>%
                                     select(`Player Name`, input$stat)
                                   )
  
}



#run the shiny app

shinyApp(ui = ui, server = server)