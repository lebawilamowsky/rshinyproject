shinyUI(dashboardPage(
  skin="yellow",
  dashboardHeader(title = "Uber Trips (Airport<->City) Analysis, Weekdays 2016", tags$li(img(src='uberapp.png',height=50,width=50),class="dropdown"), titleWidth=480),
  dashboardSidebar(
    sidebarUserPanel("Leba Wilamowsky"),
    sidebarMenu(menuItem("Introduction", tabName = "intro"), 
                menuItem("General Problem Overview", tabName = "generalbar"),
                menuItem("Pinpointing the Issue", tabName = "twobars"),
                menuItem('"Supply V. Demand"', tabName = "svd"),
                menuItem("Illustrating Reliability", tabName = "piecharts"),
                menuItem("Conclusion", tabName = "conc"),
                menuItem("Data Table", tabName="data")
    )
),
dashboardBody(
  tabItems(
    tabItem(
      tabName = 'intro',
      h1('Introduction'),
      img(src = "uberpic.png",
          height = 300,
          width = 600),
      p("Due to the great demand, Uber can potentially gain a lot of revenue from rides to 
        and from airports. Uber has a problem that hurts its income. This problem is that very 
        often people who request rides to or from the airport are let down by Uber; 
        there are no drivers available and/or drivers cancel on them. What this means is 
        that Uber is making much less money than it has the potential to. What this also 
        means is that people may become less inclined to use Uber in the future, after 
        experiencing it as an unreliable company or hearing about it as so."),
      p("Luckily, there are ways to help reduce the problem; and pinpointing the problem 
        is helpful to come up with more specific, targeted solutions. To pinpoint where and 
        when the problem mainly lies, data from Uber can be analyzed. Based on what the data 
        shows, solutions can be targeted, and therefore as effective as possible."),
      p("The dataset used for analysis is a masked data set which is similar to what data 
        analysts at Uber handle. The source of the dataset is a company called upGrad. It 
        contains 6,745 observations of trips between city and airport during regular weekdays 
        of a week in July 2016. So, it is used as a sample set representing Uber trips between 
        city and airport when it is not a holiday or weekend. The data looks at trip requests 
        and tells us whether a request was accepted and completed, accepted and then cancelled 
        by the driver, or was unaccepted due to no cars being available."),
    ),
    tabItem(
      tabName="generalbar",
      fluidRow(column(11,plotOutput("genbar")
                   )),
      fluidRow(p("From the bar graph, we see that out of all requested Uber trips, more trips don't end up 
    happening than do end up happening. Uber could be completing over 100% more trips in this 
    category of trips than it does. This means that Uber is missing out on a lot of revenue. 
    This also means that most of the time, Uber can't be relied upon for trips to and from 
        the airport, which is detrimental to Uber's reputation.")),
      fluidRow(p("We see that both cancellations and nonavailability of cars are quite common. Nonavailability 
    of cars is Uber's top issue, particularly by the airport. When analyzing requests with city 
    as the pickup point, cancellations and nonavailability are both big issues. When analyzing 
    requests with airport as the pickup point, the problem of cancellations pales in comparison 
    to the problem of nonavailability."))),
    tabItem(
      tabName="twobars",
      fluidRow(box(plotOutput("twobars"), width=1000, height=500)),
      fluidRow(column(8, plotOutput("totals")), column(4, (textOutput("twobartext")))
    )),
    tabItem(
      tabName="svd",
      fluidRow(textOutput("svdtext")),
      fluidRow(htmlOutput("svda")),
      fluidRow(htmlOutput("svdc"))
    ),
    tabItem(
      tabName="piecharts",
      fluidRow(column(8,plotOutput("pie")), column(4, textOutput("pietext")))
    ),
    tabItem(
      tabName="conc",
      h1('Conclusion'),
      
      p("This data and analysis can be used by Uber for internal discussion, and also 
        can be used by companies similar to Uber, as it tells companies when drivers 
        are most needed at the airports and when drivers are most needed to bring people 
        to airports from cities. The data and analysis can also provide insights for 
        drivers. (As noted earlier, this analysis applies to weekdays.)"),
      p("Uber can provides incentives for drivers to fulfill requests in the cities in
        the morning hours and airports in the evening hours, like bonuses or salary boosts.
        Uber can also impose penalties on drivers for accepting and then cancelling requests,
        unless the cancellation is done for a very legitimate reason. Cancellations can frustrate 
        customers even more than no cars being available. It is more of a let-down for a customer 
        to think they have a ride and then be cancelled on, than for them to know right away that 
        there are no cars available. It is possible that by now, the year 2021, Uber has implemented 
        new policies regarding cancellation. Perhaps there are already, or if not there should be, 
        policies about drivers getting penalties after cancelling a certain percentage of rides 
        they accept. Drivers do need the right to cancel, 
        since they can encounter a customer with a very low rating or a customer that they can't find 
        and get in touch with. The point is that they shouldn't do it often enough that it can hurt 
        Uber's reputation and revenue."),
      p("Uber should also try to attract new drivers and create incentives for them to join the 
        company, and particularly incentives to accept trips between airport and city. Uber can 
        attract new drivers by showing that they have so many requests that aren't being fulfilled. 
        People can be attracted to join the company if they know that they're basically guaranteed 
        to get driving jobs."),
      p("A solution to improve Uber's reputation for reliability is to promote bookings in advance. 
        Uber actually introduced a feature in 2016 that allows for scheduling rides in advance. When 
        people know that scheduling a car in advance is a choice that they can choose, they can see 
        Uber as more dependable. If they choose to do book in advance, the frustrating scenario of no 
        cars being available, which can turn people away from relying on Uber in general, can be avoided."),
      p("I'd like to point out that this analysis is mainly beneficial for the Uber company in 2016 and soon after. 
        I think it would be interesting to analyze Uber's data since then to see if trends have shifted, 
        and if those trends shifted after the introduction of ideas like those I mentioned and/or other
        changes in the company.")
    ),
    
    tabItem(tabName = "data", # datatable
            fluidRow(box(DT::dataTableOutput("table"),
                         width=12)))
    ))))

