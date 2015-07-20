

# 
# output$test <- renderText({
#   print("enteredt test")
#   print(batterData()$df)
#   if(is.null(batterData()$df)) return()
#   batterData()$test
# })


observeEvent(batterData(),{
#observe({
#   print("batterData()")
#   print(batterData()$df)
#   if(is.null(batterData()$df)) return()
  df <- batterData()$df
 # print(str(df))
  
  df$Date <- as.Date(df$Date, format="%d %b %Y")
  
  all_values <- function(x) {
    if (is.null(x))
      return(NULL)
    row <- df[df$id == x$id, c("Opposition","Date","Runs","SR")]
    paste0(names(row),": ",format(row), collapse = "<br />")
  }
  
  df %>% 
    ggvis(~Runs,~SR, key := ~id) %>% 
    layer_points(size = 1, fill= ~Opposition) %>% 
   
    add_tooltip(all_values, "hover") %>% 
    bind_shiny("pl_strikeRate")
  
  
  df %>% 
    ggvis(~Date,~Runs, key := ~id) %>% 
    layer_points(size = 1, fill= ~Opposition) %>% 
    add_tooltip(all_values, "hover") %>% 
    bind_shiny("pl_batByDateChart")
  
  print(df$Runs)
  
dfOpp <-  df %>% 
    group_by(Opposition) %>% 
    summarize(avRuns=mean(Runs, na.rm=T), avSR=mean(SR,na.rm=T),inns=n()) %>% 
    mutate(Average=round(avRuns*1,2),SR=round(avSR*1,1))

dfOpp$id  <- 1:nrow(dfOpp)

opp_values <- function(x) {
  if (is.null(x))
    return(NULL)
  row <- dfOpp[dfOpp$id == x$id,c("Opposition","inns","Average","SR") ]
  paste0(names(row),": ",format(row), collapse = "<br />")
}

dfOpp  %>% 
    ggvis(~avRuns,~avSR,fill=~Opposition, key:= ~id) %>% 
    layer_points(size= ~sqrt(inns)) %>% 
  hide_legend("size") %>% 
  add_tooltip(opp_values, "hover") %>% 
   add_axis("x",title= "Batting Average") %>% 
   add_axis("y", title= "Average Strike Rate") %>% 
    bind_shiny("pl_batOppCharts") 
})


## rawData

output$pl_batRaw <- DT::renderDataTable({
  
  if(is.null(batterData())) return()
 
  batterData()$df %>% 
    select(Date,Opposition,Ground,Inns,Order=Pos,Dismissal,Runs,Mins,BF,SR) %>% 
    DT::datatable()
#     DT::datatable(rownames = checkboxRows(., checked=c(1:5)), escape = -1,
#                   ,options= list(paging = FALSE, searching = FALSE,info=FALSE, order = list(list(3, 'desc')))) 
#   
  
  
})