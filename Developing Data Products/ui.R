# Load data processing file
source("data_processing.R")
# The user-interface definition of the Shiny web app.
library(shiny)
library(BH)
#require(rCharts)
require(markdown)
require(data.table)
library(dplyr)
library(DT)
library(plotly)

actionLink <- function(inputId, ...) {
  tags$a(href='javascript:void',
         id=inputId,
         class='action-button',
         ...)
}

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Start-up Data Visualization"),
  
  fluidRow(
    column(4,
           wellPanel(
             tags$head(tags$script(src="app.js")),
             h4("Filter"),
             #Inputs:
             sliderInput("founded_at", "Year Founded", 1915, 2015, value = c(1915, 2015)),
             sliderInput("funding_rounds", "Number of funding rounds",
                         1, 19, 2, step = 1),
             textInput("funding_total_usd", "Total Funding ($ USD)"),
             selectInput("market", "Market/Industry",
                         c(uniqueMarketCategories)
             ),
             textInput("name", "Company name"),
             selectInput("status", "Status", c("operating","acquired","closed","all")),
             radioButtons("sort", "Sort",
                          c("None" = "none",
                            "Ascending" = "ascending",
                            "Descending" = "descending")
                          )
             #textInput("companyInfo", "Info for Company")
           ),
           wellPanel(
             #selectInput("xvar", "X-axis variable", axis_vars, selected = "Meter"),
             #selectInput("yvar", "Y-axis variable", axis_vars, selected = "Reviews"),
             tags$small(paste0(
               "Note: 
               All data from CrunchBase Open Data Map. Information may be out of date or inaccurate"
             ))
           )
    ),
    column(8,
           wellPanel(
             span("Number of start-ups:"),
             plotlyOutput("mainGraph")
             #plotlyOutput("infoBox")
           ),
           wellPanel(
             div(id="start-up-info")
           )
    )
  )
))