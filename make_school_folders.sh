#!/bin/bash

folders=(
    "accommodations"
    "administrative"
    "advising"
    "answers"
    "archives"
    "assignments"
    "classes"
    "exams"
    "figures"
    "grades"
    "logo"
    "notes"
    "quizzes"
    "references"
    "resources"
    "roster"
    "slides"
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