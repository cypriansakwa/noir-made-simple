#!/bin/bash

# Step 1: Prompt for user input
read -p "Enter key to query (max 8 characters): " raw_key

# Step 2: Pad the key to exactly 8 characters (right padded with spaces)
padded_key=$(printf "%-8s" "$raw_key")

# Step 3: Write to Prover.toml
cat <<EOF > Prover.toml
key = "$padded_key"
EOF

# Step 4: Run the circuit
echo "Running nargo execute with key: '$padded_key'"
nargo execute
