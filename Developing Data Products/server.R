library(shiny)
library("devtools")
#Load.
library("plotly")

# Load data processing file
source("data_processing.R")

#Shiny Server
shinyServer(function(input, output) {
    
  output$mainGraph = renderPlotly({
    queriedData <-queryData(crunchbaseCompanies, input$founded_at[1],input$founded_at[2],
                        input$funding_rounds[1],input$funding_total_usd[1],input$market[1],
                        input$status[1],input$name[1],input$sort[1])
    queryGraph<-plot_ly(queriedData, x = name, y = totalFunding, text = paste("Name:", name, 
                                                                              "\n URL:", homepage_url,"\n Funding Rounds: ",fundingRounds),mode = "markers",color = totalFunding)
    # style the xaxis
    layout(queryGraph, xaxis = list(title = "Start-up Names"))
  })
  
  output$infoBox = renderPlotly({
    print(input$companyInfo)
  })
  
  output$numberOfStartups = renderUI({
    span(paste0("Number of start-ups:", getnumberOfStartups()))
  })
  
})