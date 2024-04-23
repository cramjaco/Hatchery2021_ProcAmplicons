source(here::here("RScripts", "LastMinuteWrangle.R"))

# Don't `View` these. Causes rstudio to hang.

load(here("RDataFiles", "derepDf.RData"))
load(here("RDataFiles", "errDf.RData"))

deDf <- inner_join(derepDf %>% select(-data),
           errDf %>% select(-data),
           by = c("Run", "ReadDir")) %>%
  ungroup()

# test <- dada(deDf$derep[[1]], deDf$errMod[[1]])

# The map is for multiple runs, which aren't happening in the curent version,
# So it maps through just one thing
pt0 <- proc.time()
dadaDf <- deDf %>%
  mutate(dadaOut = map2(.x = derep, .y = errMod, 
                        ~dada(derep = .x, err = .y, pool = "pseudo", multithread = mt)))

pt1 <- proc.time()

print("dada2 main function run time")
print(pt1 - pt0)

save(dadaDf, file = here("RDataFiles", "dadaDf.RData"))
