print("Merging sequence tables")

source(here::here("RLibraries", "LibrarySet01.R"))

load(file = here("RDataFiles", "seqtabDf.RData"))

# If there are multiple seqeunce tables, merge them.
# Otherwise, just return the sequence table in the appropriate format
if(length(seqtabDf$seqtab) > 1){
seqtab <- mergeSequenceTables(tables = seqtabDf$seqtab)
} else{
  seqtab <- seqtabDf$seqtab[[1]]
}

rownames(seqtab) <- rownames(seqtab) %>% str_extract(".*(?=_R1\\.filtered\\.fastq\\.gz)")

print("combined sequence table dimensions")
print(dim(seqtab))

save(seqtab, file = here("RDataFiles", "seqtab.RData"))
