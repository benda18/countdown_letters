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
        fluidRow("Choose 5 Consonants and 3 Vowels"),
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
 
  # vars----
  lv <- c("a", "e", "i", "o", "u")
  lc <- letters[!letters %in% lv]
  
  # load list of words----
  mod.dict <- readRDS("scrabble_2to8char.rds")
  
  # GAME STARTS----
  # choose 5 consonants
  c5 <- sample(lc, size = 5, replace = T)
  
  # choose 3 vowels
  v3 <- sample(lv, size = 3, replace = T)
  rm(lc,lv)
  
  # assemble the scrambled word
  scramble <- c(c5,v3) |> 
    sort() |>
    toupper()
  rm(c5,v3)
  
  
  # make a list of permitted_letters
  permitted_ltrs <- sort(unique(scramble))
  
  # make a vector of letters_not.in
  prohibited_ltrs <- LETTERS[!LETTERS %in% permitted_ltrs]
  
  # find words in dictory with any prohibited_ltrs
  prohibited_words <- grep(pattern = paste(prohibited_ltrs, sep = "|", collapse = "|"), 
                           x = mod.dict, 
                           ignore.case = T, 
                           value = T)
  
  # all possible words
  possible_words <- mod.dict[!mod.dict %in% prohibited_words]
  rm(permitted_ltrs, prohibited_ltrs, prohibited_words)
  # remove list of words
  rm(mod.dict)
  
  # definite words - no repeating letters
  nchar_unique <- strsplit(possible_words, "") |>
    lapply(unique) |>
    lapply(length) |>
    unlist()
  
  nchar_full <- nchar(possible_words)
  dw_words <- possible_words[nchar_unique == nchar_full]
  print(dw_words)
  rm(nchar_full, nchar_unique)
  
  # remaining possible words
  possible_words <- possible_words[!possible_words %in% dw_words]
  
  
  # remove words that have more letters than allowed
  
  for(i.word in possible_words){
    temp.ltrs <- strsplit(x = i.word, 
                          split = "") |>
      unlist()
    all.letters.good <- NULL
    for(i.ltr in unique(temp.ltrs)){
      # number of i.ltr in possible word
      n_temp.ltr     <- sum(i.ltr == temp.ltrs)
      # number of i.ltr in scramble word
      n_scramble.ltr <- sum(i.ltr == tolower(unlist(strsplit(x = scramble, ""))))
      
      if(n_scramble.ltr >= n_temp.ltr){
        
        all.letters.good <- c(all.letters.good, T)
      }else{
        all.letters.good <- c(all.letters.good, F)
      }
    }
    if(all(all.letters.good)){
      #stop("it's good")
      # if all letters are good, add to definite words
      dw_words <- c(dw_words, i.word)
    }
    # remove from remaining possible words
    possible_words <- possible_words[!possible_words %in% i.word]
    
  }
  rm(i.word, temp.ltrs, i.ltr, n_scramble.ltr, n_temp.ltr, all.letters.good, 
     possible_words)
  
  dw_words
  
  longest_words <- dw_words[nchar(dw_words) == max(nchar(dw_words))]
  
  scramble
  
}

# Run the application 
shinyApp(ui = ui, server = server)
