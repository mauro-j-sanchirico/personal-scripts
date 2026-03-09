#!/bin/bash

folders=(
    "archives"
    "assignments"
    "classes"
    "exams"
    "quizzes"
    "resources"
    "solutions"
    "student"
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