
# https://stackoverflow.com/questions/10966109/how-to-source-r-markdown-file-like-sourcemyfile-r
ksource <- function(x, ...) {
  library(knitr)
  source(purl(x, output = tempfile()), ...)
}

## Meging

merge_16s18s <- function(dadaF, derepF, dadaR, derepR){
  
  ## Helper functions
  
  inconcat <- function(merDf, conDf){
    merDf[!merDf$accept,] <- conDf[!merDf$accept,]
    merDf
}

getN <- function(x) sum(getUniques(x))
  
  ## Main
  
  mrg_loc <- mergePairs(dadaF, derepF, dadaR, derepR, returnRejects = TRUE)
  cat_loc <- mergePairs(dadaF, derepF, dadaR, derepR, justConcatenate = TRUE)
  
  LenMerger <- length(mrg_loc)
  merlist <- vector(mode = "list", length = LenMerger)
  
  for (iter in 1:LenMerger){
    merlist[[iter]] <- inconcat(mrg_loc[[iter]], cat_loc[[iter]])
  }
  
  names(merlist) <- names(mrg_loc)
  
  merlist
}
