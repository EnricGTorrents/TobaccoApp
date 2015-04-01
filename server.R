
library(ggplot2)
library(scales)
library(gridExtra)

consumption <- readRDS("data/Developoing.Consumption.Cigarettes.rds")
prevalence <- readRDS("data/Developoing.Prevalence.rds")
bound <- readRDS("data/Developoing.Tariff.Bound.rds")
applied <- readRDS("data/Developoing.Tariff.MFN.rds")


shinyServer(
  function(input, output) {
    
    output$text1 <- renderText({ 
      paste("Showing", input$var, "data from both sexes and all ages, correlated with ", input$var2, "of cigarettes containing tobacco (Hs code 240220)." )
    })
    
    output$text3 <- renderText({ 
      paste("You have chosen a range that goes from",
            input$range[1], "to", input$range[2])
    })
    
    output$mainplot <- renderPlot({
      smoking <- switch(input$var, 
                     "cigarette consumption" = consumption,
                     "smoking prevalence" = prevalence)
      
      tariffs <- switch(input$var2, 
                      "MFN (Applied) tariffs" = applied,
                      "bound tariffs" = bound)
      
#     plot(data)

p1 <- ggplot(tariffs) + geom_line(aes(Year, Tariff, group=Country, colour=Country)) + theme_minimal() + scale_x_continuous(limits = c(input$range[1], input$range[2]))
p2 <- ggplot(smoking) + geom_line(aes(Year, Consumption, group=Country, colour=Country)) + theme_minimal() + theme(legend.position="none") + scale_x_continuous(limits = c(input$range[1], input$range[2]))

# + scale_x_continuous(breaks = as.numeric(test$Year), labels = format(test$Year, format = "%y"))
grid.arrange(p1, p2)

# ggplot(subset(test,Country %in% c(data))) + geom_line(aes(Year, Tariff.2, group=Country, colour=Country))

})
    
  }
)
