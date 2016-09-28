library(shiny)
#library(ggplot2)


shinyUI(fluidPage (
  
  # Title
  titlePanel ("Mind reader, sort of ;-)"),

  # Help
  fluidRow(
    h3("Short explanation"),
    br(),
    p("This application uses some matrices to predict the next word you will type.",
      "It was build using the tm library in R.",
      "The application uses the pre-build matrix because training the model on-line would be prohibitely expensive"
    ),
    br(),
    br(),
    p("To try the application type in the text box and press the",
      strong("I'm feling lucky"),
      " button")),

  # Input  
  fluidRow(
    
    # Sidebar layout
    sidebarLayout(
        
        sidebarPanel(
            textInput("input", "Type here",value = ""),
            submitButton("I'm feling lucky")
        ),
        
        mainPanel(
            h4("You were about to type"),
            verbatimTextOutput("prediction"),
            textOutput('info1'),
            textOutput('info2')
        )
    )),
  
  # Fancy
  fluidRow (
    h3 ("Other Possible Suggestions"),
    plotOutput ("plot")
  )    

))