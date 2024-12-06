#!/bin/bash

# directory to search for pictures
DIRECTORY=${1:-.}  # default to current directory if not specified

# output zip file name
OUTPUT_FILE=${2:-wallpapers.zip}  # default to "pictures.zip" if not specified

# file extensions to include
PICTURE_EXTENSIONS="*.jpg *.jpeg *.png *.gif *.bmp *.tiff *.webp"

# check if the directory exists
if [ ! -d "$DIRECTORY" ]; then
  echo "Error: Directory '$DIRECTORY' does not exist."
  exit 1
fi

# create the zip file with pictures
echo "Zipping pictures from '$DIRECTORY' into '$OUTPUT_FILE'..."
find "$DIRECTORY" -type f \( $(echo $PICTURE_EXTENSIONS | sed 's/ / -o -iname /g' | sed 's/^/-iname /') \) -print0 | xargs -0 zip -j "$OUTPUT_FILE"

# check if the zip command was successful
if [ $? -eq 0 ]; then
  echo "Successfully created '$OUTPUT_FILE'."
else
  echo "An error occurred while creating the zip file."
fi

