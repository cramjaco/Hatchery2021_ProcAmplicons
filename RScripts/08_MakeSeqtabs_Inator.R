print("Making sequence tables")

source(here::here("RLibraries", "LibrarySet01.R"))

load(file = here("RDataFiles", "mergedDf.RData"))

seqtabDf <- mergedDf %>% 
  mutate(seqtab = map(mer, makeSequenceTable))

save(seqtabDf, file = here("RDataFiles", "seqtabDf.RData"))
