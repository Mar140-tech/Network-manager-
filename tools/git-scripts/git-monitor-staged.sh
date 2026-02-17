#!/bin/bash
# Script to monitor staged files in a Git repository

# Get the current date and time in the specified format
current_datetime=$(date -u +'%Y-%m-%d %H:%M:%S')

# Get the current user’s login
current_user=$(git config user.login)

# Display the current date and time and user login
echo "Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): $current_datetime"
echo "Current User's Login: $current_user"

# List staged files
staged_files=$(git diff --cached --name-only)

if [ -z "$staged_files" ]; then
    echo "No files are currently staged for commit."
else
    echo "Staged files:" 
    echo "$staged_files"
fi
