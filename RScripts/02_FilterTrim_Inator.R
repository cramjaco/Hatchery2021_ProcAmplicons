print("Running 02_FilterTrim_Inator.R")
getwd()
source(here::here("RScripts", "LastMinuteWrangle.R"))

#metadata <- read_csv(here("Metadata", "jacob_larva2021_metadata.csv"))


forward_reads <- here("Rawish",
                      #paste0("Run", metadata_target01$Run),
                      metadata_target01$inFile_1)
reverse_reads <- here("Rawish",
                      #paste0("Run", metadata_target01$Run),
                      metadata_target01$inFile_2)

filtered_forward_reads <- here("Filtered", paste0(metadata_target01$SamA_1, ".filtered.fastq.gz"))
filtered_reverse_reads <- here("Filtered", paste0(metadata_target01$SamA_2, ".filtered.fastq.gz"))

filtered_out <- filterAndTrim(forward_reads, filtered_forward_reads,
                              reverse_reads, filtered_reverse_reads, maxEE=c(1,2),
                              rm.phix=TRUE, minLen=175, truncLen=c(270,200))

filtered_out

save(filtered_out, file = here("RDataFiles", "filtered_out.RData"))
