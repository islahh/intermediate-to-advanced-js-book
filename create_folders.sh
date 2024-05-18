#!/bin/bash

# Define an array of folder names
folders=(
  "1-statements-vs-expressions"
  "2-data-types-and-variables"
  "3-equality-and-type-coercion"
  "4-primitives-vs-objects"
  "5-objects"
  "6-arrays"
  "7-functions"
  "8-prototypes-and-inheritance"
  "9-loops-and-iteration"
  "10-truthy-and-falsy-values"
  "11-logical-operators"
  "12-rest-and-spread-operators"
  "13-javascript-runtime-environment"
  "14-intervals-and-timeouts"
  "15-promises-and-async-await"
  "16-http-and-fetch-api"
  "17-javascript-modules"
)

# Loop through the folder names and create directories with README.md files
for folder in "${folders[@]}"; do
  mkdir -p "$folder" # Create the directory
  touch "$folder/README.md" # Create the README.md file
done

echo "Directories and README.md files created successfully."

