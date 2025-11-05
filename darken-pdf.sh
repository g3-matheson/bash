#!/bin/bash
# Usage: ./darken-pdf.sh source.pdf target.pdf

# Exit immediately if a command fails
set -e

# Check that we got two arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source.pdf> <target.pdf>"
    exit 1
fi

# Get absolute paths
SRC="$(realpath "$1")"
DST="$(realpath "$2")"

# Verify that source file exists
if [ ! -f "$SRC" ]; then
    echo "Error: source file '$SRC' not found."
    exit 1
fi

# Run the ImageMagick command
convert -density 300 "$SRC" \
    -background white -alpha remove \
    -channel RGB -negate +channel \
    -quality 100 "$DST"

echo "Darkened PDF created at: $DST"