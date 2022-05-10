print("Slaying Chimeras")

source(here::here("RLibraries", "LibrarySet01.R"))

load(file = here("RDataFiles", "seqtab.RData"))

pt0 <- proc.time()
seqtab_nochim <- removeBimeraDenovo(seqtab, verbose = TRUE)
pt1 <- proc.time()

print("chimera check time:")
print(pt1 - pt0)


print("reads retained")
sum(seqtab_nochim)/sum(seqtab)

print("chimera checked table dimensions")
dim(seqtab_nochim)

save(seqtab_nochim, file = here("RDataFiles", "seqtab_nochim.RData"))
