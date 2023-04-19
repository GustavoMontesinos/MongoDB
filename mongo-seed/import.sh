#! /bin/bash

for dir in */; do
    if [ -d "$dir" ]; then
        for file in "$dir"/*.json; do
            if [ -f "$file" ]; then
                mongoimport --host mongodb --port 27017 --username=root --password=example --authenticationDatabase admin --db "$(basename "$dir")" --collection "$(basename "$file" .json)" --type json --file "$file";
            fi
        done
    fi
done