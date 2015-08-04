




# observeEvent(batterData(),{
#   # simplify code
#   df <- bowlingData()$df
#   
#   # returned as acharacter field
#   df$Date <- as.Date(df$Date, format = "%d %b %Y")
#   
#   write_csv(df,"testdf.csv")
#   
#   # set up tooltip
#   all_values <- function(x) {
#     if (is.null(x))
#       return(NULL)
#     row <- df[df$id == x$id, c("Opposition","Date","Runs","SR")]
#     paste0(names(row),": ",format(row), collapse = "<br />")
#   }
#   
#   # Series of ggvis charts
#   df %>%
#     ggvis(~ Runs, ~ SR, key := ~ id) %>%
#     layer_points(size = 1, fill = ~ Opposition) %>%
#     
#     add_tooltip(all_values, "hover") %>%
#     bind_shiny("pl_strikeRate")
#   
#   df %>%
#     ggvis(~ Date, ~ Runs, key := ~ id) %>%
#     layer_points(size = 1, fill = ~ Opposition) %>%
#     add_tooltip(all_values, "hover") %>%
#     bind_shiny("pl_batByDateChart")
#   
#   
#   
#   dfOpp <-  df %>%
#     group_by(Opposition) %>%
#     summarize(
#       avRuns = mean(Runs, na.rm = T), avSR = mean(SR,na.rm = T),inns = n()
#     ) %>%
#     mutate(Average = round(avRuns * 1,2),SR = round(avSR * 1,1))
#   
#   dfOpp$id  <- 1:nrow(dfOpp)
#   
#   opp_values <- function(x) {
#     if (is.null(x))
#       return(NULL)
#     row <-
#       dfOpp[dfOpp$id == x$id,c("Opposition","inns","Average","SR")]
#     paste0(names(row),": ",format(row), collapse = "<br />")
#   }
#   
#   # need to cater for crash if there is no strike rate info
#   dfOppSR <- dfOpp  %>%
#     filter(!is.na(avSR))
#   
#   if (nrow(dfOppSR) > 0) {
#     dfOppSR %>%
#       ggvis(~ avRuns, ~ avSR,fill =  ~ Opposition, key := ~ id) %>%
#       layer_points(size = ~ sqrt(inns)) %>%
#       hide_legend("size") %>%
#       add_tooltip(opp_values, "hover") %>%
#       add_axis("x",title = "Batting Average") %>%
#       add_axis("y", title = "Average Strike Rate") %>%
#       bind_shiny("pl_batOppCharts")
#   }
#   
#   
#   df_Boundaries <- df %>%
#     filter(!is.na(Fours)) %>%
#     mutate(pc = round(100 * (Fours * 4 + Sixes * 6) / Runs,1))
#   
#   
#   
#   df_Boundaries$id  <- 1:nrow(df_Boundaries)
#   #
#   boundary_values <- function(x) {
#     if (is.null(x))
#       return(NULL)
#     row <-
#       df_Boundaries[df_Boundaries$id == x$id,c("Opposition","Date","Runs","Fours","Sixes","pc")]
#     paste0(names(row),": ",format(row), collapse = "<br />")
#   }
#   
#   df_Boundaries %>%
#     ggvis(~ Runs, ~ pc, key := ~ id) %>%
#     layer_points(fill = ~ Opposition) %>%
#     add_tooltip(boundary_values, "hover") %>%
#     bind_shiny("pl_batBoundaries")
#   
#   ## dismissals
#   df$Dismissal <- factor(df$Dismissal, levels = c("bowled", "caught", "lbw", "run out", "stumped","not out"))
#   
#   
#   dfChart <- df %>% 
#     filter(Dismissal != "-") 
#   
#   dfChart$Dismissal <- factor(dfChart$Dismissal, levels = c("bowled", "caught", "lbw", "run out", "stumped","not out"))
#   
#                               dfChart %>% 
#                                 ggvis(~Dismissal, ~Runs) %>% 
#                                 layer_points(size=2, fill= ~Opposition) %>% 
#                                 add_axis("x", title="Method of Dismissal")  %>%
#                                 bind_shiny("pl_batDismissals")
#   
# })
# 
# ## piechart
# output$pl_batDismissalsPie <- renderRd3pie({
#   
#   dfPie <- batterData()$df %>% 
#     filter(Dismissal != "-") %>% 
#     group_by(Dismissal) %>% 
#     tally() %>% 
#     mutate(Dismissal=as.character(Dismissal))
#   
#   dfPie %>% 
#     rename(label=Dismissal,value=n) %>% 
#     rd3pie(Title="Dismissal Method",  OuterRadius=NULL, width=1,height=10)
#   
# })
# 
# 
# # table by country
# 
# output$pl_batCountry <- DT::renderDataTable({
#   if (is.null(batterData()))
#     return()
#   
#   #print("enter batcountry")
#   
#   
#   df <- batterData()$df
#   
#   ## process individual columns
#   
#   sumRuns <- df %>%
#     filter(!is.na(Runs)) %>%
#     group_by(Opposition) %>%
#     summarize(totRuns = sum(Runs), hs = max(Runs))
#   
#   
#   
#   sumOuts <- df %>%
#     filter(Dismissal != "not out" & Dismissal != "-") %>%
#     group_by(Opposition) %>%
#     summarize(totOuts = n())
#   
#   
#   c <- df %>%
#     filter(Runs >= 100) %>%
#     group_by(Opposition) %>%
#     summarize(c = n())
#   
#   f <- df %>%
#     filter(Runs >= 50 & Runs < 100) %>%
#     group_by(Opposition) %>%
#     summarize(f = n())
#   
#   
#   
#   matches <- df %>%
#     select(Opposition,Date) %>%
#     unique() %>%
#     group_by(Opposition) %>%
#     summarize(m = n())
#   
#   
#   summary <-
#     sumRuns %>%
#     inner_join(matches) %>%
#     inner_join(sumOuts) %>%
#     mutate(Av = round(totRuns / totOuts,2)) %>%
#     left_join(c) %>%
#     left_join(f)
#   
#   
#   summary[is.na(summary$c),]$c <- 0
#   summary[is.na(summary$f),]$f <- 0
#   
#   total <- summary %>%
#     summarize(
#       m = sum(m),totRuns = sum(totRuns), hs = max(hs),Av = s#printf("%3.2f", totRuns /
#                                                                      sum(totOuts)),c = sum(c),f = sum(f)
#     )
#   
#   total <- cbind(Year = "Career",total)
#   
#   
#   summary <- summary %>%
#     select(-totOuts)
#   
#   summary <- rbind(summary,total)
#   
#   summary %>%
#     select(
#       Year,Tests = m,Runs = totRuns,HS = hs,Av,C = c,F = f
#     ) %>%
#     datatable(
#       rownames = F,colnames = c('Opposition', 'Tests', 'Runs', 'HS', 'Av','100','50'),
#       options = list(
#         paging = FALSE, searching = FALSE,info = FALSE
#       )
#     )
#   
#   
#   
#   
#   
# })
# 
# output$pl_batYear <- DT::renderDataTable({
#   if (is.null(batterData()))
#     return()
#   
#   df <- batterData()$df
#   
#   
#   
#   df$Year <- as.integer(str_sub(df$Date,-4))
#   
#   
#   ## process individual columns
#   
#   sumRuns <- df %>%
#     filter(!is.na(Runs)) %>%
#     group_by(Year) %>%
#     summarize(totRuns = sum(Runs), hs = max(Runs))
#   
#   
#   
#   sumOuts <- df %>%
#     filter(Dismissal != "not out" & Dismissal != "-") %>%
#     group_by(Year) %>%
#     summarize(totOuts = n())
#   
#   
#   c <- df %>%
#     filter(Runs >= 100) %>%
#     group_by(Year) %>%
#     summarize(c = n())
#   
#   
#   f <- df %>%
#     filter(Runs >= 50 & Runs < 100) %>%
#     group_by(Year) %>%
#     summarize(f = n())
#   
#   
#   
#   
#   matches <- df %>%
#     select(Year,Date) %>%
#     unique() %>%
#     group_by(Year) %>%
#     summarize(m = n())
#   
#   
#   
#   summary <-
#     sumRuns %>%
#     inner_join(matches) %>%
#     inner_join(sumOuts) %>%
#     mutate(Av = s#printf("%3.2f", totRuns / totOuts)) %>%
#     left_join(c) %>%
#     left_join(f)
#   
#   
#   
#   
#   
#   
#   summary[is.na(summary$c),]$c <- 0
#   summary[is.na(summary$f),]$f <- 0
#   
#   total <- summary %>%
#     summarize(
#       m = sum(m),totRuns = sum(totRuns), hs = max(hs),Av = s#printf("%3.2f", totRuns /
#                                                                      sum(totOuts)),c = sum(c),f = sum(f)
#     )
#   
#   total <- cbind(Year = "Career",total)
#   
#   
#   summary <- summary %>%
#     select(-totOuts)
#   
#   summary <- rbind(summary,total)
#   
#   summary %>%
#     select(
#       Year,Tests = m,Runs = totRuns,HS = hs,Av,C = c,F = f
#     ) %>%
#     datatable(
#       rownames = F,colnames = c('Year', 'Tests', 'Runs', 'HS', 'Av','100','50'),
#       options = list(
#         searching = FALSE,info = FALSE,
#         columnDefs = list(list(
#           className = 'dt-center', targets = 0
#         )),
#         pageLength = 10,
#         lengthMenu = c(5, 10)
#       )
#     )
#   
#  
#   
# })
# 
## rawData

output$pl_bowlRaw <- DT::renderDataTable({
  if (is.null(bowlerData()))
    return()
  
  bowlerData()$df %>%
   # select(Date,Opposition,Ground,Inns,Order = Pos,Dismissal,Runs,Mins,BF,SR) %>%
    DT::datatable()
  
  
})