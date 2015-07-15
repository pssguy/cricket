

output$birthDate <- renderText({
  if(is.null(playerPage())) return()
  if(is.null(input$player)) return()
  
  print(playerPage()$birthDoc)
  print("that was birthdoc")
  playerPage()$birthDoc
})


output$birthPlace <- renderLeaflet({
  if(is.null(playerPage())) return()

loc <- playerPage()$birthPlace
print(loc)
df <- geocode(loc)

theLat <- df$lat
theLon <- df$lon


df    %>%
  leaflet() %>%
  addTiles() %>% 
  setView(theLon,theLat, zoom=9) %>% 
  addMarkers()
})