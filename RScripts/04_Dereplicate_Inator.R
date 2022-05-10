source(here::here("RScripts", "LastMinuteWrangle.R"))

#derep_forward <- derepFastq(metaFilt %>% filter(ReadDir == 1) %>% pull(filteredPath))

derepDf <- metaFilt %>% select(-Sample0) %>% group_by(run, ReadDir) %>% nest() %>%
  mutate(derep = map(data, 
                      ~derepFastq(fls = .$filteredPath)))

save(derepDf, file = here("RDataFiles", "derepDf.RData"))
