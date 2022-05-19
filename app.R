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
                                                                          selected = 2009
                                                                          )
                                                              ),
                                                       column(4,
                                                              selectInput('stat',
                                                                          label = 'Select Stat',
                                                                          choices = c('Goals',
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
                 tabPanel('Data Description',
                          fluidPage(titlePanel(h1('Statistics and Stuff')),
                                    mainPanel(h1('Paragraph Title'),
                                              p('a paragraph here'),
                                              )
                                    )
                          )
                 )

server <- function(input, output){
  name <- reactive({input$stat})
  output$stat_table <- renderTable({
  if (name() == 'Goals'){
    scoring_regular_season_DET_all%>%
      filter(Goals == max(Goals), year == input$Year)%>%
      select(`Player Name`, Goals)
  }else if (name() == 'Assists'){
    scoring_regular_season_DET_all%>%
      filter(Assists == max(Assists), year == input$Year)%>%
      select(`Player Name`, Assists)
    
  }else if (name() == 'Points'){
    scoring_regular_season_DET_all%>%
      filter(Points == max(Points), year == input$Year)%>%
      select(`Player Name`, Points)
  }else if (name() == 'PIM'){
    scoring_regular_season_DET_all%>%
      filter(PIM == max(PIM), year == input$Year)%>%
      select(`Player Name`, PIM)
  }
    
  })
  
}



#run the shiny app

shinyApp(ui = ui, server = server)