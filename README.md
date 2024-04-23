Hatchery2020_ProcAmplicons

Author: Jacob Cram
Date: 2024 April 23

This project is for processing amplicon data collected at the Horn Point
Laboratory Oyster Hatchery in the summer of 2021. 15 broods with at least
3 time-points per brood were sequenced. This only describes processing of data.
There is a seperate repository for the data analysis. Raw sequence data are
not included on the public github for reasons of space. However, the raw 
data will be available on NCBI's Sequence Read Archive.

This readme will describe key files and folders.

`ShellScripts` -- Shell scripts for processing data
  `MakeEmptyDirectories.sh` -- Data go in directories. This deletes old versions
     of the directories, and then makes those directories.
  `Trim.sh` -- Uses `cutadapt` to trim primers from the sequences. Happens after
     `00_Rename_Inator.R`. 

`RScripts/` Contains the scripts that process the data. These are
  `00_Rename_Inator.R` -- Rename the files into things that are more legable
  `01_PlotQuality_Inator.R` -- Plot quality scores
  `02_FilterTrim_Inator.R` -- Filter and trim the data with DADA2 keeping only
     reads with high enough quality scores
  Note in this case there is only one amplicon run, but sometimes, when I run
     things there are more than one run. The following code is all robust to this.
  `03_LearnErrors_Inator.R` -- Use dada2 to learn the error rates from the sequences.
  `04_Dereplicate_Inator.R` -- Dereplicate identical sequences
  `05_Dada_Inator.R `-- Use dada to denoise the sequences and call ASVs.
  `06_PlotErrors_Inator.R` -- Plot error rates from the LearnErrors process
  `07_Merge_Inator.R` -- Combine forward and reverse reads
  `08_MakeSeqtabs_Inator.R` -- Make and save outthe sequence tables. 
  `09_Merge_Seqtabs_Inator.R` -- Had more than one sequence table existed, this 
    would have merged them. In this case, it is necessary so the legacy code 
    doesn't break.
  `10_Slay_Chimeras_Inator.R` -- Remove chimeric sequences
  `11_TaxonomicAssignment_Inator.R` -- Assign taxonomy from Silva v 132
  `12_MakeUsefulTables_Inator.R` -- Produces some output data used in other analysis
     including taxonomy tables, asv count tables, and fasta file with ASVs.
  `13_Decontam_Inator.R` -- Can decontaminate the data. I didn't use the decontaminated
     data in my analysis since contamination wasn't bad here.
  `DataWranglingFirstPass.R` -- Makes a metadata table by combining a few different
     types of sample data
  `InstallRecord.R` -- Sometimes, I keep track of which packages I installed. In this
     case, it shows how I installed dada2.
  `LastMinuteWrangle.R` -- I'm not sure what this was for.
  `ProcessAmplicons.R` -- Takes the data in the RawData folder and runs the other
     scripts in this directory in order on that data.
  `test.R` -- Simple script for testing whether the cluster is working.
  
`RLibraries/` -- R files called by other scripts. Don't do anything when run
   But rather provide useful features.
  `LibrarySet01.R` -- Loads some libraries
  `UniversalParameters.R` -- Parameters that are referenced by some files. 
     Mostly handle whether we try to run things in parallel or not. Was
     useful when I was debugging problems with the high performance computing
     cluster.
     
  `MetaCrashLibrary.R` -- A few useful functions called by my scripts.
  
The following four folders hold fasta data, and are referred to along the informatic pipeline.

`Rawdata/` -- The original data files.
`Renamed/` -- Same as Rawdata but with easier to remember names
`Trimmed/` -- Cutadapt removed primers
`Filtered/` -- Dada2 discarded low quality sequences and truncated stuff.

`Reference/silva_nr_v123_tran_set_spike.fa.gz` is the silva taxonomic library to
  which I added a line so that it can recognize the spike in sequence.
  That line is
  
  >Spike;Spike01;Synthetic16s;LC140931.1;264468063
AAATTGAAGAGTTTGATCATGGCTCAGATTGAACGCTGGCGGCAGGCCTAACACATGCAAGTCGAACGGTTTGCCACAGATACGTACCGCTCATAACGCGAACCGAAGCGCAGTAGAAGTACTCCGTATCCTACCTCGGTCGTGGTTTAGGCTATCGACATCTTGCATGGGCTTCCCTAGTGAACTCTTGGGATGTATGGTACACTGGTGTAAGACATCAGACAACGAACGCTAACTATCCTGCAACACTCCGGAAGTCTACTAGTCGCCGACGCGATACGAAACTTCGGAGTGCTATTGTGCGTACCAGATCCAGTATCACTGAGACACGGTCCAGACTCCTACGGGAGGCAGCAGTGGGGAATATTGCACAATGGGCGCAAGCCTGATTACTAGCTTCGTTTCCCACCAGGATAGTTAGGAGTGCCGACCCGTTATAGAAGTGCAGTGTCCTTTCTCTGCACTCGAGTTAAGTCGACAAGTCCTCTTACGCTAGGACTCACCGGCTAACTCCGTGCCAGCAGCCGCGGTAATACGGAGGGTGCAAGCGTTAATCGGAATTACTGGGCGTAAAGCGCACGCAGGCGGTTCATCGCGAGGCTTTATACGAGGCACCAAATAAGCACCGTAATAAGTGAGTCCCGCGGGCTTATTGTGCTGCAGTATAGCTACTATAGCGTAGGGATCGATATCAGCTATACCTAGATGAGAGCCCATTTCCGCTCGATATACCTAGGGACACGTAGATGTACTATTTCGGCGACTTGGATGTGGGGAGCAAACAGGATTAGATACCCTGGTAGTCCACGCCGTAAACGATCTACCACATCAGGCACTTGGCTATGAAGACTGCGTAAGCCATTTAGAGTTCGGGCTCCTTCTAAGGCTTAGCAGGCCGCAAGGTTAAAACTCAAATGAATTGACGGGGGCCGCACAAGCGGTGGAGCATGTGGTTTAATTCGATGCAACGCGAAGAACCTTACCTGGTCTCAGTGAAAGGGATGTGCTTGATACCGTGGGTACTCTCGCGTCTGTAGAGGAGACAGGTGCTGCATGGCTGTCGTCAGCTCGTGTTGTGAAATGTTGGGTTAAGTCCCGCAACGAGCGCAACCCTTATCCTGTAACCGATTAACTTCCACATGAATAACCACGCCCGATTAAAGTGCGGCGCATTTCAGAAAGGCGACTAGATCGACGTGTTGACTTCGAGTGGCTAGCACCATTAGGGTGGAGCATCTACCCATTGCTCGATGTTAAGGGACCAAATGTCGGCCCACCGTCGTAATCCCGGAGTCAGTTCCACGTGTAGCTCAGAAACGTCTCCGTGTATAATCGTTGGTTCCGCGAGTTTGTCATTCCACGAAACACTCTGAATACGTTCCCGGGCCTTGTACACACCGCCCGTCACACGGACTACGTTCAGTACTACCGTAACTAACAGATTAGTTGGACGAGTGAAAGATCTCCGCTGATCTGTGTACTACCGGGTGAAGTCGTAACAAGGTAACCGTAGGGGAACCTGCGG

The following hold other forms of output

`Rundata/cutadapt_primer_triming_stats.txt` -- how did cutadapt do?
`RDataFiles` -- Outputs and intermediate data files, that are passed form one
   script to another. I'm not going to annotate what they are, but here are 
   their names:
    dadaDf.RData
    derepDf.RData
    errDf.RData
    filtered_out.RData
    mergedDf.RData
    seqtabDf.RData
    seqtab_nochim.RData
    seqtab.RData
    tables_but_as_datafiles.RData
    taxa.RData
    
`ErrorPlots/` -- Plots of error rates from the LearnErrors Function
`QualityPlots/` -- Plots of quality scores of forward and reverse reads.
  `Forward/Run1/` -- The forward reads
  `Reverse/Run1/` -- The reverse reads
Output/ -- Useful outputs from the analysis.
  `ASVs.fa` -- A fasta file.
  `ASV_counts.tsv` -- Read count data
  `ASVs_taxonomy.txv` -- Taxonomic assignment using silva of each asv.
  `*-nocontam.*` -- Files with no-contam in the name have been run through
  decontam. I didn't end up using these in my anlysis.
  `contam_tax_curated.csv` -- Names of putative contaminants
    

`JobFiles/` -- Interact with the high performance computing cluster (HPCC) using Slurm
  `ProcessAmplicons.job` -- Is the main file, running `RScripts/ProcessAmplicons.R`
    which does all of the work.
  `SlayChimeras.job` and `TaxonomicAssignment.job` run smaller pieces of the 
     pipeline, which was necessary because I had some trouble with these.
  `test.job` is just for testing whether the cluster is working
  
`SlurmOut/` -- Output files from HPCC job runs. 

`renv/` -- Data about packages.

`renv.lock` -- lock file for renv which manages packages.
`.gitignore` -- Files not tracked by git
.Rprofile
`Hatchery2021_ProcAmplicons.RProj` -- Project file
`README.MD` -- this document.

