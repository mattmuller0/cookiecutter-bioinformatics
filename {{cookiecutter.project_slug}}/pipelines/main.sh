#!/bin/bash
#SBATCH --job-name={{cookiecutter.project_slug}}
#SBATCH -p cpu_medium
#SBATCH --mem=32GB
#SBATCH --cpus-per-task=4
#SBATCH --time=0-12:00:00
#SBATCH --output=logs/%x_%j.out

# MODULES
module purge
module load slurm
module load git/2.17.0
module load cmake/3.23.1
module load jdk/21.0.1
source /gpfs/data/ruggleslab/mm12865/mm12865_miniconda/etc/profile.d/conda.sh

echo "------------------------------------------------------------------"
echo "Current Directory: $(pwd)"
echo "Current Date: $(date)"
echo "Job ID: $SLURM_JOB_ID"
echo "Job Name: $SLURM_JOB_NAME"
echo "Job Node List: $SLURM_JOB_NODELIST"
echo "------------------------------------------------------------------"

# SCRIPTS


# end of script