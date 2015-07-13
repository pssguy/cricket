## ata  glance



playerData <- reactive({
  if (is.null(data())) return()
  
  batter <- data()$batter
  bowler <- data()$bowler
  
  batTests <- batter %>% 
    select(startDate)
  
  tests <-nrow(bowler %>% 
                 select(startDate) %>% 
                 rbind(batTests) %>% 
                 unique())
  
#print(tests)
  
  sumRuns <- batter %>% 
    summarize(totRuns=sum(extract_numeric(batter$Runs), na.rm=T)) #5200
#print(sumRuns)
  
  sumOuts <- batter %>% 
    filter(Dismissal!="not out"&Dismissal!="-") %>% 
    nrow()
  
  batAv <- round(sumRuns/sumOuts,1)
  
  showBat <- paste0(sumRuns," - ",batAv)
  
  
  summaryBowling <- bowler %>% 
    summarize(totRuns=sum(extract_numeric(bowler$Runs), na.rm=T),
              totWickets=sum(extract_numeric(bowler$Wkts), na.rm=T),
              bowlingAv = round(totRuns/totWickets,1))
  
  showBowl <- paste0(summaryBowling$totWickets," - ",summaryBowling$bowlingAv)
  
  info = list(tests=tests, showBat=showBat, showBowl= showBowl)
  return(info)
})




output$testsBox <- renderInfoBox({
  infoBox(
    "Tests",playerData()$tests, icon = icon("futbol-o"),color = "light-blue")
  
})
output$runsBox <- renderInfoBox({
  infoBox(
    "Runs",playerData()$showBat , icon = icon("futbol-o"),color = "light-blue",subtitle=" Tot - Av " )
  
})
output$wicketsBox <- renderInfoBox({
  infoBox(
    "Wickets",playerData()$showBowl, icon = icon("futbol-o"),color = "light-blue",subtitle="Tot - Av")
  
})