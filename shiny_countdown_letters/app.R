#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(renv)
library(shiny)

# renv::status()
# renv::snapshot()

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("LETTERS!"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
     
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      wellPanel(
        fluidRow("Choose 5 Consenants and 3 Vowels"),
        fluidRow(
          shiny::column(
            shiny::textInput(inputId = "c1", 
                             label = NULL, 
                             value = "",
                             #width = 40,
                             placeholder = "C"), 
            width = 1),
          shiny::column(
            shiny::textInput(inputId = "c2", 
                             label = NULL, 
                             value = "",
                             #width = 40,
                             placeholder = "C"),
            width = 1
          ),
          shiny::column(
            shiny::textInput(inputId = "c3", 
                             label = NULL, 
                             value = "",
                             #width = 40,
                             placeholder = "C"),
            width = 1
          ),
          shiny::column(
            shiny::textInput(inputId = "c4", 
                             label = NULL, 
                             value = "",
                             #width = 40,
                             placeholder = "C"),
            width = 1
          ),
          shiny::column(
            shiny::textInput(inputId = "c5", 
                             label = NULL, 
                             value = "",
                             #width = 40,
                             placeholder = "C"),
            width = 1
          ),
          shiny::column(
            shiny::textInput(inputId = "v1", 
                             label = NULL, 
                             value = "",
                             #width = 40,
                             placeholder = "V"),
            width = 1
          ),
          shiny::column(
            shiny::textInput(inputId = "v2", 
                             label = NULL, 
                             value = "",
                             #width = 40,
                             placeholder = "V"),
            width = 1
          ),
          shiny::column(
            shiny::textInput(inputId = "v3", 
                             label = NULL, 
                             value = "",
                             #width = 40,
                             placeholder = "V"),
            width = 1
          ),
        ),
      ),
      wellPanel(
        fluidRow("Possible Words")
      ),
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)
