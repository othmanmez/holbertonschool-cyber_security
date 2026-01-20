#!/bin/bash

# Check argument
if [ $# -ne 1 ]; then
    exit 1
fi

# Remove {xor} prefix
encoded="${1#\{xor\}}"

# Base64 decode
decoded=$(echo "$encoded" | base64 -d 2>/dev/null)

# XOR decode with key 0x5A
result=""
for (( i=0; i<${#decoded}; i++ )); do
    char=$(printf '%d' "'${decoded:$i:1}")
    result+=$(printf "\\$(printf '%03o' $((char ^ 0x5A)))")
done

# Output result
echo "$result"

