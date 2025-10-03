# Platelet PAD Phenotyping Analysis Pipeline

Comprehensive bioinformatics pipeline for analyzing Peripheral Arterial Disease (PAD) phenotypes using RNA-seq, proteomics, and clinical data from the PACE study.

## Overview

This pipeline combines R-based statistical analysis and Python machine learning to identify and characterize platelet-related PAD phenotypes. The analysis includes:

- RNA-seq differential expression analysis
- Unsupervised clustering and phenotype discovery
- Clinical outcome associations
- Proteomics integration
- Regulatory network analysis

## Quick Start

### Option 1: SLURM Bash Pipeline (Traditional)

```bash
# Submit the main analysis pipeline
sbatch pipelines/main.sh
```

### Option 2: Nextflow Pipeline (Recommended - Minimal Overhead)

```bash
# Submit Nextflow workflow
sbatch pipelines/submit_nextflow.sh
```

Features:
- Automatic job submission and dependency management
- Resume capability with `-resume` flag
- Minimal overhead (single controller job)
- Automatic reporting (HTML reports, timeline, trace)

See `docs/NEXTFLOW_PIPELINE.md` for detailed Nextflow documentation.

## Project Structure

```
├── code/               # Analysis scripts (01-20, numbered execution order)
├── code/                   # Analysis scripts (01-20, numbered execution order)
├── config/                 # Configuration files
│   ├── config.yml          # R analysis parameters
│   └── nextflow.config     # Nextflow configuration
├── data/                   # Input data (PACE, TIDE, etc.)
├── output/                 # Analysis results
├── pipelines/              # Workflow definitions
│   ├── main.sh             # SLURM bash pipeline
│   ├── main.nf             # Nextflow workflow
│   └── submit_nextflow.sh  # Nextflow submission script
├── docs/                   # Documentation
│   └── NEXTFLOW_PIPELINE.md # Nextflow guide
└── logs/                   # Execution logs
```

## Pipeline Steps

The analysis consists of 16 sequential steps:

1. **Data Preparation** - Load RNA-seq, metadata, and clinical outcomes
2. **Clustering Analysis** - Patient stratification (optional, computationally intensive)
3. **Overview Analysis** - QC and preliminary exploration
4. **Clustering Modules** - Gene module identification
5. **Clustering Risks** - Clinical risk factor associations
6. **Supervised Analysis** - Differential expression for specific conditions
7. **Phenotype Modeling** - Machine learning phenotype prediction (Python)
8. **Phenotype Signature Associations** - Link phenotypes to gene signatures
9. **Platelet Phenotypes** - Parallel analysis with multiple normalizations
10. **Comparing Platelet Phenotypes** - Cross-normalization validation
11. **PAD Severity** - Disease severity stratification
12. **Revascularization** - Intervention outcome analysis
13. **Regulatory Analysis** - Transcription factor and regulatory networks
14. **Cluster Additive Modeling** - Composite risk models
15. **Proteomics Analysis** - Multi-omics integration
16. **Figures** - Final publication-ready visualizations

## Configuration

### R Analysis Parameters (`config/config.yml`)

Edit to change analysis-specific settings:
- Conditions and thresholds
- Data paths
- Normalization methods
- Statistical cutoffs

### WDL Workflow Parameters (`config/parameters.json`)

Edit to change compute resources:
- Memory allocation (default: 64GB)
- CPU count (default: 16)
- Runtime limits (default: 120 hours)
- Enable/disable optional steps

## Environment Setup

### R Environment

```bash
conda activate r
```

Required R packages:
- DESeq2, edgeR
- tidyverse, ggplot2
- ComplexHeatmap
- clusterProfiler
- survival, ggsurvfit

### Python Environment

```bash
conda activate main
```

Required Python packages:
- scikit-learn
- pandas, numpy
- MattTools (custom library)

## Output

Results are organized by analysis step in `output/`:

- `output/overview_analysis/` - QC plots, PCA, clustering
- `output/clustering_modules/` - Gene modules and enrichment
- `output/supervised_analysis/` - Differential expression results
- `output/phenotype_modeling/` - ML model predictions
- `output/proteomics/` - Multi-omics integration

## Monitoring

### Bash Pipeline

```bash
# Check job status
squeue -u $USER

# View logs
tail -f logs/platelet-pad_<JOBID>.out
```

### WDL Workflow

```bash
# View Cromwell controller log
tail -f logs/cromwell_<JOBID>.out

# Check workflow metadata
ls -lh logs/cromwell/metadata_*.json

# Monitor individual tasks
ls -lh cromwell-executions/PadPhenotypingPipeline/
```

## Documentation

- **WDL Pipeline Guide**: `docs/WDL_PIPELINE.md`
- **Project Instructions**: `.github/copilot-instructions.md`
- **Configuration Guide**: `config/README.md`

## Compute Requirements

- **Memory**: 64GB (128GB for clustering analysis)
- **CPUs**: 16 cores
- **Runtime**: ~5 days for full pipeline
- **Storage**: ~50GB for outputs
- **Partition**: gpu4_long (SLURM)

## Dependencies

### Languages
- R (primary analysis)
- Python (machine learning)
- Bash (workflow orchestration)

### System Requirements
- SLURM workload manager
- Conda package manager
- Java 21+ (for Cromwell/WDL)
- Git, CMake

### HPC Environment
- Module: git/2.17.0
- Module: cmake/3.23.1
- Module: jdk/21.0.1

## Troubleshooting

**Job fails with memory errors**
- Increase memory in `config/nextflow.config` or `pipelines/main.sh` (bash)

**Tasks timing out**
- Increase runtime limit in configuration files
- Consider disabling clustering analysis (step 2)

**Missing dependencies**
- Check conda environments are activated
- Verify all R packages are installed: `Rscript -e 'installed.packages()'`

**File not found errors**
- Ensure data paths in `config/config.yml` are correct
- Check that previous pipeline steps completed successfully

## Citation

If you use this pipeline in published research, please cite:
- PACE study data source
- Relevant method papers (DESeq2, etc.)

## Authors

**Matthew Muller**  
Email: mm12865@nyu.edu  
Ruggles Lab + Berger Lab, NYU Grossman School of Medicine

## License

Internal research use only.
