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

#======================== CODE ========================
config <- yaml::read_yaml("config.yml")
set.seed(config$seed)

# Load DDS object
dds <- readRDS(config$data_paths$dds)
norm_counts <- normalize_counts(dds, method = config$analysis$normalization)

# Create output directory
cluster_dir <- file.path(dirname(config$data_paths$dds), "clustering")
dir.create(cluster_dir, showWarnings = FALSE, recursive = TRUE)

# NMF for gene modules
if ("nmf" %in% config$clustering$methods) {
  message("Running NMF clustering...")
  nmf_res <- nmf_estimator(
    norm_counts,
    ranks = config$clustering$nmf$ranks,
    nrun = config$clustering$nmf$nrun,
    method = config$clustering$nmf$method
  )
  best_rank <- nmf_res$best_rank
  nmf_model <- NMF::nmf(norm_counts, rank = best_rank, nrun = 100, seed = config$seed)

  # Visualize
  nmf_plotter(nmf_model, outpath = file.path(cluster_dir, "nmf"))
  saveRDS(nmf_model, file.path(cluster_dir, "nmf_model.rds"))
}

# K-means clustering
if ("kmeans" %in% config$clustering$methods) {
  message("Running k-means clustering...")
  kmeans_res <- kmeans_estimator(
    norm_counts,
    k_values = config$clustering$kmeans$k_values,
    nstart = config$clustering$kmeans$nstart
  )
  saveRDS(kmeans_res, file.path(cluster_dir, "kmeans_results.rds"))
}

# Hierarchical clustering
if ("hierarchical" %in% config$clustering$methods) {
  message("Running hierarchical clustering...")
  hclust_res <- hclust_estimator(
    norm_counts,
    distance = config$clustering$hclust$distance,
    linkage = config$clustering$hclust$linkage
  )
  saveRDS(hclust_res, file.path(cluster_dir, "hclust_results.rds"))
}

#======================== END ========================
writeLines(capture.output(sessionInfo()), file.path(outdir, "session.log"))
save.image(file.path(outdir, "session.RData"))
config <- yaml::read_yaml("config.yml")
set.seed(config$seed)