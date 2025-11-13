###########################################################################
#
#                            signature
#
###########################################################################
# Author: Matthew Muller
# Script Name: signature
# Output directory:
experiment <- "signature"
outdir <- file.path("output", experiment)
dir.create(outdir, showWarnings = FALSE)

#======================== LIBRARIES ========================
library(tidyverse)
library(glue)
library(rmatt)
library(singscore)

#======================== CODE ========================
config <- yaml::read_yaml("config.yml")
set.seed(config$seed)

# Load data
dds <- readRDS(config$data_paths$dds)
metadata <- read.csv(config$data_paths$metadata)
norm_counts <- normalize_counts(dds, method = config$analysis$normalization)

# Get the DE results
condition <- config$conditions$primary[1]
deseq_res <- paste0("output/differential_analysis/", condition, "deseq_results.csv")

# Get the signature
pvalue <- config$analysis$thresholds$padj
log2fc <- config$analysis$thresholds$log2fc
signature <- getGenes(deseq_res, padj, log2fc)

message("Computing signature scores...")
counts_ranked <- rankGenes(norm_counts)
scores <- simpleScore(
  counts_ranked,
  upSet = list_of_up_genes,
  downSet = list_of_down_genes
)
write.csv(scores, file.path(outdir, "signature_scores.csv"))

#======================== END ========================
writeLines(capture.output(sessionInfo()), file.path(outdir, "session.log"))
save.image(file.path(outdir, "session.RData"))