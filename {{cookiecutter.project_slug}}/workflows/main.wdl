version 1.0

# Workflow inputs
workflow my_workflow {
    input {
        File config_file
    }

    # Call tasks in sequence
    call step1 { input: config = config_file }
    call step2 { input: config = config_file }
    call step3 { input: config = config_file }
}

# Task definitions
task step1 {
    input {
        File config
    }

    command {
        bash ./code/step1.sh ${config}
    }

    runtime {
        conda: "main"
    }
}

task step2 {
    input {
        File config
    }

    command {
        bash ./code/step2.sh ${config}
    }

    runtime {
        conda: "main"
    }
}

task step3 {
    input {
        File config
    }

    command {
        bash ./code/step3.sh ${config}
    }

    runtime {
        conda: "main"
    }
}