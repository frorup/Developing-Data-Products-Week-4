#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that analysis the NASA earth temperature data

shinyUI(fluidPage(

    # Application title
    titlePanel("NASA temperature data for Earth"),
    br(),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
 
        sidebarPanel(
            radioButtons("dataInput", 
                       label = "Select Data Source:",
                       choices = list("Global Data" = "Glob", 
                                      "North Pole Data" = "NPol", 
                                      "South Pole Data" = "SPol"), 
                       selected = "Glob"),
            sliderInput("Period","Range of Data to be used", min = 1880, max=2022,
                        value = c(1960, 2010), step = 1),
            
            selectInput("mth", "Select Month from Dataset",
                        choices = c("Jan" = 2, "Feb" = 3, "Mar" = 4, "Apr" = 5,
                                    "May" = 6, "Jun" = 7, "Jul" = 8, "Aug" = 9,
                                    "Sep" = 10, "Oct" = 11, "Nov" = 12, "Dec" = 13,
                                    multiple = TRUE, selected = "Jan"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type = "tab",
                        tabPanel("resultData", tableOutput("displayData")),
                        tabPanel("resultGrap", plotOutput("resultGraph")))
        )
    )
))
