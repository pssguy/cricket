

dashboardPage(
  skin = "yellow",
  dashboardHeader(title = "Test Cricket"),
  
  dashboardSidebar(
    uiOutput("a"),
    
    
    
    sidebarMenu(
      id = "sbMenu",
      
 
      
      
      menuItem(
        "Players", tabName = "players",icon = icon("table"),
        menuSubItem("At A Glance", tabName = "pl_glance")
#         menuSubItem("Career Summary", tabName = "pl_career"),
#         menuSubItem("Goal record", tabName = "pl_goals", selected = TRUE)
        
      ),
      
      
  
      
  #    menuItem("Info", tabName = "info", icon = icon("info")),
      
      menuItem("", icon = icon("twitter-square"),
               href = "https://twitter.com/pssGuy"),
      menuItem("", icon = icon("envelope"),
               href = "mailto:agcur@rogers.com")
      
    )
  ),
  dashboardBody(
    tabItems(
     
      ### Players section
      
      tabItem(
        "pl_glance",
        
        fluidRow(
          column(
            width = 3,
            box(
              width = 12,title = "Image",solidHeader = TRUE,status = 'success',
              collapsible = TRUE, collapsed = FALSE,
           
             htmlOutput("playerPic")
            )
          ),
          column(
            width = 3,
            box(
              width = 12,title = "Birth Place",solidHeader = TRUE,status = 'success',
              collapsible = TRUE, collapsed = FALSE,
              leafletOutput("playerBirthplace", height = 200)
            )
          ),
          column(
            width = 6,
            box(
              width = 12,title = "CricInfo Summary",solidHeader = TRUE,status = 'success',
              collapsible = TRUE, collapsed = FALSE,
              textOutput("playerSummary")
            )
          )
          
          
        ),
      #  hr(),
        
        fluidRow(
          column(width = 3,
                 infoBoxOutput("testsBox", width = 12)),
          
          column(width = 3,
                 infoBoxOutput("runsBox", width = 12)),
          
          column(width = 3,
                 infoBoxOutput("wicketsBox", width = 12))
        ),
        fluidRow(
          column(width = 3,
                 infoBoxOutput("goalsBox", width = 12)),
          column(width = 3,
                 infoBoxOutput("assistsBox", width = 12)),
          column(width = 3,
                 infoBoxOutput("cardsBox", width = 12))
        )
        
        
        
      )#,
      
      
     # tabItem("info", includeMarkdown("info.md"))
      
      
      
      
      
      
      
    ) # tabItems
  ) # body
) # page
