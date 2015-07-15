

dashboardPage(
  skin = "yellow",
  dashboardHeader(title = "Test Cricket"),
  
  dashboardSidebar(
    includeCSS("custom.css"),
    uiOutput("country"),
    uiOutput("a"),
    
    
    
    sidebarMenu(
      id = "sbMenu",
      
 
      
      
      menuItem(
        "Players", tabName = "players",icon = icon("table"),
        menuSubItem("At A Glance", tabName = "pl_glance"),
        menuSubItem("Info", tabName = "info",icon = icon("info")

        
      ),
      
      
  
      
  #    menuItem("Info", tabName = "info", icon = icon("info")),
      
      menuItem("", icon = icon("twitter-square"),
               href = "https://twitter.com/pssGuy"),
      menuItem("", icon = icon("envelope"),
               href = "mailto:agcur@rogers.com")
      
    )
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
              width = 12,title = "CricInfo Image",solidHeader = TRUE,status = 'success',
              collapsible = TRUE, collapsed = FALSE,
           
             htmlOutput("playerPic")
            )
          ),
          column(
            width = 4,
            box(
              width = 12,title = "Birth Details",solidHeader = TRUE,status = 'success',
              collapsible = TRUE, collapsed = FALSE,
              h5(textOutput("birthDate")),
              hr(),
              leafletOutput("birthPlace", height = 200)
            )
          ),
          column(
            width = 5,
            box(
              width = 12,  title = "CricInfo Summary",solidHeader = TRUE,status = 'success',
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
                 infoBoxOutput("careerBox", width = 12)),
          column(width = 3,
                 infoBoxOutput("runsBox", width = 12)),
          
          column(width = 3,
                 infoBoxOutput("wicketsBox", width = 12))
        )
        
        
        
        
      ),
      
      tabItem("info",includeMarkdown("info.md"))
      
      
      
      
      
      
      
    ) # tabItems
  ) # body
) # page
