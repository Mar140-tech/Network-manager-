#!/bin/bash
# A script to organize git commits by date

# Fetch all commits
commits=$(git log --pretty=format:"%ad %h %s" --date=short)

# Organize commits by date
organized_commits=$(echo "${commits}" | sort -u)

# Print organized commits
echo "Organized Commits:" 
echo "${organized_commits}"