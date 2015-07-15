## ata  glance



playerData <- reactive({
  if (is.null(data())) return()
  
  batter <- data()$batter
  bowler <- data()$bowler
  
  print(glimpse(batter))
  print(glimpse(bowler))
  
  ## career range
  
  
  
  start <- str_sub(head(batter,1)$startDate,-4)
  end <- str_sub(tail(batter,1)$startDate,-4)
  
  showCareer <-  paste0(start," - ",end)
  
  batTests <- batter %>% 
    select(startDate)
  
  tests <-nrow(bowler %>% 
                 select(startDate) %>% 
                 rbind(batTests) %>% 
                 unique())
  print("tests")
print(tests) # good to here
print("peinted tests")
write_csv(batter,"batterTest.csv")

  sumRuns <- batter %>% 
    summarize(totRuns=sum(extract_numeric(batter$Runs), na.rm=T)) 
  
  sumRuns <- sumRuns$totRuns
  
  print(sumRuns)
  
  sumOuts <- batter %>% 
    filter(Dismissal!="not out"&Dismissal!="-") %>% 
    nrow()
  
  print(sumOuts) 
  batAv <- round(sumRuns/sumOuts,1)
  
  print(batAv)
  
  if(is.nan(batAv)) { 
    showBat <- "0 - 0"
  } else {
    showBat <- paste0(sumRuns," - ",batAv)
  }
  showBat <- paste0(sumRuns," - ",batAv)
  
  
  summaryBowling <- bowler %>% 
    summarize(totRuns=sum(extract_numeric(bowler$Runs), na.rm=T),
              totWickets=sum(extract_numeric(bowler$Wkts), na.rm=T),
              bowlingAv = round(totRuns/totWickets,1))
  
  print("check")
  print(summaryBowling$bowlingAv)
  if(is.nan(summaryBowling$bowlingAv)) { 
    showBowl <- "0 - 0"
    } else {
  showBowl <- paste0(summaryBowling$totWickets," - ",summaryBowling$bowlingAv)
    }
  info = list(tests=tests, showBat=showBat, showBowl= showBowl, showCareer=showCareer)
  return(info)
})


output$careerBox<- renderInfoBox({
  infoBox(
    "Career",playerData()$showCareer, icon = icon("futbol-o"),color = "light-blue")
  
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