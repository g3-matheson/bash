#!/bin/bash
# Darken all PDFs in the current directory
# Usage: ./darken-all.sh [quality] [density]

QUALITY="$1"
DENSITY="$2"

if [ -n "$QUALITY" ] || [ -n "$DENSITY" ]; then
  echo "Processing all PDFs with quality=${QUALITY:-default}, density=${DENSITY:-default} DPI..."
else
  echo "Processing all PDFs with default settings..."
fi
echo ""

for pdf in *.pdf; do
  # Skip if no PDF files exist (*.pdf didn't expand)
  [ -e "$pdf" ] || continue

  # Skip files that already end with -dark.pdf
  if [[ "$pdf" == *-dark.pdf ]]; then
    echo "Skipping $pdf (already darkened)"
    continue
  fi

  # Generate output filename
  output="${pdf%.pdf}-dark.pdf"

  echo "Processing: $pdf -> $output"

  # Pass parameters only if they were provided
  if [ -n "$QUALITY" ] && [ -n "$DENSITY" ]; then
    "$BASH_SCRIPTS/darken-pdf-quality-adj.sh" "$pdf" "$output" "$QUALITY" "$DENSITY"
  elif [ -n "$QUALITY" ]; then
    "$BASH_SCRIPTS/darken-pdf-quality-adj.sh" "$pdf" "$output" "$QUALITY"
  else
    "$BASH_SCRIPTS/darken-pdf-quality-adj.sh" "$pdf" "$output"
  fi

  # Clean up: remove original and rename darkened version
  if [ -f "$output" ]; then
    rm "$pdf"
    mv "$output" "$pdf"
    echo "Replaced $pdf with darkened version"
    echo ""
  else
    echo "Warning: $output was not created, keeping original"
    echo ""
  fi
done

echo "Done!"
