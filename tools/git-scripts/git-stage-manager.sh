#!/bin/bash

# Script to manage Git staged changes

# Function to add a file to staging
add_to_staging() {
    git add "$1"
}

# Function to display current staged changes
show_staged_changes() {
    git diff --cached --name-status
}

# Function to clear all staged changes
clear_staged_changes() {
    git reset
}

# Check command line arguments
case "$1" in
    add)
        add_to_staging "${2}"
        ;;  
    show)
        show_staged_changes
        ;;  
    clear)
        clear_staged_changes
        ;;  
    *)
        echo "Usage: $0 {add|show|clear} [file]"
        exit 1
esac
