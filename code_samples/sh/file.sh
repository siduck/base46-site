#!/bin/bash

DIRECTORY="$1"
if [[ -z "$DIRECTORY" ]]; then
  echo "Error: No directory provided."
  echo "Usage: $0 <directory>"
  exit 1
fi

if [[ ! -d "$DIRECTORY" ]]; then
  echo "Error: '$DIRECTORY' is not a valid directory."
  exit 2
fi

echo "Organizing files in '$DIRECTORY'..."

# Function to move files based on extension
organize_files() {
  local file="$1"
  local ext="${file##*.}"
  local dir="$DIRECTORY/$ext"

  # Skip hidden files
  [[ "$file" =~ ^\..* ]] && return

  # Create directory if it doesn't exist
  if [[ ! -d "$dir" ]]; then
    mkdir "$dir"
  fi

  # Move the file into its respective directory
  mv "$file" "$dir/"
  echo "Moved: $file -> $dir"
}

# Iterate through files and organize
for file in "$DIRECTORY"/*; do
  if [[ -f "$file" ]]; then
    organize_files "$file"
  fi
done

echo "File organization completed."
