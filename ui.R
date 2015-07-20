


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
        menuSubItem("Batting", tabName = "pl_batting", selected=T),
        menuSubItem("Info", tabName = "info",icon = icon("info"))
        
        
      ),
      
      
      
      menuItem(
        "Other Dashboards",
        menuSubItem("Climate",href = "https://mytinyshinys.shinyapps.io/climate"),
        menuSubItem("Mainly Maps",href = "https://mytinyshinys.shinyapps.io/mainlyMaps"),
        menuSubItem("MLB",href = "https://mytinyshinys.shinyapps.io/mlbCharts"),
        
        menuSubItem("WikiGuardian",href = "https://mytinyshinys.shinyapps.io/wikiGuardian"),
        menuSubItem("World Soccer",href = "https://mytinyshinys.shinyapps.io/worldSoccer")
        
      ),
      
      menuItem("", icon = icon("twitter-square"),
               href = "https://twitter.com/pssGuy"),
      menuItem("", icon = icon("envelope"),
               href = "mailto:agcur@rogers.com")
      
      
    )
  ),
  dashboardBody(tabItems(
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
    
    
    #       tabItem("pl_batting",
    #               box(
    #                 textOutput("test"),
    #                 ggvisOutput("pl_strikeRate")
    #
    #               )),
    
    
    tabItem("pl_batting",
            
            fluidRow(
              tabBox(
                # The id lets us use input$tabset1 on the server to find the current tab
                id = "tabset1", height = "500px",title="Batting Charts", width=12,side="right",
                tabPanel("Runs by Date",
                         ggvisOutput("pl_batByDateChart")), # could add a table here
                tabPanel("Strike rate",
                         ggvisOutput("pl_strikeRate")),
                
                
                tabPanel("By Opposition",
                         ggvisOutput("pl_batOppCharts")),
                tabPanel("Boundary %",
                        ggvisOutput("pl_batBoundaries")),
                tabPanel("Raw Data",
                         DT::dataTableOutput("pl_batRaw"))
                
              ) #tabbox
              ) # fluidrow
            
            ), #tabItem
              
              
              
              #       tabItem("fortune",
              #               fluidRow(
              #                 tabBox(
              #                   # The id lets us use input$tabset1 on the server to find the current tab
              #                   id = "tabset1", height = "500px",
              #                   tabPanel("Choropleth Click State for Table",
              #                            leafletOutput("choropleth")),
              #                   tabPanel("Locations. Click for Details",
              #                            leafletOutput("locations")),
              #
              #                   tabPanel("HexBins",
              #                            statebinOutput("statebins"))
              #                 ),
              #
              #                 box(
              #                   width = 6, status = "success", solidHeader = TRUE,
              #                   title = "Leading Companies within State - Use with Choropleth",
              #                   DT::dataTableOutput("table")
              #
              #                 )
              #               )),
              
              
              
              tabItem("info",includeMarkdown("info.md"))
              
              
              
              
              
              
              
            ) # tabItems
    ) # body
    ) # page
    