version 1.0

# Workflow inputs
workflow my_workflow {
    # Call tasks in sequence
    call step1
    call step2
    call step3
}

# Task definitions
task step1 {
    command {
        bash ./code/step1.sh
    }

    runtime {
        conda: "main"
    }
}

task step2 {
    command {
        bash ./code/step2.sh
    }

    runtime {
        conda: "main"
    }
}

task step3 {
    command {
        bash ./code/step3.sh
    }

    runtime {
        conda: "main"
    }
}
