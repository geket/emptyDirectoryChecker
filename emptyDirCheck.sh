#!/bin/bash

# Prompt the user to enter a path to scan
read -p "Enter the path to scan for empty folders: " path

# Check if the specified path exists
if [ ! -d "$path" ]; then
  echo "Error: $path does not exist."
  exit 1
fi

# Find empty directories and list them
empty_dirs=$(find "$path" -type d -empty)
echo "Empty directories found in $path:"
echo "$empty_dirs"

# Enumerate the number of files in each empty directory
for dir in $empty_dirs; do
  num_files=$(find "$dir" -maxdepth 1 -type f | wc -l)
  echo "$dir contains $num_files files."
done

# Prompt the user to confirm if they want to delete the empty directories
read -p "Do you want to delete the empty directories? (y/n) " confirm
if [ "$confirm" == "y" ]; then
  echo "Deleting empty directories..."
  find "$path" -type d -empty -delete
  echo "Done."
else
  echo "Empty directories not deleted."
fi
