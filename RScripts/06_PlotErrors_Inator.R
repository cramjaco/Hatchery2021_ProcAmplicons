load(here::here("RDataFiles", "errDf.RData"))

errDfP <- errDf %>% 
  mutate(plt = map(errMod, ~plotErrors(., nominalQ = TRUE))) %>%
  mutate(plotFile = paste0("ErrPlot.Run", Run, ".R", ReadDir, ".png"))

#errDf %>% pwalk(function(df){plotErrors(df$errMod, nominalQ = TRUE)})

walk2(.x = errDfP$plt, .y = errDfP$plotFile , ~ggsave(
  filename = here("ErrorPlots",.y),
  plot = .x)
)
