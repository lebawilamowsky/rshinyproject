library(googleVis)
shinyServer(function(input, output) {
  output$genbar = renderPlot({
    ggplot(data = uberdata) + geom_bar(aes(x = Status, fill = Pickup.point), stat =
                                         'count') + coord_flip() + scale_fill_discrete(name = "Pickup Point") + ylab("Count")
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
    'Here are two bar graphs displaying a closer look at the categories "cancelled" and 
    "no cars available". These graphs incorporate time and place so that we know both where 
    and when the issues are happening most. We see that Uber would greatly benefit from 
    more drivers completing trips in the city area before noon and more drivers in the 
    airport area in the evenings after 4:00 PM.'
  })
  output$svda = renderGvis({
    gvisLineChart(
      forgvA,
      xvar = "timeofday",
      yvar = c("Requests Completed", "Total Requests"),
      options = list(
        title = "Pickup Point: Airport",
        colors = "['green', 'red']", width=800, height=350
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
        colors = "['green', 'red']",width=800, height=350
      )
    )
  })
  output$svdtext = renderText({
    'Here is a visualization of how great the "supply-demand" gap is.We see that 
    the supply barely correlates with the demand, as a similar amount of requests 
    are completed when the demand is huge as when the demand is small. It would be 
    beneficial for Uber to emphasize when and where the demand is high to its 
    current drivers and potential new drivers.'
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
    "Through displaying the proportions of request statuses per timeframe, these pie charts 
    illustrate Uber's reliability for trips between city and airport. We can see that 
    12:00 PM - 3:59 PM is the only timeframe during which more than 50% percent of 
    requests are completed. This means that for the majority of the day, Uber is pretty 
    unreliable, as less than 50% of requests get completed. Most people end up unsatisfied 
    with Uber during most of the day for this category of trips."
  })
  output$table <- DT::renderDataTable({
    datatable(uberdata, rownames = FALSE)
  })
})
