library(shiny)
#setwd("C:/Users/Sam.E/Desktop/datasciencecoursera/Data Science Capstone/app")
source("dataprocessorCSV.R")

#Shiny Server
shinyServer(function(input, output) {
    
  phraseEntered <- eventReactive(input$phraseEnterButton, {
    input$phrase
  })
  
  output$nextwordchance <- renderText({
    result <- getNextWordChance()
    paste0(result)
  })
  
  output$nextword2<- renderText({
    result <- StupidBackoff(input$phrase)
    paste0(result)
  })
  
})