###########################################################################
#
#                            data_cleaning
#
###########################################################################
# Author: Matthew Muller
# Script Name: data_cleaning
# Output directory:
indir <- file.path("data", "raw")
outdir <- file.path("data", "processed")
dir.create(outdir, showWarnings = FALSE)

#======================== LIBRARIES ========================
library(tidyverse)
library(glue)
library(rmatt)
library(DESeq2)

#======================== CODE ========================
config <- yaml::read_yaml("config/config.yml")

# Load data
counts <- read.csv(config$raw$counts, row.names = 1)
metadata <- read.csv(config$raw$metadata)

# Mutations to metadata if needed
# metadata <- metadata %>%
#   mutate(
#     new_var = ...
# )

# Create DESeq2 object
dds <- make_dds(counts, metadata, design = ~ 1)

if (config$filtering$run_filtering) {
    # Run filtering
    dds <- rna_preprocessing(
        dds,
        min_counts = config$filtering$min_counts,
        min_samples = config$filtering$min_samples,
        percent_genes_detected = config$filtering$percent_genes_detected
    )
}

# Save filtered dds
name <- "dds"
save_se(dds, file.path(outdir, name))
saveRDS(dds, file.path(outdir, name, "dds.rds"))
message("Saved DDS object to: ", file.path(outdir, name, "dds.rds"))

#======================== END ========================
writeLines(capture.output(sessionInfo()), file.path(outdir, "session.log"))