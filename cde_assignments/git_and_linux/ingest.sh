

#!/bin/bash

# This will be the root directory for this exercise

logfile=$(pwd)

# This variable stores the URL where the data is extracted from

CSV_URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

# This holds what the file will be saved as after downloading

CSV_FILE="annual-enterprise-survey-2023-financial-year-provisional.csv"

# The command gets the data from the URL and then save the file with the CSV_FILE value. It then saves the file in a raw folder

wget "$CSV_URL" -O "raw/$CSV_FILE"

raw_folder_check=$(ls "$logfile/raw")

sed -i '1s/Variable_code/variable_code/' "$logfile/raw/$CSV_FILE"

mkdir -p "$logfile/Transformed"

gawk 'BEGIN { FPAT = "([^,]+)|(\"[^\"]+\")" } { print $1 "," $9 "," $5 "," $6 }' "$logfile/raw/$CSV_FILE" >"$logfile/Transformed/2023_year_finance.csv"

mkdir -p "$logfile/Gold"

cp  "$logfile/Transformed/2023_year_finance.csv" "$logfile/Gold" 


raw_folder_check=$(ls "$logfile/raw")
Transformed_folder_check=$(ls "$logfile/Transformed")
Gold_folder_check=$(ls "$logfile/Gold")



echo "file in raw folder: $raw_folder_check"
echo "file in Transformed folder: $Transformed_folder_check"
echo "file in Gold folder: $Gold_folder_check"
