


output$birthDate <- renderText({
  if (is.null(playerPage()))
    return()
  if (is.null(input$player))
    return()
  
  playerPage()$birthDoc
})


output$birthPlace <- renderLeaflet({
  if (is.null(playerPage()))
    return()
  
  loc <- playerPage()$birthPlace
  
  df <- geocode(loc)
  
  theLat <- df$lat
  theLon <- df$lon
  
  
  df    %>%
    leaflet() %>%
    addTiles() %>%
    setView(theLon,theLat, zoom = 9) %>%
    addMarkers()
})