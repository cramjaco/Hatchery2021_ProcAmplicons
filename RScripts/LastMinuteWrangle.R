print("Running LastMinuteWrangle.R")
getwd()

source(here::here("RLibraries", "LibrarySet01.R"))

#metadata <- read_csv(here("Metadata", "Combined_Metadata.csv")) 
metadata <- read_csv(here("Metadata", "jacob_larva2021_metadata.csv"))

if(testrun){
  samples_to_run <- c("XD", "H12", "C_5P1B_0P2", "C4")

  metadata_select <- metadata %>% filter(Sample0 %in% samples_to_run)

  metadata <- metadata_select
}


# faster run so things actually work
# if(testrun){
# metadata_spl <- metadata %>%
#   group_by(run) %>%
#   filter(row_number() <= 10) %>%
#   pass()
# 
# metadata_neg <-  metadata %>% 
#   filter(Type == "NegativeDNA") %>%
#   filter(row_number() <=4)
# 
# metadata <- bind_rows(metadata_spl, metadata_neg)
# }

metadata_target <- metadata %>%
  select(Run, Dir = ReadDir, inFile = File, Sam = Sample0) %>%
  mutate(SamA = paste0(Sam, "_R", Dir)) %>%
  pass()
  

metadata_target01 <- metadata_target %>%
  group_by(Sam) %>%
  pivot_wider(names_from = Dir, values_from = c(inFile, SamA))

metadata_target02 <- metadata_target01 %>%
  select(Run, Sam, SamA_1, SamA_2)

metaFilt <- metadata %>% select(Run, ReadDir, Sample0) %>%
  mutate(filteredPath = here("Filtered", paste0(Sample0, "_R", ReadDir, ".filtered.fastq.gz"))) %>%
  #mutate(derepPath = here("Dereplicated", paste0(Sample0, ".R", ReadDir, ".dereplicated.fastq.gz"))) %>%
  pass()
