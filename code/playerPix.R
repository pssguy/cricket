# output$test <- renderText({
#   if (is.null(data())) return
#   data()$playerId
# })


output$playerPic <- renderUI({
  #print("enter pix")
  if (is.null(input$player)) return
  if (is.null(playerPage()$imageDoc)) return
  #print("entered pix")
  #print(playerPage()$imageDoc)
        #print("entered pix2")
  
  if (!is.null(playerPage()$imageDoc)) {
    #print("getting image")
    #print(playerPage()$imageDoc)
  image <-  playerPage()$imageDoc %>% 
      html_attr("src")
    #print(length(image))
    #print(image)
    
    src1 <- paste0("http://www.espncricinfo.com/",image)
    #print(src1) #1] "http://www.premierleague.com/content/dam/premierleague/shared-images/players/d/darren-bent/10738-lsh.jpg" is a picture
    tags$img(src=src1)
  } else {
    HTML("No image Available")
  }
  
})




# output$playerPic <- renderUI({
#   #print("enter pix")
#   if (is.null(input$player)) return
#   if (is.null(data())) return
#   #print("entered pix")
# #   if (is.null(input$player)) return
# #   if (is.null(data())) return
#   
#   # will prob split this into reactive
#   v <- paste0("http://www.espncricinfo.com/england/content/player/",data()$playerId,".html#statistics")
#  # #print(v)
#   #HTML(v)
#   doc <- html(v) #doc <- html("http://www.espncricinfo.com/england/content/player/8477.html#statistics")
# #   #print("docs")
# #   #print(doc)
# #   #print("docs done")
#   
#   if (!is.null(doc %>% 
#       html_node("#ciHomeContentlhs img"))) {
#   
#   image <- doc %>% 
#     html_node("#ciHomeContentlhs img") %>% 
#     html_attr("src")
#   #print(length(image))
#   #print(image)
#   
#       src1 <- paste0("http://www.espncricinfo.com/",image)
#       #print(src1) #1] "http://www.premierleague.com/content/dam/premierleague/shared-images/players/d/darren-bent/10738-lsh.jpg" is a picture
#       tags$img(src=src1)
#   } else {
#     HTML("No image Available")
#   }
#  
# })