#!/bin/sh

#  Script.sh
#  BlogApp
#
#  Created by Reid, Dylan D on 2024/09/17.
#  
#!/bin/bash

# Define the input and output directories
INPUT_DIR="$PROJECT_DIR/View Models"
OUTPUT_DIR="$PROJECT_DIR/BlogAppTests/Mocks"

# Generate the mocks using Cuckoo
cuckoo_generator generate --testable YourApp \
--output "${OUTPUT_DIR}/Mocks.generated.swift" \
"${INPUT_DIR}/BlogViewModel.swift" \
"${INPUT_DIR}/MainViewModel.swift"
