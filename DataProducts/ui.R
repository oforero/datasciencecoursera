library(shiny)

title <- "Let's play -> Rock-paper-scissors-lizard-Spock "
coverpic <- '<img src="img/cover.jpg" style="float:right">'
titlebg <- title

# Define UI for application that plots random distributions 
shinyUI(fluidPage(theme = "bootstrap.css",
  
  # Application title
  titlePanel(
    HTML(paste(title,coverpic))),
  
  fluidRow(
    h3("Help"),
    p("This is an implementation of the game, you can play up to 500 turns agains the computer"),
    p("The computer has already played 500 turns and will not use your input to choose. "),
    p("On every play the histograms for your moves, the computer moves and the score will be updated."),
    br(),
    p("The ruleas of the game are (alo look at the figure):"),
    tags$ol(
      tags$li("Scissors cut Paper"),
      tags$li("Paper covers Rock"),
      tags$li("Rock crushes Lizard"),      
      tags$li("Lizard poisons Spock"),
      tags$li("Spock smashes Scissors"),      
      tags$li("Scissors decapitate Lizard"),
      tags$li("Lizard eats Paper"),
      tags$li("Paper disproves Spock"),
      tags$li("Spock vaporizes Rock"),
      tags$li("Rock crushes Scissors")
    ),
    p("If your choices are random you should win around 50% of the time, if not you may not be able to make random choices ;-)")
  ),
  
  fluidRow(
    h3("Choose your move!")
  ),

  fluidRow(
    actionButton("rock", "Rock!"),
    actionButton("paper", "Paper!"),
    actionButton("scissors", "Scissors!"),
    actionButton("lizard", "Lizard!"),
    actionButton("spock", "Spock!")    
  ),
  
  
  fluidRow(
    column(12, 
           h3("Turn"),
           textOutput("turn")),
    column(12, 
           h3("Histogram of your moves"),
           plotOutput("movesYou", width = "80%")),

    column(12, 
           h3("Histogram of the computer moves"),
           plotOutput("movesPC", width = "80%")),
    
    column(12, 
           h3("Histogram of the results"),
           plotOutput("results", width = "80%")) 
  )
))