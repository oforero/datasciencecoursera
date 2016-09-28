library(shiny)
library(ggplot2)

source("helpers.R", local = TRUE)
load("Model.RData")

shinyServer(function(input, output) {
    
  prediction <- reactive({
    res <- findInNGrams(preProcessInput(input$input), model, n=3)
    
    if(is.null(res)) {
      res <- findInNGrams(preProcessInput(input$input), model, n=2)
    }
    
    if(is.null(res)) {
      res <- findInNGrams(preProcessInput(input$input), model, n=1)
    }
    
    if(is.null(res)) {
      return(NULL)
    } else {
      return(res)
    }
    
  })
  
  output$prediction <- renderText({
    if(is.null(prediction())) {
      return(model$word[1])  
    } else {
      return(prediction()$word[1])
    }      
  })
  
  output$info1 <- renderText({
    paste("Preprocessed Input: ", preProcessInput(input$input))
  })
  
  output$info2 <- renderText({
    if(is.null(prediction())) {
      paste("You were thinking about this phrase: ", input$input, model$word[1])
    } else {
      paste("You were thinking about this phrase: ", input$input, prediction()$word[1])
    }      
  })
  
  # plot the relative probability of the top N next words
  output$plot <- renderPlot ({
    if(!is.null(prediction())) {
      data = prediction()
      if(nrow(data) > 10) {
        data <- data[1:10,]
      }
      ggplot (data, aes (word, p, fill = word)) + 
        geom_bar (stat = "identity") + 
        #scale_y_continuous (label = p) +
        coord_flip () +
        xlab ("") +
        ylab ("Probability") +
        theme (legend.position = "none", axis.text.y = element_text (size = 20))       
    }
  })
  
})