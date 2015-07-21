
output$playerPic <- renderUI({
  if (is.null(input$player))
    return ()
  #  if (is.null(playerPage()$imageDoc)) return ()
  
  
  if (!is.null(playerPage()$imageDoc)) {
    image <-  playerPage()$imageDoc %>%
      html_attr("src")
    
    src1 <- paste0("http://www.espncricinfo.com/",image)
    
    tags$img(src = src1)
  } else {
    HTML("No image Available")
  }
  
})
