#!/bin/bash

folders=(
    "Accommodations"
    "Administrative"
    "Advising"
    "Answers"
    "Exemplars"
    "Figures"
    "Grades"
    "Logo"
    "Notes"
    "References"
    "Roster"
    "Slides"
)

for folder in "${folders[@]}"; do
    if [ ! -d "$folder" ]; then
        mkdir "$folder"
        echo "Created folder: $folder"
    else
        echo "$folder already exists - skipping"
    fi
done

echo "Success."