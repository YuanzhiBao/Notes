#!/bin/bash
echo "input file name: $1"

f="$1"

enscript "$1" --output=- | pstopdf -o ${f%%.*}.pdf
