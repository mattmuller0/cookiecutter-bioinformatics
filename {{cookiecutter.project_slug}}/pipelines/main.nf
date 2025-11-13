#!/usr/bin/env nextflow

/*
 * {{cookiecutter.project_name}} - Nextflow Pipeline
 * Author: {{cookiecutter.full_name}}
 * Date: {{cookiecutter.release_date}}
 */

nextflow.enable.dsl=2

// Parameters (defined in nextflow.config)
// params.project_dir
// params.conda_base

// Process 1: Data Cleaning
process data_cleaning {
    conda "${params.conda_base}/envs/r"
    
    output:
    val true, emit: done
    
    script:
    """
    cd ${params.project_dir}
    Rscript src/data_cleaning.R
    """
}

// Process 2: Differential Expression Analysis
process differential_expression {
    conda "${params.conda_base}/envs/r"
    
    input:
    val ready
    
    output:
    val true, emit: done
    
    script:
    """
    cd ${params.project_dir}
    Rscript src/differential_expression.R
    """
}

// Process 3: Clustering Analysis
process clustering {
    conda "${params.conda_base}/envs/r"
    
    input:
    val ready
    
    output:
    val true, emit: done
    
    script:
    """
    cd ${params.project_dir}
    Rscript src/clustering.R
    """
}

// Process 4: Signature Analysis
process signature {
    conda "${params.conda_base}/envs/r"
    
    input:
    val ready
    
    output:
    val true, emit: done
    
    script:
    """
    cd ${params.project_dir}
    Rscript src/signature.R
    """
}

// Process 5: Generate Figures
process figures {
    conda "${params.conda_base}/envs/r"
    
    input:
    val ready
    
    output:
    val true, emit: done
    
    script:
    """
    cd ${params.project_dir}
    Rscript src/figures.R
    """
}

// Main Workflow
workflow {
    // Step 1: Clean and prepare data (creates DDS object)
    data_cleaning()
    
    // Step 2: Run differential expression analysis
    differential_expression(data_cleaning.out.done)
    
    // Step 3: Run clustering analysis (NMF and k-means)
    clustering(data_cleaning.out.done)
    
    // Step 4: Run signature analysis
    signature(differential_expression.out.done)
    
    // Step 5: Generate figures
    figures(signature.out.done)
}
