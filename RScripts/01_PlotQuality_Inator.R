print("Running PlotQuality.R")
getwd()
# source(here::here("RLibraries", "LibrarySet01.R"))
# 
# metadata <- read_csv(here("Metadata", "jacob_larva2021_metadata.csv"))
source(here::here("RScripts", "LastMinuteWrangle.R"))

metadata_target_qp <- metadata %>% 
  select(Run, Dir = ReadDir, SamA= Sample0)

do_quality_profile <- function(Run, Dir, SamA){
  loc_qual_plot <- plotQualityProfile(here("Trimmed",
                                           #paste0("Run", Run), # Only one run
                                           paste0(SamA, "_R", Dir, "_trim.fastq.gz")))
  output_file <- here("QualityPlots",
                      case_when(Dir == 1 ~ "Forward",
                                Dir == 2 ~ "Reverse"
                      ),
                      paste0("Run", Run),
                      paste0(SamA, ".qp.png")
  )
  ggsave(output_file)
}

#do_quality_profile(1, 1, metadata$file[1], metadata$SamA[1])

pwalk(metadata_target_qp, do_quality_profile)
                   