#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
###############################################################################
##  Data Loading 
###############################################################################
dtGlobal <- read.csv("../GLBTs+dSST.csv") ## NASA surface temperature data 
dtNthPol <- read.csv("../NHTs+dSST.csv")  ## NASA North Pole temperature data
dtSthPol <- read.csv("../SHTs+dSST.csv")  ## NASA South Pole temperature data
###############################################################################





# Define server logic required to draw a histogram
shinyServer(function(input, output) {

   selectedColu <- reactive({as.numeric(c(input$mth))}) 
   selectedData <- reactive({
      if(input$dataInput == 'Glob'){ selData <- dtGlobal }
      if(input$dataInput == 'NPol'){ selData <- dtNthPol }
      if(input$dataInput == 'SPol'){ selData <- dtSthPol }
      selData <- selData[(selData$Year >= input$Period[1]  & selData$Year <= input$Period[2]),]
      data.frame(selData[,c(1,sort(selectedColu()))])
    })

   selectLabel <- reactive({
     if(input$dataInput == "Glob"){rLabel <- "Global Data"}
     if(input$dataInput == "NPol"){rLabel <- "North Pole Data"}
     if(input$dataInput == "SPol"){rLabel <- "South Pole Data"}
     rLabel
   })
   

   output$displayData <- renderTable({selectedData()})
   
   output$resultGraph <- renderPlot({
     plot(selectedData(), col = c(1,2,3,4,5,6,7,8,9), main = selectLabel())
   })
})
