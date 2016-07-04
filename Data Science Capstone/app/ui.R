library(shiny)

actionLink <- function(inputId, ...) {
  tags$a(href='javascript:void',
         id=inputId,
         class='action-button',
         ...)
}

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Text Prediction"),
  
  fluidRow(
    column(3,
           wellPanel(
             textInput("phrase", label = "", value = ""),
             actionButton("phraseEnterButton", "Enter phrase")
           )
    ),
    column(9,
           wellPanel(
            #h2(textOutput("nextword")),
            #h1(paste("Result:")),
            h2(textOutput("nextword2"))
           )
    )
  )
))