library(dplyr)
library(ggplot2)
library(shiny)
library(tidyr)

shinyServer(function(input, output) {
  output$plot1 <- renderPlot({
    plot.data <- deathrow %>%
      filter(date>=input$date[1] & date<=input$date[2]  &
               age>=input$age[1] & age<=input$age[2] &
               race %in% input$race)%>%
      group_by(statement.word) %>%
      summarize(used=sum(statement.word.count)/n(),
                notused=sum(!statement.word.count|is.na(statement.word.count))/n()) %>%
      ungroup() %>%
      arrange(desc(used)) %>%
      slice(1:input$results) %>%
      gather(statement.word.usage, statement.word.count, one_of("used", "notused"))
    
    statement.word.order=unique(plot.data$statement.word)
    plot.data$statement.word <- factor(plot.data$statement.word, 
                                       levels=statement.word.order)
    
    ggplot(plot.data, aes(x=statement.word, y=statement.word.count)) +
      geom_bar(aes(fill=statement.word.usage), stat="identity") +
      labs(list(x="Last Word", y="Frequency of Use")) +
      scale_y_continuous(labels=function(x) {paste(x*100, "%")}, expand=c(0, 0)) +
      scale_fill_manual(name="Legend", values=c("used"="#428bca", "notused"="#cdcdcd")) +
      theme(legend.position="none",
            plot.background=element_rect(fill="#f5f5f5", color="#eeeeee", size=2),
            panel.grid=element_blank(),
            panel.background=element_rect(fill="#f5f5f5"),
            #axis.line.x=element_line(color="#000000"),
            #axis.text.x=element_text(size=12),
            axis.ticks=element_blank(),
            axis.title=element_text(size=12, face="bold"),
            axis.title.x=element_text(margin=margin(30,0,0,0)),
            axis.title.y=element_text(margin=margin(0,30,0,0)),
            plot.margin=unit(c(50, 20, 30, 20), "points"))
  })
})

