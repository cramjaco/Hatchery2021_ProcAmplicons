print("Running 04_Dereplicate_Inator.R")
source(here::here("RScripts", "LastMinuteWrangle.R"))

#derep_forward <- derepFastq(metaFilt %>% filter(ReadDir == 1) %>% pull(filteredPath))

pt0 <- proc.time()
derepDf <- metaFilt %>% select(-Sample0) %>% group_by(Run, ReadDir) %>% nest() %>%
  mutate(derep = map(data, 
                      ~derepFastq(fls = .$filteredPath)))
pt1 <- proc.time()
print(paste0("total time to learn dereplicate"))
print(pt1 - pt0)

save(derepDf, file = here("RDataFiles", "derepDf.RData"))
