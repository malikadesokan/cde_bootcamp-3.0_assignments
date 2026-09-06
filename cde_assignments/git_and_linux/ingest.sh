
#!/bin/bash

# ============================================================
# Annual Enterprise Survey - Data Ingestion Pipeline
# ============================================================
#
# This script performs a simple ETL (Extract, Transform, Load)
# process:
#
# 1. Extract:
#    Download the CSV file from the URL stored in the
#    CSV_URL environment variable.
#
# 2. Transform:
#    - Change the CSV header "Variable_code" to "variable_code"
#    - Extract year, value, unit and variable_code using gawk
#
# 3. Load:
#    Copy the transformed file into the Gold folder.
#
# The URL is intentionally NOT hard-coded in this script.
# It must be supplied using the CSV_URL environment variable.
# ============================================================


# ------------------------------------------------------------
# STEP 1 - Set the root directory
# ------------------------------------------------------------

echo "============================================================"
echo "STEP 1: Setting up the root directory"
echo "============================================================"

# pwd returns the current working directory.
# This directory is used as the root directory for the exercise.

logfile=$(pwd)

echo "Root directory: $logfile"
echo ""


# ------------------------------------------------------------
# STEP 2 - Check that the CSV_URL environment variable exists
# ------------------------------------------------------------

echo "============================================================"
echo "STEP 2: Checking CSV_URL environment variable"
echo "============================================================"

# The URL is obtained from the CSV_URL environment variable.
#
# CSV_URL is not hard-coded in this script.
# It must already exist in the environment.

if [ -z "$CSV_URL" ]; then

    echo "ERROR: CSV_URL environment variable is not set."
    echo ""
    echo "Please set it before running this script."
    echo ""
    echo "Example:"
    echo 'export CSV_URL="https://example.com/data.csv"'
    echo ""

    exit 1

fi

echo "CSV_URL environment variable found."
echo "Source URL: $CSV_URL"
echo ""


# ------------------------------------------------------------
# STEP 3 - Define the CSV filename
# ------------------------------------------------------------

echo "============================================================"
echo "STEP 3: Defining the CSV filename"
echo "============================================================"

# This is the name that will be given to the downloaded file.

CSV_FILE="annual-enterprise-survey-2023-financial-year-provisional.csv"

echo "CSV filename: $CSV_FILE"
echo ""


# ------------------------------------------------------------
# STEP 4 - Create the Raw directory
# ------------------------------------------------------------

echo "============================================================"
echo "STEP 4: Creating the Raw directory"
echo "============================================================"

# mkdir -p creates the directory if it does not already exist.
#
# The -p option also prevents an error if the directory already
# exists.

mkdir -p "$logfile/raw"

echo "Raw directory is ready."
echo "Location: $logfile/raw"
echo ""


# ------------------------------------------------------------
# STEP 5 - Download the CSV file
# ------------------------------------------------------------

echo "============================================================"
echo "STEP 5: Downloading the CSV file"
echo "============================================================"

echo "Downloading data from:"
echo "$CSV_URL"
echo ""

# wget downloads the file from the URL stored in CSV_URL.
#
# -O specifies the name and location of the downloaded file.
#
# The downloaded file will be saved inside the Raw directory.

if wget "$CSV_URL" -O "$logfile/raw/$CSV_FILE"; then

    echo ""
    echo "Download completed successfully."
    echo "File saved to: $logfile/raw/$CSV_FILE"

else

    echo ""
    echo "ERROR: Failed to download the CSV file."
    exit 1

fi

echo ""


# ------------------------------------------------------------
# STEP 6 - Transform the CSV header
# ------------------------------------------------------------

echo "============================================================"
echo "STEP 6: Updating the CSV header"
echo "============================================================"

echo "Changing Variable_code to variable_code in the CSV header."

# sed modifies the first line of the CSV file.
#
# 1s means:
#   1  -> only operate on line 1
#   s  -> substitute text
#
# Therefore, only the header is changed.

sed -i '1s/Variable_code/variable_code/' "$logfile/raw/$CSV_FILE"

echo "CSV header updated successfully."
echo ""


# ------------------------------------------------------------
# STEP 7 - Create the Transformed directory
# ------------------------------------------------------------

echo "============================================================"
echo "STEP 7: Creating the Transformed directory"
echo "============================================================"

mkdir -p "$logfile/Transformed"

echo "Transformed directory is ready."
echo "Location: $logfile/Transformed"
echo ""


# ------------------------------------------------------------
# STEP 8 - Transform the CSV data using gawk
# ------------------------------------------------------------

echo "============================================================"
echo "STEP 8: Transforming the CSV data"
echo "============================================================"

echo "Extracting columns:"
echo "  Column 1 - Year"
echo "  Column 9 - Value"
echo "  Column 5 - Unit"
echo "  Column 6 - Variable Code"
echo ""

# FPAT allows gawk to recognise fields that may contain commas
# inside double quotes.
#
# The output order is:
#
# Original column 1
# Original column 9
# Original column 5
# Original column 6
#
# The transformed file is saved as:
# 2023_year_finance.csv

gawk 'BEGIN {
    FPAT = "([^,]+)|(\"[^\"]+\")"
}
{
    print $1 "," $9 "," $5 "," $6
}' "$logfile/raw/$CSV_FILE" \
   > "$logfile/Transformed/2023_year_finance.csv"

echo "Transformation completed successfully."
echo "Transformed file:"
echo "$logfile/Transformed/2023_year_finance.csv"
echo ""


# ------------------------------------------------------------
# STEP 9 - Create the Gold directory
# ------------------------------------------------------------

echo "============================================================"
echo "STEP 9: Creating the Gold directory"
echo "============================================================"

mkdir -p "$logfile/Gold"

echo "Gold directory is ready."
echo "Location: $logfile/Gold"
echo ""


# ------------------------------------------------------------
# STEP 10 - Copy the transformed file to Gold
# ------------------------------------------------------------

echo "============================================================"
echo "STEP 10: Loading data into the Gold directory"
echo "============================================================"

# The transformed CSV file is copied from the Transformed
# directory into the Gold directory.

cp "$logfile/Transformed/2023_year_finance.csv" \
   "$logfile/Gold/"

echo "File successfully copied to Gold."
echo "Location: $logfile/Gold/2023_year_finance.csv"
echo ""


# ------------------------------------------------------------
# STEP 11 - Check the contents of each directory
# ------------------------------------------------------------

echo "============================================================"
echo "STEP 11: Checking pipeline output"
echo "============================================================"

# ls is used to display the files in each directory.

raw_folder_check=$(ls "$logfile/raw")
Transformed_folder_check=$(ls "$logfile/Transformed")
Gold_folder_check=$(ls "$logfile/Gold")

echo ""
echo "Files in Raw folder:"
echo "$raw_folder_check"

echo ""
echo "Files in Transformed folder:"
echo "$Transformed_folder_check"

echo ""
echo "Files in Gold folder:"
echo "$Gold_folder_check"

echo ""


# ------------------------------------------------------------
# STEP 12 - Pipeline completed
# ------------------------------------------------------------

echo "============================================================"
echo "DATA PIPELINE COMPLETED SUCCESSFULLY"
echo "============================================================"

echo "Pipeline completed at: $(date)"
echo "Root directory: $logfile"
echo ""
