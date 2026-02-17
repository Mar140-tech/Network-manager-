#!/bin/bash

# A simple script to analyze git staged files

# Check for necessary commands
if ! command -v git &>/dev/null; then
    echo "git command not found!"
    exit 1
fi

# Analysis function
git_staged_analysis() {
    staged_files=$(git diff --cached --name-only)
    echo "Analyzing staged files..."

    if [ -z "$staged_files" ]; then
        echo "No staged files to analyze."
        return
    fi

    for file in $staged_files; do
        echo "File: $file"
        git diff --cached $file
        echo "--------------------------"
    done
}

# Run analysis
git_staged_analysis
