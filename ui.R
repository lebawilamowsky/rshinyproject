shinyUI(dashboardPage(
  skin="yellow",
  dashboardHeader(title = "Uber Trips (Airport<->City) Analysis, Weekdays 2016", titleWidth=480),
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
      img(src = "uberpic.png", height = 300, width = 600),
      
      p("This is where intro text goes"),
    ),
    tabItem(
      tabName="generalbar",
      fluidRow(column(11,plotOutput("genbar")
                   )),
      textOutput('genbartext')),
    tabItem(
      tabName="twobars",
      fluidRow(box(plotOutput("twobars"), width=1000, height=500)),
      fluidRow(column(8, plotOutput("totals")), column(4, (textOutput("twobartext")))
    )),
    tabItem(
      tabName="svd",
      fluidRow(htmlOutput("svda")),
      fluidRow(htmlOutput("svdc")),
      fluidRow(textOutput("svdtext"))
    ),
    tabItem(
      tabName="piecharts",
      fluidRow(column(8,plotOutput("pie")), column(4, textOutput("pietext")))
    ),
    tabItem(
      tabName="conc",
      h1('Conclusion'),
      
      p("This is where conc text goes"),
    ),
    tabItem(tabName = "data", # datatable
            fluidRow(box(DT::dataTableOutput("table"),
                         width=12)))
    ))))

