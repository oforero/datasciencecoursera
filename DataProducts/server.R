library(shiny)

labels <- c("rock", "paper", "scissors", "lizzard", "spock")
labels2 <- c("You Win", "Computer Wins")

ai <- sample(0:4, 1000, replace=TRUE) 
ai.f <- factor(ai, 0:4, labels=labels)

clicks <- vector("numeric", 500)
score <- vector("numeric", 500)

values <- reactiveValues(count=1, moves=clicks, moves.f=NA, score=score, score.f=NA)

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {  
  observe({
    input$rock
    isolate({
      c <- values$count
      values$count <- c + 1      
      values$moves[c] = 0 
      if(ai[c]==2 | ai[c]==3) {
        values$score[c] = 0
      } else {
        values$score[c] = 1        
      }
      sofar <- values$moves
      score <- values$score
    })
    
    values$moves.f <- factor(sofar, 0:4, labels=labels)
    values$score.f <- factor(score, 0:1, labels=labels2)  
  })

  observe({
    input$paper
    isolate({
      c <- values$count
      values$count <- c + 1      
      values$moves[c] = 1 
      if(ai[c]==0 | ai[c]==4) {
        values$score[c] = 0
      } else {
        values$score[c] = 1        
      }
      sofar <- values$moves
      score <- values$score
    })
    
    values$moves.f <- factor(sofar, 0:4, labels=labels)
    values$score.f <- factor(score, 0:1, labels=labels2)  
    
  })
  
  observe({
    input$scissors
    isolate({
      c <- values$count
      values$count <- c + 1      
      values$moves[c] = 2 
      if(ai[c]==1 | ai[c]==3) {
        values$score[c] = 0
      } else {
        values$score[c] = 1        
      }
      sofar <- values$moves
      score <- values$score
    })
    
    values$moves.f <- factor(sofar, 0:4, labels=labels)
    values$score.f <- factor(score, 0:1, labels=labels2)  
    
  })
  
  observe({
    input$lizard
    isolate({
      c <- values$count
      values$count <- c + 1      
      values$moves[c] = 3 
      if(ai[c]==1 | ai[c]==4) {
        values$score[c] = 0
      } else {
        values$score[c] = 1        
      }
      sofar <- values$moves
      score <- values$score
    })
    
    values$moves.f <- factor(sofar, 0:4, labels=labels)
    values$score.f <- factor(score, 0:1, labels=labels2)  
    
  })
  
  observe({
    input$spock
    isolate({
      c <- values$count
      values$count <- c + 1      
      values$moves[c] = 4 
      if(ai[c]==0 | ai[c]==2) {
        values$score[c] = 0
      } else {
        values$score[c] = 1        
      }
      sofar <- values$moves
      score <- values$score
    })
    
    values$moves.f <- factor(sofar, 0:4, labels=labels)
    values$score.f <- factor(score, 0:1, labels=labels2)  
    
  })
  
  
  output$movesYou <- renderPlot({
    values$moves.f
    isolate({
      c <- values$count
      plot(values$moves.f[1:c])
    })
  })

  output$movesPC <- renderPlot({
    values$moves.f
    isolate({
      c <- values$count
      plot(ai.f[1:c])
    })
  })
      
  output$results <- renderPlot({
    values$moves.f
    isolate({
      c <- values$count
      plot(values$score.f[1:c])  
    })
  })
  
  
  
})
