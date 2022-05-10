library(dplyr)
library(here)
library(readxl)
library(readr)
library(stringr)

metadata_lexy <- read_excel(here("Metadata", "16S_library_2022.xlsx"))
metadata_davis <- read_csv(here("Metadata", "Data_For_UC_Davis_April2022.csv"))

sample_info <- tibble(File = list.files(here("Rawdata"))) %>%
  mutate(Sample0 = str_extract(File, "^.*(?=_S)")) %>%
  mutate(Sample = str_replace(Sample0, "^X", "")) %>%
  mutate(Sample = str_replace(Sample, "C_5P1B_", "CB 5.1B ")) %>%
  mutate(Sample = str_replace(Sample, "P", "\\."))


metadata0 <- left_join(sample_info, metadata_lexy, by = "Sample")

metadata1 <- metadata0 %>% filter(Group != "Lexy")

metadata2 <- metadata1 %>%
  mutate(ReadDir = str_extract(File, "(?<=R)[12]")) %>%
  mutate(Run = 1) %>%
  mutate(Type = if_else(str_detect(Sample0, "^C\\d$"), "NegativeDNA", "Sample"))

# samples_to_run <- c("XD", "H12", "C_5P1B_0P2", "C4")
# 
# metadata_select <- metadata2 %>% filter(Sample0 %in% samples_to_run)
# 
# metadata <- metadata_select

metadata <- metadata2

write_csv(metadata, here("Metadata", "jacob_larva2021_metadata.csv"))
