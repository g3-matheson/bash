#!/bin/bash
# Usage: ./open-pdf.sh mypdf.pdf

# exit if a command fails
set -e

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <file.pdf>"
  exit 1
fi

PDF="$(realpath "$1")"
zathura "$PDF" &
disown
