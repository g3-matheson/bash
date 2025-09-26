#!/bin/bash

# check if the class name is provided for running the compiled program
if [ -z "$1" ]; then
    echo "Usage: $0 <name-of-class-that-contains-main()>"
    exit 1
fi

MAIN_CLASS=$1
SRC_DIR="./src"
OUT_DIR="./out"

echo "Compiling Java Project..."
javac -d "$OUT_DIR" $(find "$SRC_DIR" -name "*.java")

# error handling
if [ $? -ne 0 ]; then
    echo "Compilation error."
    exit 1
fi

# run program
java -cp "$OUT_DIR" "$MAIN_CLASS"

exit 0