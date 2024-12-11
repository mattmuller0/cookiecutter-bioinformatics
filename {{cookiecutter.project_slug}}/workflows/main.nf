#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Get config file path from parameters
params.config = 'config.yaml'

process step1 {
    conda 'main'

    input:
    path config

    script:
    """
    bash ./code/step1.sh ${config}
    """
}

process step2 {
    conda 'main'

    input:
    path config

    script:
    """
    bash ./code/step2.sh ${config}
    """
}

process step3 {
    conda 'main'

    input:
    path config
    
    script:
    """
    bash ./code/step3.sh ${config}
    """
}

// Define the main workflow
workflow {
    // Create channel from config file
    config_ch = Channel.fromPath(params.config)

    // Execute processes in sequence
    step1(config_ch)
    step2(config_ch)
    step3(config_ch)
}