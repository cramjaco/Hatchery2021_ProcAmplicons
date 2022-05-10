source(here::here("RLibraries", "LibrarySet01.R"))

load(here("RDataFiles", "seqtab_nochim.RData"))

refdataPath <- here("Reference", "silva_nr_v132_train_set_spike.fa.gz")

print("Assigning Taxonomy")

pt0 <- proc.time()

taxa <- assignTaxonomy(seqs = seqtab_nochim, 
                       refFasta = refdataPath,
                       tryRC=T,
                       multithread = mt)

pt1 <- proc.time()

print("Taxonomic assignment time is")
print(pt1 - pt0)

save(taxa, file = here("RDataFiles", "taxa.RData"))

