#redwings project
#shiny app

library(tidyverse)
library(shiny)

ui <- navbarPage('Red wings Data Analysis',
#################Tab panel for introduction##############################################################                 
                 tabPanel('Introduction',
                          fluidPage(titlePanel(h1('Detroit Red Wings')),
                                    mainPanel(h1('Another title?'),
                                              p('a paragraph goes here')
                                              )
                                    )
                          ),
                 tabPanel('Data Description',
                          fluidPage(titlePanel(h1('Statistics and Stuff')),
                                    mainPanel(h1('Paragraph Title'),
                                              p('a paragraph here')
                                              )
                                    )
                          )
                 )

server <- function(input, output){
  
}


#run the shiny app

shinyApp(ui = ui, server = server)