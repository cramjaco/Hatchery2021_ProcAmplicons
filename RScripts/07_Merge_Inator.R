source(here::here("RScripts", "LastMinuteWrangle.R"))
source(here::here("RLibraries", "MetaCrashLibrary.R"))

load((here("RDataFiles", "dadaDf.RData")))

dadaDf2 <- dadaDf %>% select(run, ReadDir, derep, dadaOut) %>%
  mutate(ReadDir = paste0("R",ReadDir)) %>%
  pivot_wider(names_from = ReadDir, values_from = c(derep, dadaOut))

# including 16 and 18s sequences
mergedDf <- dadaDf2 %>% mutate(mer = pmap(., function(run, derep_R1, derep_R2, dadaOut_R1, dadaOut_R2) {
  merge_16s18s(dadaOut_R1, derep_R1, dadaOut_R2, derep_R2)
}))

# At some point I need to do the other kind of merge where I combine the runs

save(mergedDf, file = here("RDataFiles", "mergedDf.RData"))

## A few checks

mergedDf
