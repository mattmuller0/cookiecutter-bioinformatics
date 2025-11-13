# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

### [Unreleased][unreleased]

#### Added
- package files
- added my file organization
- added a readme file for instructions

### 0.2.0 - 2025-11-13

#### New

- Nextflow pipeline processes for `data_cleaning`, `differential_expression`, `clustering`, `signature`, and `figures` wired to `src/*.R`.
- New R script scaffolds in `src/` and utilities in `src/utils/helpers.R`.
- Bioinformatics analysis agent guide at `.github/agents/bioinformatics.agent.md`.

#### Updates

- Updated `pipelines/main.nf` to reflect actual analysis steps and dependencies.
- Expanded `config/config.yaml` with data paths, thresholds, and clustering parameters.
- Updated `config/nextflow.config` with SLURM resources, logging, and `publishDir`.
