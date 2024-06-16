#!/bin/bash

# Check for required arguments
if [ $# -ne 4 ]; then
  echo "Usage: $0 <search_folder> <destination_folder> <max_width> <max_height>"
  exit 1
fi

Store arguments in variables
search_folder="$1"
destination_folder="$2"
max_width="$3"
max_height="$4"

# Check if destination folder exists and create it if not
if [ ! -d "$destination_folder" ]; then
  mkdir -p "$destination_folder"
fi

# Find images recursively using 'find' with null byte delimiter
find "$search_folder" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.gif" \) -print0 | while IFS= read -r -d '' image; do

  # Get image dimensions using 'identify' from ImageMagick package
  width=$(identify -format "%w" "$image")
  height=$(identify -format "%h" "$image")

  # Check if image size is greater than specified dimensions
  if [[ $width -gt $max_width || $height -gt $max_height ]]; then
    # Copy image to destination folder
    cp "$image" "$destination_folder"
    echo "[+] > $image"
  fi
done

echo "Finished searching for large images."
