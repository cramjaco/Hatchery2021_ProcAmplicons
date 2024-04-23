print("Running 00_Rename_Inator.R")
getwd()
source(here::here("RScripts", "LastMinuteWrangle.R"))

# Rename files
with(metadata, file.copy(here("Rawdata", File), here("Renamed", paste0(Sample0, "_R", ReadDir, ".fastq.gz"))))

# maybe even use cp -al but in R
# Make "sample.txt file"

write_lines(metadata_target01$Sam, file = here("Metadata", "samples.txt"))
