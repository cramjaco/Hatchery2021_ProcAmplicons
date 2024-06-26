# Run every step

library(here)

pt0a <- proc.time()
source(here("RScripts", "00_Rename_Inator.R"), local = TRUE)
system(here("ShellScripts", "Trim.sh")) # I don't know why this throws a warning
source(here("RScripts", "01_PlotQuality_Inator.R"), local = TRUE)
source(here("RScripts", "02_FilterTrim_Inator.R"), local = TRUE)
source(here("RScripts", "03_LearnErrors_Inator.R"), local = TRUE)
source(here("RScripts", "04_Dereplicate_Inator.R"), local = TRUE)
source(here("RScripts", "05_Dada_Inator.R"), local = TRUE)
source(here("RScripts", "06_PlotErrors_Inator.R"), local = TRUE)
source(here("RScripts", "07_Merge_Inator.R"), local = TRUE)
source(here("RScripts", "08_MakeSeqtabs_Inator.R"), local = TRUE)
source(here("RScripts", "09_Merge_Seqtabs_Inator.R"), local = TRUE)
source(here("RScripts", "10_Slay_Chimeras_Inator.R"), local = TRUE)
source(here("RScripts", "11_TaxonomicAssignment_Inator.R"), local = TRUE)
source(here("RScripts", "12_MakeUsefulTables_Inator.R"), local = TRUE)
source(here("RScripts", "13_Decontam_Inator.R"), local = TRUE)

pt1a <- proc.time()
print("Total time to process amplicons:")
print(pt1a - pt0a)