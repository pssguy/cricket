

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
})