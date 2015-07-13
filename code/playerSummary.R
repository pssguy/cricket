# player Summary from cricinfo
# prob get this as well as pix from a reactive to save double dipping


output$test <- renderText({
  if (is.null(data())) return
  data()$playerId
})


output$playerSummary <- renderText({
  
  #print("enter summary")
  if (is.null(input$player)) return
  if (is.null(playerPage()$summaryDoc)) return
  #print("entered summary")
  
  if (!is.null(playerPage()$summaryDoc)) {
    summary <-  playerPage()$summaryDoc %>% 
      html_text(trim=TRUE) %>% 
     str_replace("  More","")
      
  } else {
    summary <-"No summary Available"
    summary
  }
 
}) 
  
  
  #if (is.null(data())) return()
  
  #input$player
#   #print("entered summary")
#   # will prob split this into reactive
#   v <- paste0("http://www.espncricinfo.com/england/content/player/",data()$playerId,".html#statistics")
#   #print(v)
#   #HTML(v)
#   doc <- html(v) #doc <- html("http://www.espncricinfo.com/england/content/player/8477.html#statistics")
#   #print("docs")
#   ##print(doc)
#   #print("docs done")
#   
#   
# #   summary <- doc %>% 
# #     html_node(".divSeparator+ .ciPlayerinformationtxt span") %>% 
# #     html_text(trim=TRUE) %>% 
# #     str_replace("  More","")
#   
#   if (!is.null(doc %>% 
#                html_node(".divSeparator+ .ciPlayerinformationtxt span"))) {
#     #print("get in")
#     summary <- doc %>% 
#       html_node(".divSeparator+ .ciPlayerinformationtxt span") %>% 
#       html_text(trim=TRUE) %>% 
#       str_replace("  More","")
#   } else {
#     summary <-"No Summary Available"
#   }
#   summary
