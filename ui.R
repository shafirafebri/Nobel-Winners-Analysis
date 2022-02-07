# Design header
header <- dashboardHeader(title = "Nobel Winners Characteristic Analysis")

# Design sidebar
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(text = "Home", icon = icon("home"), tabName = "home"), # menu 1
    menuItem(text = "Top University", icon = icon("flag"), tabName = "top"), # menu 2
    menuItem(text = "Analysis", icon = icon("chart-area"), tabName = "content"),# menu 3
    menuItem(text = "Data Source", icon = icon("table"), tabName = "data") # menu 4
  )
)

# untuk design body dashboard
body <- dashboardBody(
  #home
  tabItems(
    tabItem(
      tabName = "home",
      fluidRow(
        # Welcome box
        box(
          title = "",
          status = "danger",
          width = 12,
          img(
            src = "nobel_prize.jpg",
            height = 50,
            width = 60
          ),
          h2("Capstone Project Interactive Plotting"),
          h4("Dynamic Web-based Analytics about Nobel Winners Characteristic"),
          br(),
          h4(
            "This project is one of my progress of learning data science in 2022.",
            "It was build on top of R for Nobel Winners Characteristic Analysis.",
            "Thank you for stopping by!"
          ),
          h4("To get started, select one of the sidepanel."),
          br(),
          h4(
            HTML('&copy'),
            'January 2022 By Shafira R. Febriyanti '
          )
        ),
        # Projects, companies, and facilities value boxes
        uiOutput("winner"),
        uiOutput("male"),
        uiOutput("female")

      )
    ),
    # menu tab 2
    tabItem(tabName = "top",
              
              fluidRow(
                box(width = 12, height = 200, title = "Choose year",
                    status = "danger",
                    selectInput(inputId = "year",
                                label = "Year list:",
                                choices = levels(year_factor$year),
                                selected = "2019")),

                column(width = 12,
                       plotlyOutput(outputId = "plot1")),

                
                  
                ),

            
          
    ),
    # menu tab 3
    tabItem(tabName = "content",
            tabsetPanel(
              tabPanel("Gender",
                       fluidRow(
                         box(width = 12, title = "Choose category",
                             status = "danger",
                             radioButtons(inputId = "category", 
                                         label = "Type of category:", 
                                         choices = levels(nobel_clean$category),
                                         selected = "economics")
                         ),
                      
                         column(width = 12,
                                plotlyOutput(outputId = "plot2"))
                       )),
              tabPanel("Age",
                       fluidRow(
  
                         column(width = 12, height= 24,
                                plotlyOutput(outputId = "plot3",height = 600))
                       )),
              

              
              )
           
            
    ),
    
    # menu tab 4
    tabItem(tabName = "data",
            fluidRow(box(width = 12, title = "Overview Nobel Winners Data",
                         status = "danger",
                         dataTableOutput(outputId = "nobel_data")),
      
            )
    )
  )
)

# untuk menggabungkan header, sidebar, dan body dalam 1 page dashboard
dashboardPage(header = header, sidebar = sidebar, body = body, skin = "red")