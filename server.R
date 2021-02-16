library(googleVis)
shinyServer(function(input, output) {
  output$genbar = renderPlot({
    ggplot(data = uberdata) + geom_bar(aes(x = Status, fill = Pickup.point), stat =
                                         'count') + coord_flip() + scale_fill_discrete(name = "Pickup Point") + ylab("Count")
  })
  output$genbartext = renderText({
    "hi"
  })
  output$twobars = renderPlot({
    ggplot(data = uberdata %>% filter(Status != "Trip Completed")) + geom_bar(aes(x =
                                                                                    factor(
                                                                                      timeofday,
                                                                                      level = c(
                                                                                        '12AM-3:59AM',
                                                                                        '4AM-7:59AM',
                                                                                        '8AM-11:59AM',
                                                                                        '12PM-3:59PM',
                                                                                        '4PM-7:59PM',
                                                                                        '8PM-11:59PM'
                                                                                      )
                                                                                    ), fill = Pickup.point), position = "dodge") + facet_wrap( ~ Status) + xlab("Time of Day") +
      ylab("Count") + scale_fill_discrete(name = "Pickup Point") + theme(axis.text =
                                                                           element_text(size = 9, color = 'black'), axis.text.x = element_text(angle = 30))
  })
  output$totals = renderPlot({
    ggplot(data = uberdata) + geom_bar(aes(x = factor(
      timeofday,
      level = c(
        '12AM-3:59AM',
        '4AM-7:59AM',
        '8AM-11:59AM',
        '12PM-3:59PM',
        '4PM-7:59PM',
        '8PM-11:59PM'
      )
    ), fill = Pickup.point)) + xlab("Time of Day") + ylab("Count") + scale_fill_discrete(name = "Pickup Point") +
      theme(axis.text = element_text(size = 9, color = 'black'), axis.text.x = element_text(angle = 30)) + ggtitle("Total Requests") + theme(plot.title = element_text(hjust = 0.5))
  })
  output$twobartext = renderText({
    "hello"
  })
  output$svda = renderGvis({
    gvisLineChart(
      forgvA,
      xvar = "timeofday",
      yvar = c("Requests Completed", "Total Requests"),
      options = list(
        title = "Pickup Point: Airport",
        colors = "['green', 'red']",
        width = 900,
        height = 500
      )
    )
  })
  output$svdc = renderGvis({
    gvisLineChart(
      forgvC,
      xvar = "timeofday",
      yvar = c("Requests Completed", "Total Requests"),
      options = list(
        title = "Pickup Point: City",
        colors = "['green', 'red']",
        width=900, height=500
      )
    )
  })
  output$svdtext = renderText({
    "hello"
  })
  output$pie = renderPlot({
    ggplot(data = uberdata) + geom_bar(aes(x = '', fill = Status), position =
                                         'fill') + facet_wrap( ~ factor(
                                           timeofday,
                                           level = c(
                                             '12AM-3:59AM',
                                             '4AM-7:59AM',
                                             '8AM-11:59AM',
                                             '12PM-3:59PM',
                                             '4PM-7:59PM',
                                             '8PM-11:59PM'
                                           )
                                         )) + coord_polar(theta = 'y', start = 0) + theme_void() + scale_fill_manual(values = c('red1', 'red3', 'seagreen4'))
  })
  output$pietext = renderText({
    "hello"
  })
  output$table <- DT::renderDataTable({
    datatable(uberdata, rownames = FALSE)
  })
})
