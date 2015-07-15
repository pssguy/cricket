

shinyServer(function(input, output, session) {
  
  output$country <- renderUI ({
    inputPanel(
    selectInput("country", "Select Countries", countryChoice, multiple=TRUE, selected = "India")
  )
  })
  
  output$a <- renderUI({
    if (is.null(input$country)) return()
    
    theChoice <- testPlayers[testPlayers$teamName %in% input$country,]$playerId
    names(theChoice) <- testPlayers[testPlayers$teamName %in% input$country,]$player
    
    inputPanel(
    selectizeInput("player","Select Player",theChoice,  options=list(maxOptions=10000)),
    actionButton("getPlayer","Get Data")
    )
    
  })
  # outlying code
  source("code/playerPix.R", local=TRUE)
  source("code/playerSummary.R", local=TRUE)
  source("code/playerAtAGlance.R", local=TRUE)
  source("code/playerBirth.R", local=TRUE)
  
  ## basic processing
  
  data <- eventReactive(input$getPlayer,{
    
    
    input$getPlayer
    
    if (is.null(input$country)) return()
    if(is.null(input$player)) return()
    #print("enter data reactive")
    playerId <- input$player
    #print(playerId)
    
    
    ## use package
    bowler<- getPlayerData(profile=input$player,file="tempBowl.csv",type="bowling",homeOrAway=c(1,2),
                           result=c(1,2,4))
    batter<- getPlayerData(profile=input$player,file="tempBat.csv",type="batting",homeOrAway=c(1,2),
                           result=c(1,2,4))
    
    #print(glimpse(bowler))
    #print(glimpse(batter))
    colnames(batter)[12] <- "startDate"
    colnames(bowler)[10] <- "startDate" # might be issue with this had 11 before may differ if actually bowled
    #print(glimpse(bowler))
    #print(glimpse(batter))
    
    write_csv(bowler,"bowlerTest.csv")
    
    
    info=list(playerId=playerId,batter=batter,bowler=bowler)
    return(info)
    
  })
  
  playerPage <- reactive({
    
    if (is.null(data())) return
    #print("entered playerPage")
    
    v <- paste0("http://www.espncricinfo.com/england/content/player/",data()$playerId,".html#statistics")
    #print(v) #"http://www.espncricinfo.com/england/content/player/4091.html#statistics"
    doc <- html(v)
   # doc <-html("http://www.espncricinfo.com/england/content/player/4091.html#statistics")
    
    
    imageDoc <- doc %>% 
      html_node("#ciHomeContentlhs img") 
    
   
    summaryDoc <- doc %>% 
         html_node(".divSeparator+ .ciPlayerinformationtxt span")
    if(is.null(summaryDoc)){
    summaryDoc <- doc %>% 
      html_node(".ciPlayerprofiletext1")
    }
    
    birthDoc <- doc %>% 
        html_node(".ciPlayerinformationtxt:nth-child(2) span") %>% 
      html_text(trim = TRUE)
    print(birthDoc)
    
    #July 3, 1851, Woolwich, Kent, England"
    
    # test <- "July 3, 1851, Woolwich, Kent, England"
    
  a <-  str_split(birthDoc,",")
    birthDate <- paste0(a[[1]][1],",",a[[1]][2])
#     birthPlace <- str_replace(birthDoc,birthDate,"") 
#     paste0(a[[1]][3],a[[1]][4],a[[1]][5],a[[1]][6])
    
birthPlace <- birthDoc %>% 
      str_replace(birthDate,"") %>% 
      str_replace(",","") %>% 
      str_trim(.)
print("birthPlace")
print(birthPlace)
    
    
#     #print("summaryDoc")
#     #print(summaryDoc)
#     #print("imageDoc")
#     #print(imageDoc)
    
    info=list(imageDoc=imageDoc, summaryDoc=summaryDoc, birthPlace=birthPlace,birthDate=birthDate, birthDoc=birthDoc)
    return(info)
    
  })
  
  

}) # end


