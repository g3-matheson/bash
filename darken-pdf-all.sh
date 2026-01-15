#!/bin/bash
# Darken all PDFs in the current directory

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
  "$BASH_SCRIPTS/darken-pdf.sh" "$pdf" "$output"
done

echo "Done!"
