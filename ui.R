shinyUI(fluidPage(
  titlePanel("Tobacco Tariffs and Consumption in Developing Countries"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Correlation between international trade tariffs on tobacco and cigarettes consumption worldwide."),
      
      selectInput("var", 
                  label = "Consumption metric",
                  choices = list("cigarette consumption", "smoking prevalence"),
                  selected = "cigarette consumption"),

      selectInput("var2", 
                  label = "Tariff average",
                  choices = list("MFN (Applied) tariffs", "bound tariffs"),
                  selected = "MFN (Applied) tariffs"),
      
      sliderInput("range", 
                  label = "Years of interest:",
                  min = 1996, max = 2012, value = c(1996, 2012))
    ),
    
    mainPanel(
      
      plotOutput("mainplot"),
      textOutput("text1"),
      textOutput("text3")
      
      )
  )
))