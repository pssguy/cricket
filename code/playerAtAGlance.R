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
  
  info = list(tests=tests)
  return(info)
})




output$testsBox <- renderInfoBox({
  infoBox(
    "Tests",playerData()$tests, icon = icon("futbol-o"),color = "light-blue")
  
})