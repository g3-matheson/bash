#!/bin/bash

# check if the class name is provided for running the compiled program
if [ -z "$1" ]; then
    echo "Usage: $0 <code to run in main>"
    exit 1
fi

FILE_PATH="$HOME/java-tests/Test.java"

# remove old file if exists
[ -f "$FILE_PATH" ] && rm "$FILE_PATH"

# write the java source file
cat > "$FILE_PATH" <<EOF
public class Test {
    public static void main(String[] args) {
        $@
    }
}
EOF

# compile and run
javac "$FILE_PATH" && java "$FILE_PATH"