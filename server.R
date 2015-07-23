
shinyServer(function(input, output, session) {
  ## create input panels
  
  output$country <- renderUI ({
    inputPanel(
      selectInput(
        "country", "Select Country(ies)", countryChoice, multiple = TRUE, selected = "India"
      )
    )
  })
  
  output$a <- renderUI({
    if (is.null(input$country))
      return()
    
    theChoice <-
      testPlayers[testPlayers$teamName %in% input$country,]$playerId
    names(theChoice) <-
      testPlayers[testPlayers$teamName %in% input$country,]$player
    
    inputPanel(
      selectizeInput(
        "player","Select or Type Player's Name",theChoice,  options = list(maxOptions =
                                                                             10000)
      ),
      actionButton("getPlayer","Get Data (takes a few seconds)")
    )
    
  })
  
  
  ## basic processing
  
  data <- eventReactive(input$getPlayer,{
    input$getPlayer
    
    if (is.null(input$country))
      return()
    if (is.null(input$player))
      return()
    
    playerId <- input$player
    
    
    # download bowling data - though not implemented yet
    bowler <- getPlayerData(profile = input$player,type = "bowling")
    
    batter <- getPlayerData(profile = input$player,type = "batting")
    
    
    ## cannot have space in colname
    colnames(batter)[12] <- "startDate"
    colnames(bowler)[10] <- "startDate"
    
    
    
    
    info = list(playerId = playerId,batter = batter,bowler = bowler)
    return(info)
    
  })
  
  ## obtain more info from Cricinfo not provided by package
  # playerPage <- reactive({
  playerPage <- eventReactive(data(),{
    #if (is.null(data())) return
    
    
    v <-
      paste0(
        "http://www.espncricinfo.com/england/content/player/",data()$playerId,".html#statistics"
      )
    
    doc <- html(v)
    
    
    
    imageDoc <- doc %>%
      html_node("#ciHomeContentlhs img")
    
    ## There are a couple of different sources of summary information
    summaryDoc <- doc %>%
      html_node(".divSeparator+ .ciPlayerinformationtxt span")
    
    if (is.null(summaryDoc)) {
      summaryDoc <- doc %>%
        html_node(".ciPlayerprofiletext1")
    }
    
    birthDoc <- doc %>%
      html_node(".ciPlayerinformationtxt:nth-child(2) span") %>%
      html_text(trim = TRUE)
    
    # create Birth information
    a <-  str_split(birthDoc,",")
    
    birthDate <- paste0(a[[1]][1],",",a[[1]][2])
    
    birthPlace <- birthDoc %>%
      str_replace(birthDate,"") %>%
      str_replace(",","") %>%
      str_trim(.)
    
    
    info = list(
      imageDoc = imageDoc, summaryDoc = summaryDoc, birthPlace = birthPlace,birthDate =
        birthDate, birthDoc = birthDoc
    )
    return(info)
    
  })
  
  
  ##
  batterData <- eventReactive(data(),{
    batter <- data()$batter
    
    
    
    colnames(batter)[12] <- "Date"
    
    df <-  batter %>%
      filter(Runs != "DNB" & Runs != "TDNB") %>%
      mutate(Runs = str_replace(Runs,"[*]","")) %>% ## need to keep this in actually
      mutate(Runs = as.integer(Runs),SR = as.numeric(SR)) %>%
      mutate(Opposition = str_replace(Opposition,"v ",""))
    
    # Munging prob wit cols starting with number
    
    colnames(df)[4] <- "Fours"
    df$Fours <- as.integer(df$Fours)
    colnames(df)[5] <- "Sixes"
    df$Sixes <- as.integer(df$Sixes)
    
    
    df$id <- 1:nrow(df)
    
    info = list(df = df)
    return(info)
  })
  
  # outlying code
  source("code/playerPix.R", local = TRUE)
  source("code/playerSummary.R", local = TRUE)
  source("code/playerAtAGlance.R", local = TRUE)
  source("code/playerBirth.R", local = TRUE)
  source("code/playerBatting.R", local = TRUE)
  
})
