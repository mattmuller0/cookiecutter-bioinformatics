###########################################################################
#
#                            clustering
#
###########################################################################
# Author: Matthew Muller
# Script Name: clustering
# Output directory:
experiment <- "clustering"
outdir <- file.path("output", experiment)
dir.create(outdir, showWarnings = FALSE)

#======================== LIBRARIES ========================
library(tidyverse)
library(glue)
library(rmatt)

config <- yaml::read_yaml("config.yml")
set.seed(config$seed)

# Create output directory
cluster_dir <- file.path(experiment, "clustering")
dir.create(cluster_dir, showWarnings = FALSE, recursive = TRUE)

#======================== CODE ========================
config <- yaml::read_yaml("config.yml")
set.seed(config$seed)

# Load DDS object
dds <- readRDS(config$data_paths$dds)
norm_counts <- normalize_counts(dds, method = config$analysis$normalization)

# Perform clustering

#======================== END ========================
writeLines(capture.output(sessionInfo()), file.path(outdir, "session.log"))
save.image(file.path(outdir, "session.RData"))