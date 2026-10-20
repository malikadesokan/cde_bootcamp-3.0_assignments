#! /bin/bash

# ============================================================
# Moving JSON and CSV files to json_and_csv directory
# ============================================================

# The script moves JSON and CSV files from the current directory to a subdirectory named "json_and_csv".
# 
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
# STEP 2 - Create the json_and_csv directory
# ------------------------------------------------------------

echo "============================================================"
echo "STEP 2: Creating the json_and_csv directory"
echo "============================================================"

# mkdir -p creates the directory if it does not already exist.
#
# The -p option also prevents an error if the directory already
# exists.

mkdir -p "$logfile/json_csv"

echo "json_csv directory is ready."
echo "Location: $logfile/json_csv"
echo ""

# ------------------------------------------------------------
# STEP 3 - Move JSON and CSV files to the json_and_csv directory
# ------------------------------------------------------------

echo "============================================================"
echo "STEP 3: Moving JSON and CSV files to the json_and_csv directory"
echo "============================================================"

# The script moves the JSON and CSV files from the current working directory
# into the json_csv directory.

mv "$logfile/"*.json "$logfile/json_csv/"
mv "$logfile/"*.csv "$logfile/json_csv/"

echo "File successfully moved to json_csv."
echo "Location: $logfile/json_csv"
echo ""
