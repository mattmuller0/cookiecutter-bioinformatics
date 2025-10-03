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

// Example Process: Data Preparation
process data_preparation {
    conda "${params.conda_base}/envs/main"
    
    output:
    val true, emit: done
    
    script:
    """
    cd ${params.project_dir}
    # Add your data preparation commands here
    # Example: python src/prepare_data.py
    echo "Data preparation step"
    """
}

// Example Process: Analysis Step 1
process analysis_step_1 {
    conda "${params.conda_base}/envs/main"
    
    input:
    val ready
    
    output:
    val true, emit: done
    
    script:
    """
    cd ${params.project_dir}
    # Add your analysis commands here
    # Example: Rscript src/analysis_step_1.R
    echo "Analysis step 1"
    """
}

// Example Process: Analysis Step 2
process analysis_step_2 {
    conda "${params.conda_base}/envs/main"
    
    input:
    val ready
    
    output:
    val true, emit: done
    
    script:
    """
    cd ${params.project_dir}
    # Add your analysis commands here
    # Example: python src/analysis_step_2.py
    echo "Analysis step 2"
    """
}

// Example Process: Generate Report
process generate_report {
    conda "${params.conda_base}/envs/main"
    
    input:
    val ready
    
    output:
    val true, emit: done
    
    script:
    """
    cd ${params.project_dir}
    # Add your report generation commands here
    # Example: Rscript src/generate_report.R
    echo "Generating report"
    """
}

// Main Workflow
workflow {
    // Define your workflow steps here
    // This is a simple sequential example
    
    // Step 1: Prepare data
    data_preparation()
    
    // Step 2: Run analysis step 1
    analysis_step_1(data_preparation.out.done)
    
    // Step 3: Run analysis step 2
    analysis_step_2(analysis_step_1.out.done)
    
    // Step 4: Generate report
    generate_report(analysis_step_2.out.done)
    
    // Customize this workflow for your specific analysis pipeline
}
