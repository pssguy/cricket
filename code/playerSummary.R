


output$playerSummary <- renderText({
  if (!is.null(playerPage()$summaryDoc)) {
    summary <-  playerPage()$summaryDoc %>%
      html_text(trim = TRUE) %>%
      str_replace("  More","")
    
  } else {
    summary <- "No summary Available" # still to be enacted
    summary
  }
  
})
