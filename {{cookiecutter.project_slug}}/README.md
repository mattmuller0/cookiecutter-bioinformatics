# {{cookiecutter.project_slug}}

- {{cookiecutter.full_name}} <{{cookiecutter.email}}>

## Description

{{cookiecutter.project_short_description}}

## Methodology

Blah blah blah

## Instructions

How to run the project.

```bash
```bash
# Run the workflow
bash pipelines/main.sh
```

## Project Organization

```sh
.
├── LICENSE             <- The license for the project
├── README.md           <- The top-level README for developers using this project.
├── config              <- Configuration files (config.yaml, etc.)
│   └── config.yaml     <- Main configuration file
├── docs                <- Documentation, scientific papers, etc.
├── data
│   ├── processed       <- The final, canonical processed data
│   └── raw             <- The original, immutable data dump.
├── logs                <- Log files from pipeline runs
├── notebooks           <- Jupyter notebooks for exploratory analysis
├── pipelines           <- Workflow scripts (bash, WDL, Nextflow, etc.)
├── presentations       <- Slide decks and presentation materials
├── src                 <- Source code for use in this project
│   └── utils           <- Utility functions and helper scripts
├── writing             <- Manuscript preparation
└── output              <- Output from experiments and analyses
```

```

## Project Organization

```sh
.
├── LICENSE             <- The license for the project
├── README.md           <- The top-level README for developers using this project.
├── config              <- Configuration files, e.g., for doxygen or for your model if needed
├── docs                <- Documentation, e.g., doxygen, scientific papers, etc.
├── data
│   ├── processed       <- The final, canonical processed data
│   └── raw             <- The original, immutable data dump.
├── workflows           <- Workflow scripts, e.g., for nextflow or slurm
├── notebooks           <- Jupyter notebooks or Rmarkdown files for exploratory analysis
├── code                <- Code for use in this project.
├── writing             <- Manuscripts preparation
├── output
│   └── experiment      <- output from experiments
│   └── ...
```
