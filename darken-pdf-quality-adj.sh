#!/bin/bash
# Usage: ./darken-pdf.sh source.pdf target.pdf [quality] [density]
# Exit immediately if a command fails
set -e

# Default values for quality and density
QUALITY="${3:-85}"
DENSITY="${4:-150}"

# Check that we got at least two arguments
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <source.pdf> <target.pdf> [quality:85] [density:150]"
  echo "  quality: 1-100 (default: 85, lower = smaller files)"
  echo "  density: DPI (default: 150, lower = smaller files)"
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

echo "Converting with quality=$QUALITY, density=$DENSITY DPI..."

# Run the ImageMagick command with compression
magick -density "$DENSITY" "$SRC" \
  -background white -alpha remove \
  -channel RGB -negate +channel \
  -compress jpeg \
  -quality "$QUALITY" \
  "$DST"

echo "Darkened PDF created at: $DST"
