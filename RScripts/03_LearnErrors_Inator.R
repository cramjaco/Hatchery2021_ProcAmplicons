print("Running LearnErrors.R")
source(here::here("RScripts", "LastMinuteWrangle.R"))

set.seed(33100)

nbas = 1e8

if(testrun){
nbas = 1e6 ## Low for initial test runs. Don't use in final!!!
}



## Need to learn errors for each run seperately

pt0 <- proc.time()
errDf <- metaFilt %>% select(-Sample0) %>% group_by(Run, ReadDir) %>% nest() %>%
  mutate(errMod = map(data, 
                      ~learnErrors(fls = .$filteredPath, nbases = nbas, randomize = TRUE, multithread = mt)))

pt1 <- proc.time()

print(paste0("total time to learn errors"))
print(pt1 - pt0)


save(errDf, file = here("RDataFiles", "errDf.RData"))
