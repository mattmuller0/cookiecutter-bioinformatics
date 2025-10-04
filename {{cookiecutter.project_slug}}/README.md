# {{cookiecutter.project_name}}

**Author:** {{cookiecutter.full_name}} <{{cookiecutter.email}}>  
**Version:** {{cookiecutter.version}}  
**Date:** {{cookiecutter.release_date}}

## Description

{{cookiecutter.project_short_description}}

## Usage

### Running the Analysis

#### Option 1: Using Shell Scripts
```bash
# Run the main workflow
bash pipelines/main.sh
```

#### Option 2: Using Nextflow (Recommended for HPC)
```bash
# Configure nextflow.config with your cluster settings
# Then run the pipeline
nextflow run pipelines/main.nf -c config/nextflow.config
```

### Configuration

Edit `config/config.yaml` to customize:
- Input/output paths
- Analysis parameters
- Variables and covariates
- Statistical thresholds

Edit `config/nextflow.config` to customize:
- SLURM cluster settings
- Resource allocations (memory, CPUs)
- Conda environment paths

## Project Organization

```
.
├── LICENSE                <- The license for the project
├── README.md              <- The top-level README for developers using this project
├── config/                <- Configuration files
│   ├── config.yaml        <- Main configuration file for analysis parameters
│   └── nextflow.config    <- Nextflow pipeline configuration
├── data/                  <- Data directory (add to .gitignore)
│   ├── raw/               <- The original, immutable data dump
│   └── processed/         <- The final, canonical processed data
├── docs/                  <- Documentation, papers, references
├── notebooks/             <- Jupyter/R notebooks for exploratory analysis
│   └── exploration.ipynb  <- Example exploratory analysis notebook
├── pipelines/             <- Workflow scripts
│   ├── main.nf            <- Nextflow pipeline definition
│   └── main.sh            <- Shell script pipeline alternative
├── src/                   <- Source code for use in this project
├── output/                <- Generated analysis results (add to .gitignore)
│   ├── figures/           <- Generated graphics and figures
│   └── tables/            <- Generated tables and reports
├── presentations/         <- Presentations and slides
└── writing/               <- Manuscript preparation and writing
```

## Methodology

Describe your analysis methodology here:
1. Data preprocessing
2. Quality control
3. Statistical analysis
4. Visualization
5. Interpretation

## Results

Key findings and results will be documented here as the analysis progresses.

## Contributing

If collaborating with others, document contribution guidelines here.

## License

See LICENSE file for details.

## Contact

For questions or issues, contact {{cookiecutter.full_name}} at {{cookiecutter.email}}.
