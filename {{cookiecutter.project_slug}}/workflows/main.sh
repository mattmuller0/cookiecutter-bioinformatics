#!/bin/bash

# Define the steps to run
steps=(
    "step1.sh"
    "step2.sh"
    "step3.sh"
)

# Define the code directory
code_dir="./code"

# Run each step
for step in "${steps[@]}"; do
    script_path="${code_dir}/${step}"
    if [[ -f "$script_path" ]]; then
        echo "Running $step..."
        bash "$script_path"
        if [[ $? -ne 0 ]]; then
            echo "Error: $step failed."
            exit 1
        fi
    else
        echo "Error: $script_path not found."
        exit 1
    fi
done

echo "All steps completed successfully."