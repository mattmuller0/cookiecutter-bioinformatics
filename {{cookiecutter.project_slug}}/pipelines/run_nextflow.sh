#!/bin/bash
#SBATCH --job-name=pad-nextflow
#SBATCH --output=logs/%x_%j.out
#SBATCH --partition=cpu_short
#SBATCH --account=bergerlab
#SBATCH --time=5-00:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=2

# PAD Phenotyping Pipeline - Nextflow Submission Script
# This script submits the Nextflow controller job to SLURM

set -euo pipefail

# Load required modules
module load java/17.0.2

# Project directory
PROJECT_DIR="/gpfs/data/bergerlab/mm12865/projects/pad-phenotyping"
cd ${PROJECT_DIR}

# Create logs directory if it doesn't exist
mkdir -p logs

# Print job information
echo "=================================================="
echo "PAD Phenotyping Pipeline - Nextflow"
echo "Started: $(date)"
echo "Job ID: ${SLURM_JOB_ID}"
echo "Node: ${SLURM_NODELIST}"
echo "=================================================="
echo

# Run Nextflow pipeline
nextflow run pipelines/main.nf \
    -c config/nextflow.config \
    -resume

# Print completion
echo
echo "=================================================="
echo "Pipeline completed: $(date)"
echo "=================================================="
