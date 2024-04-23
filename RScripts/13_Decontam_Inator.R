source(here::here("RScripts", "LastMinuteWrangle.R"))

load(here("RDataFiles", "tables_but_as_datafiles.RData"))

metadata$Type %>% unique()

## Identify the negatives
negatives <- metadata %>% 
  #filter(Type == "NegativeDNA") %>%
  filter(str_detect(Type, "^Negative")) %>%
  pull(Sample0) %>% unique() %>%
  identity()

colnames(asv_tab)

vector_for_decontam <- colnames(asv_tab) %in% negatives


## Run Decontam
contam_df <- isContaminant(t(asv_tab), neg = vector_for_decontam)


## Identifying contaminants
table(contam_df$contaminant)

contam_asvs <- row.names(contam_df[contam_df$contaminant == TRUE, ])


contam_tax <- asv_tax %>% as.data.frame() %>%
  rownames_to_column("ASV") %>% 
  filter(ASV %in% contam_asvs)

# don't throw out oysters and spikes, even if they did show up in the negatives
contam_tax_curated <- contam_tax %>% 
  filter(Kingdom != "Spike" & Order != "Ostreoida")

write_csv(contam_tax_curated, here("Output", "contam_tax_curated.csv"))

contam_asvs_curated <- contam_tax_curated %>% pull(ASV)

## Per Lee, writing stuff back out

# making new fasta file
contam_indices <- which(asv_fasta %in% paste0(">", contam_asvs_curated))
dont_want <- sort(c(contam_indices, contam_indices + 1))
asv_fasta_no_contam <- asv_fasta[- dont_want]

# making new count table
asv_tab_no_contam <- asv_tab[!row.names(asv_tab) %in% contam_asvs_curated, ]

# making new taxonomy table
asv_tax_no_contam <- asv_tax[!row.names(asv_tax) %in% contam_asvs_curated, ]

## and now writing them out to files
write(asv_fasta_no_contam, here("Output","ASVs-no-contam.fa"))
write.table(asv_tab_no_contam, here("Output","ASVs_counts-no-contam.tsv"),
            sep="\t", quote=F, col.names=NA)
write.table(asv_tax_no_contam, here("Output", "ASVs_taxonomy-no-contam.tsv"),
            sep="\t", quote=F, col.names=NA)
