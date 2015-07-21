



observeEvent(batterData(),{
  # simplify code
  df <- batterData()$df
  
  # returned as acharacter field
  df$Date <- as.Date(df$Date, format = "%d %b %Y")
  
  # set up tooltip
  all_values <- function(x) {
    if (is.null(x))
      return(NULL)
    row <- df[df$id == x$id, c("Opposition","Date","Runs","SR")]
    paste0(names(row),": ",format(row), collapse = "<br />")
  }
  
  # Series of ggvis charts
  df %>%
    ggvis( ~ Runs, ~ SR, key:= ~ id) %>%
    layer_points(size = 1, fill = ~ Opposition) %>%
    
    add_tooltip(all_values, "hover") %>%
    bind_shiny("pl_strikeRate")
  
  df %>%
    ggvis( ~ Date, ~ Runs, key:= ~ id) %>%
    layer_points(size = 1, fill = ~ Opposition) %>%
    add_tooltip(all_values, "hover") %>%
    bind_shiny("pl_batByDateChart")
  
  
  
  dfOpp <-  df %>%
    group_by(Opposition) %>%
    summarize(
      avRuns = mean(Runs, na.rm = T), avSR = mean(SR,na.rm = T),inns = n()
    ) %>%
    mutate(Average = round(avRuns * 1,2),SR = round(avSR * 1,1))
  
  dfOpp$id  <- 1:nrow(dfOpp)
  
  opp_values <- function(x) {
    if (is.null(x))
      return(NULL)
    row <-
      dfOpp[dfOpp$id == x$id,c("Opposition","inns","Average","SR")]
    paste0(names(row),": ",format(row), collapse = "<br />")
  }
  
  # need to cater for crash if there is no strike rate info
  dfOppSR <- dfOpp  %>%
    filter(!is.na(avSR))
  
  if (nrow(dfOppSR) > 0) {
    dfOppSR %>%
      ggvis( ~ avRuns, ~ avSR,fill =  ~ Opposition, key:= ~ id) %>%
      layer_points(size = ~ sqrt(inns)) %>%
      hide_legend("size") %>%
      add_tooltip(opp_values, "hover") %>%
      add_axis("x",title = "Batting Average") %>%
      add_axis("y", title = "Average Strike Rate") %>%
      bind_shiny("pl_batOppCharts")
  }
  
  
  df_Boundaries <- df %>%
    filter(!is.na(Fours)) %>%
    mutate(pc = round(100 * (Fours * 4 + Sixes * 6) / Runs,1))
  
  
  
  df_Boundaries$id  <- 1:nrow(df_Boundaries)
  #
  boundary_values <- function(x) {
    if (is.null(x))
      return(NULL)
    row <-
      df_Boundaries[df_Boundaries$id == x$id,c("Opposition","Date","Runs","Fours","Sixes","pc")]
    paste0(names(row),": ",format(row), collapse = "<br />")
  }
  
  df_Boundaries %>%
    ggvis( ~ Runs, ~ pc, key:= ~ id) %>%
    layer_points(fill = ~ Opposition) %>%
    add_tooltip(boundary_values, "hover") %>%
    bind_shiny("pl_batBoundaries")
  
})



## rawData

output$pl_batRaw <- DT::renderDataTable({
  if (is.null(batterData()))
    return()
  
  batterData()$df %>%
    select(Date,Opposition,Ground,Inns,Order = Pos,Dismissal,Runs,Mins,BF,SR) %>%
    DT::datatable()
  
  
})