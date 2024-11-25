# Project Template

This repository is a Cookiecutter project template for creating new bioinformatics based projects

## Prerequisites

- Python 3.6 or higher
- [Cookiecutter](https://cookiecutter.readthedocs.io/en/latest/installation.html)

1. **Generate a new project**:
   ```sh
   cookiecutter https://github.com/mattmuller0/cookiecutter-bioinformatics
   ```

## Usage

After generating your new project, navigate to the project directory and follow the instructions in the generated `README.md` file to set up and start working on your project.

## Example

Here is an example of how to generate a new project:

```sh
cookiecutter https://github.com/mattmuller0/cookiecutter-bioinformatics
```

You will be prompted to enter various details such as the project name, author name, and other configuration options. 
Once you provide the inputs, Cookiecutter will create a new project directory with the specified name and populate it with the template files.

## Project Organization

   .
   ├── LICENSE             <- The license for the project
   ├── README.md           <- The top-level README for developers using this project.
   ├── config              <- Configuration files, e.g., for doxygen or for your model if needed
   ├── docs                <- Documentation, e.g., doxygen, scientific papers, etc.
   ├── data
   │   ├── processed       <- The final, canonical processed data
   │   └── raw             <- The original, immutable data dump.
   ├── workflows           <- Workflow scripts, e.g., for nextlfow or slurm
   ├── notebooks           <- Jupyter notebooks or Rmarkdown files for exploratory analysis
   ├── code                <- Code for use in this project.
   ├── writing             <- Manuscripts preparation
   ├── output
   │   └── experiment      <- output from experiments
   │   └── ...
