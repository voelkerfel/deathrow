library(shiny)

shinyUI(fluidPage(
  titlePanel("Last Words of Deathrow Inmates"),
  sidebarLayout(
    position="right",
    sidebarPanel(
      sliderInput("date", "Date of Execution:", min=selection.date.min, 
                  max=selection.date.max, value=c(selection.date.min, 
                                                  selection.date.max)),
      br(),
      sliderInput("age", "Age of Inmate:", min=selection.age.min, max=selection.age.max, 
                  value=c(selection.age.min, selection.age.max)),
      br(),
      checkboxGroupInput("race", "Race of Inmate:", choices=selection.race, 
                         selected=selection.race, inline=TRUE),
      br(),
      selectInput("results", "Number of Words to Display:", choices=5:20, selected=10)
    ),
    mainPanel(
      plotOutput("plot1"),
      br(),
      h4("Instructions"),
      p("The present application allows you to evaluate the most used last words of ",
        "537 death row inmates between 1982 ans 2016. Multiple occurences were ignored ",
        "so that the percentages represent the share of statements in which ",
        "the word was used at least once."),
      p("Please use the control elements on the right side of this page to customize",
        "your analysis. "),
      p("For more information on the data itself please visit the ", 
        a("Texas Department of Criminal Justice", 
          href="http://www.tdcj.state.tx.us/death_row/dr_executed_offenders.html"), 
        "from which the data was scraped followed by further processing and text mining.",
        "The source code of this application is available on my ",
        a("Github", href="https://github.com/voelkerfel/deathrow"), " page.")
    )
  )
))

