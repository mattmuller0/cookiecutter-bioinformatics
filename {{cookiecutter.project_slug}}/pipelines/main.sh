#!/bin/bash
#SBATCH --job-name={{cookiecutter.project_slug}}
#SBATCH -p cpu_medium
#SBATCH --mem=64GB
#SBATCH --cpus-per-task=4
#SBATCH --time=0-12:00:00
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user={{cookiecutter.email}}

# ==============================================================================
# Bioinformatics Pipeline: {{cookiecutter.project_slug}}
# Description: Main pipeline script for running analysis on SLURM HPC
# ==============================================================================

set -euo pipefail  # Exit on error, undefined vars, and pipe failures
trap 'echo "Error on line $LINENO. Exit code: $?" >&2' ERR

# ==============================================================================
# CONFIGURATION
# ==============================================================================
# Modify these paths according to your HPC environment
CONDA_PATH="${CONDA_PATH:-/gpfs/data/ruggleslab/mm12865/mm12865_miniconda/etc/profile.d/conda.sh}"
DEFAULT_CONDA_ENV="${DEFAULT_CONDA_ENV:-base}"
PROJECT_DIR="${SLURM_SUBMIT_DIR:-$(pwd)}"
SRC_DIR="${PROJECT_DIR}/src"
CURRENT_CONDA_ENV=""

# ==============================================================================
# MODULES
# ==============================================================================
module purge
module load slurm
module load git/2.17.0
module load cmake/3.23.1
module load jdk/21.0.1

# Source conda (disable -u temporarily as conda scripts have unbound variables)
set +u
if [[ -f "$CONDA_PATH" ]]; then
    source "$CONDA_PATH"
else
    echo "ERROR: Conda not found at $CONDA_PATH"
    exit 1
fi
set -u

# ==============================================================================
# JOB INFORMATION
# ==============================================================================
echo "=========================================================================="
echo "Job Information"
echo "=========================================================================="
echo "Job ID:          ${SLURM_JOB_ID:-N/A}"
echo "Job Name:        ${SLURM_JOB_NAME:-N/A}"
echo "Node List:       ${SLURM_JOB_NODELIST:-N/A}"
echo "CPUs per Task:   ${SLURM_CPUS_PER_TASK:-N/A}"
echo "Memory:          ${SLURM_MEM_PER_NODE:-N/A}"
echo "Working Dir:     ${PROJECT_DIR}"
echo "Start Time:      $(date)"
echo "=========================================================================="

# ==============================================================================
# HELPER FUNCTIONS
# ==============================================================================

# Function to activate a conda environment (only if different from current)
activate_env() {
    local env_name="$1"
    
    if [[ "$CURRENT_CONDA_ENV" != "$env_name" ]]; then
        echo "Activating conda environment: ${env_name}"
        set +u  # Conda activation scripts have unbound variables
        conda activate "${env_name}"
        set -u
        CURRENT_CONDA_ENV="$env_name"
    fi
}


# Function to run a script with automatic language detection
# Usage: run_script <conda_env> <script_path>
# Examples:
#   run_script "r" "src/data_cleaning.R"
#   run_script "python3" "src/preprocess.py"
#   run_script "base" "src/pipeline.sh"
run_script() {
    local conda_env="$1"
    local script_path="$2"
    local full_path
    
    # Handle relative vs absolute paths
    if [[ "$script_path" = /* ]]; then
        full_path="$script_path"
    else
        full_path="${PROJECT_DIR}/${script_path}"
    fi
    
    local script_name
    script_name=$(basename "$script_path")
    local extension="${script_name##*.}"
    
    echo ""
    echo "=========================================================================="
    echo "Running: ${script_path}"
    echo "Environment: ${conda_env}"
    echo "Time: $(date)"
    echo "=========================================================================="
    
    # Check if script exists
    if [[ ! -f "$full_path" ]]; then
        echo "WARNING: Script not found: ${full_path}. Skipping..."
        return 0
    fi
    
    # Activate the appropriate conda environment
    activate_env "$conda_env"
    
    # Run the script based on file extension
    case "$extension" in
        R|r)
            if ! command -v Rscript &> /dev/null; then
                echo "ERROR: Rscript not found in conda environment '${conda_env}'"
                return 1
            fi
            Rscript --vanilla -e "source('${full_path}')"
            ;;
        py)
            if ! command -v python &> /dev/null; then
                echo "ERROR: Python not found in conda environment '${conda_env}'"
                return 1
            fi
            python "${full_path}"
            ;;
        sh|bash)
            bash "${full_path}"
            ;;
        *)
            echo "WARNING: Unknown file extension '${extension}'. Attempting to execute directly..."
            if [[ -x "$full_path" ]]; then
                "${full_path}"
            else
                echo "ERROR: Script is not executable and has unknown extension"
                return 1
            fi
            ;;
    esac
    
    echo "Completed: ${script_path} at $(date)"
}

# ==============================================================================
# ANALYSIS PIPELINE
# ==============================================================================
# Define the scripts to run in order
# Format: run_script <conda_env> <script_path>
# Supported extensions: .R, .py, .sh, .bash
# 
# Examples:
#   run_script "r" "src/data_cleaning.R"
#   run_script "python3" "src/preprocess.py"
#   run_script "base" "src/run_pipeline.sh"
# ==============================================================================

run_script "r" "src/data_cleaning.R"
run_script "r" "src/differential_expression.R"
run_script "r" "src/clustering.R"
run_script "r" "src/signature.R"
run_script "r" "src/figures.R"

# ==============================================================================
# JOB COMPLETION
# ==============================================================================
echo ""
echo "=========================================================================="
echo "Pipeline Complete!"
echo "End Time: $(date)"
echo "=========================================================================="

# end of script