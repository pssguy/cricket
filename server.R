

shinyServer(function(input, output, session) {
  
 
  
  # check
  output$a <- renderUI({

    selectizeInput("player","Select Player",playerChoice,  options=list(maxOptions=10000))
    
  })
  # outlying code
  source("code/playerPix.R", local=TRUE)
  source("code/playerSummary.R", local=TRUE)
  source("code/playerAtAGlance.R", local=TRUE)
  
  ## basic processing
  
  data <- reactive({
    
    if(is.null(input$player)) return()
    print("enter data reactive")
    playerId <- input$player
    print(playerId)
    
    
    ## use package
    bowler<- getPlayerData(profile=input$player,file="tempBowl.csv",type="bowling",homeOrAway=c(1,2),
                           result=c(1,2,4))
    batter<- getPlayerData(profile=input$player,file="tempBat.csv",type="batting",homeOrAway=c(1,2),
                           result=c(1,2,4))
    
    print(glimpse(bowler))
    print(glimpse(batter))
    colnames(batter)[12] <- "startDate"
    colnames(bowler)[10] <- "startDate" # might be issue with this had 11 before may differ if actually bowled
    print(glimpse(bowler))
    print(glimpse(batter))
    
    
    info=list(playerId=playerId,batter=batter,bowler=bowler)
    return(info)
    
  })
  
  playerPage <- reactive({
    
    if (is.null(data())) return
    print("entered playerPage")
    
    v <- paste0("http://www.espncricinfo.com/england/content/player/",data()$playerId,".html#statistics")
    print(v) #"http://www.espncricinfo.com/england/content/player/4091.html#statistics"
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
    
    
    print("summaryDoc")
    print(summaryDoc)
    print("imageDoc")
    print(imageDoc)
    
    info=list(imageDoc=imageDoc, summaryDoc=summaryDoc)
    return(info)
    
  })
  
  

}) # end


