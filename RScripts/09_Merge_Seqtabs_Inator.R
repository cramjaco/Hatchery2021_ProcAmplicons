print("Merging sequence tables")

source(here::here("RLibraries", "LibrarySet01.R"))

load(file = here("RDataFiles", "seqtabDf.RData"))

seqtab <- mergeSequenceTables(tables = seqtabDf$seqtab)

rownames(seqtab) <- rownames(seqtab) %>% str_extract(".*(?=\\.R1\\.filtered\\.fastq\\.gz)")

print("combined sequence table dimensions")
dim(seqtab)

save(seqtab, file = here("RDataFiles", "seqtab.RData"))
