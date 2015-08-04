




dashboardPage(
  skin = "yellow",
  dashboardHeader(title = "International Cricket"),
  
  dashboardSidebar(
    includeCSS("custom.css"),
    uiOutput("country"),
    uiOutput("a"),
    
    
    
    sidebarMenu(
      id = "sbMenu",
      
      
      
      
      menuItem(
        "Players", tabName = "players",icon = icon("table"),
        menuSubItem("At A Glance", tabName = "pl_glance"),
        menuSubItem("Test Batting", tabName = "pl_batting"),
        menuSubItem("ODI Batting", tabName = "plOD_batting"),
        menuSubItem("Bowling", tabName = "pl_bowling", selected = T)
        
        
        
      ),
      
      menuItem("Info", tabName = "info",icon = icon("info")),
      menuItem("Code",icon = icon("code-fork"),
               href = "https://github.com/pssguy/cricket"),
      
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
    
    
    
    
    
    tabItem("pl_batting",
            
            fluidRow(
              tabBox(
                # The id lets us use input$tabset1 on the server to find the current tab
                id = "tabset1", height = "500px",title = "Test Batting Charts- Hover Points for details", width =
                  12,side = "left",
                #                 tabPanel("Runs by Date",
                #                          ggvisOutput("pl_batByDateChart")),
                tabPanel("By Date",
                         fluidRow(
                           column(7,
                                  ggvisOutput("pl_batByDateChart")),
                           column(5,DT::dataTableOutput("pl_batYear"))
                         )),
                
                
                tabPanel("Strike rate",
                         ggvisOutput("pl_strikeRate")),
                
                
                tabPanel("By Opposition",
                         fluidRow(
                           column(7,
                                  ggvisOutput("pl_batOppCharts")),
                           column(5,DT::dataTableOutput("pl_batCountry"))
                         )),
                tabPanel("Boundary %",
                         ggvisOutput("pl_batBoundaries")),
                tabPanel("Dismissal Method",
                         fluidRow(
                           column(7,
                                  ggvisOutput("pl_batDismissals")),
                           column(5,rd3pieOutput("pl_batDismissalsPie"))
                         )),
                
                tabPanel("Raw Data",
                         DT::dataTableOutput("pl_batRaw"))
                
              )
            )),
    
    
    tabItem("plOD_batting",
            
            fluidRow(
              tabBox(
                # The id lets us use input$tabset1 on the server to find the current tab
                id = "tabset1OD", height = "500px",title = "ODI Batting Charts- Hover Points for details", width =
                  12,side = "left",
                
                tabPanel("By Date",
                         fluidRow(
                           column(7,
                                  ggvisOutput("plOD_batByDateChart")),
                           column(5,DT::dataTableOutput("plOD_batYear"))
                         )),
                
                
                tabPanel("Strike rate",
                         ggvisOutput("plOD_strikeRate")),
                
                
                tabPanel("By Opposition",
                         fluidRow(
                           column(7,
                                  ggvisOutput("plOD_batOppCharts")),
                           column(5,DT::dataTableOutput("plOD_batCountry"))
                         )),
                tabPanel("Boundary %",
                         ggvisOutput("plOD_batBoundaries")),
                tabPanel("Dismissal Method",
                         fluidRow(
                           column(7,
                                  ggvisOutput("plOD_batDismissals")),
                           column(5,rd3pieOutput("plOD_batDismissalsPie"))
                         )),
                
                tabPanel("Raw Data",
                         DT::dataTableOutput("plOD_batRaw"))
                
              )
            )),
    
    
    tabItem("pl_bowling",
            
            fluidRow(
              tabBox(
                # The id lets us use input$tabset1 on the server to find the current tab
                id = "tabset1", height = "500px",title = "Bowling Charts- Hover Points for details", width =
                  12,side = "left",
               
#                 tabPanel("By Date",
#                          fluidRow(
#                            column(7,
#                                   ggvisOutput("pl_batByDateChart")),
#                            column(5,DT::dataTableOutput("pl_batYear"))
#                          )),
#                 
#                 
#                 tabPanel("Strike rate",
#                          ggvisOutput("pl_strikeRate")),
#                 
#                 
#                 tabPanel("By Opposition",
#                          fluidRow(
#                            column(7,
#                                   ggvisOutput("pl_batOppCharts")),
#                            column(5,DT::dataTableOutput("pl_batCountry"))
#                          )),
#                 tabPanel("Boundary %",
#                          ggvisOutput("pl_batBoundaries")),
#                 tabPanel("Dismissal Method",
#                          fluidRow(
#                            column(7,
#                                   ggvisOutput("pl_batDismissals")),
#                            column(5,rd3pieOutput("pl_batDismissalsPie"))
#                          )),
                
                tabPanel("Raw Data",
                         DT::dataTableOutput("pl_bowlRaw"))
                
              )
            )),
    
    
    tabItem("info",includeMarkdown("info.md"))
    
    
    
    
    
    
    
  ) # tabItems
  ) # body
  ) # page
  