###########################################################################
#
#                            differential_expression
#
###########################################################################
# Author: Matthew Muller
# Script Name: differential_expression
# Output directory:
experiment <- "differential_expression"
outdir <- file.path("output", experiment)
dir.create(outdir, showWarnings = FALSE)

# ======================== LIBRARIES ========================
library(tidyverse)
library(glue)
library(rmatt)

# ======================== CODE ========================
config <- yaml::read_yaml("config/config.yml")
set.seed(config$seed)

# Load DDS object
dds <- readRDS(config$processed$dds)

# Get controls and conditions
conditions <- config$conditions$primary
controls <- config$controls$standard

# run the differential expression analysis
res <- deseq_analysis(
    dds = dds,
    conditions = conditions,
    controls = controls,
    outpath = outdir,
    pvalue = "padj",
    pCutoff = config$analysis$thresholds$padj,
    normalize_method = config$analysis$normalization,
)
saveRDS(res, file.path(outdir, "deseq_results.rds"))

# ======================== END ========================
writeLines(capture.output(sessionInfo()), file.path(outdir, "session.log"))
save.image(file.path(outdir, "session.RData"))
