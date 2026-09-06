# Data Ingestion and File Management with Bash, Cron and Git

## Project Overview

This project demonstrates a simple data ingestion pipeline built using **Bash scripting, Linux, environment variables, Cron and Git**.

The main objective was to download a CSV dataset from a specified URL, perform basic data transformation, organise the data into different stages, and automate the entire process using a Cron job.

A second Bash script was also created to demonstrate the movement of CSV and JSON files between directories.

---

## Tasks Completed

### 1. Environment Variable

An environment variable was created to store the URL of the CSV dataset.

The URL is stored in a `.env` file rather than being directly hard-coded into the Bash script.

Example:

```bash
CSV_URL="https://example.com/data.csv"
```

The `.env` file was added to `.gitignore` to prevent the environment variable and its value from being committed to GitHub.

The Bash script loads the environment variable and uses it as the source URL for the data ingestion process.

---

## 2. CSV Data Ingestion Pipeline

A Bash script was created to automate the ingestion and processing of the CSV dataset.

The pipeline follows a simple **Raw → Transform → Gold** structure.

```text
CSV URL
   ↓
Download
   ↓
RAW
   ↓
Transform
   ↓
GOLD
```

### Raw Layer

The CSV file is downloaded from the URL stored in the `CSV_URL` environment variable.

The original downloaded file is stored in the **Raw** folder.

The Raw folder therefore contains the original version of the dataset before any transformation is applied.

---

### Transform Layer

The downloaded CSV file is then processed using Bash commands.

Two transformations were performed:

#### Column name change

One of the selected column names was changed as part of the transformation process.


#### Column selection

Only four required columns were selected from the original dataset.

The resulting file contains only the required fields rather than the complete original dataset.

The transformed dataset is then saved in the **Transform** folder.


```text
Raw CSV
   │
   ├── Change column name
   │
   └── Select required 4 columns
          ↓
    Transformed CSV
```

---

### Gold Layer

Once the transformation is complete, the final processed CSV file is copied into the **Gold** folder.

The Gold folder therefore contains the final dataset ready for consumption.

The overall data flow is:

```text
                 CSV URL
                    │
                    ↓
              Download CSV
                    │
                    ↓
                  RAW
                    │
                    ↓
          Change column name
                    │
                    ↓
           Select 4 columns
                    │
                    ↓
               TRANSFORM
                    │
                    ↓
             Final CSV file
                    │
                    ↓
                  GOLD
```

---

## 3. Bash Automation

A Bash script was created to perform the complete ingestion pipeline.

The script handles:

1. Loading the CSV URL from the environment variable.
2. Downloading the CSV dataset.
3. Saving the original dataset in the Raw folder.
4. Changing a column name.
5. Selecting four required columns.
6. Saving the transformed dataset in the Transform folder.
7. Moving/copying the final dataset to the Gold folder.
8. Recording the ingestion process in a logfile.
9. Recording the start & end time.
10. Recording whether the ingestion was successful or failed.

The use of Bash allowed the entire process to be automated rather than performing each step manually.

---

## 4. Cron Job Automation

After creating and testing the Bash ingestion script, a Cron job was created to automate its execution.

The Cron job is configured to run the Bash script **every day at midnight (00:00)**.

Cron schedule:

```cron
0 0 * * * bash /path/to/ingest.sh
```

The schedule can be broken down as:

```text
0    0    *    *    *
│    │    │    │    │
│    │    │    │    └── Every day of the week
│    │    │    └─────── Every month
│    │    └──────────── Every day of the month
│    └───────────────── Hour 0
└────────────────────── Minute 0
```

Therefore:

```text
0 0 * * *
```

means:

> Run the script at 12:00 AM every day.

This means the ingestion pipeline can run automatically without manual intervention.

---

# 5. JSON and CSV File Movement

A second Bash script was created to demonstrate simple file movement.

The script identifies CSV and JSON files in a source directory and moves them into a dedicated `json_csv` folder.

The process is:

```text
Source Directory
      │
      ├── CSV files
      │
      └── JSON files
             │
             ↓
        json_csv folder
```

Example Bash commands:

```bash
mv "$logfile/"*.json "$logfile/json_csv/"
mv "$logfile/"*.csv "$logfile/json_csv/"
```

This task demonstrates basic Linux file management and the use of wildcards in Bash.

---

# 6. Git Version Control

Git was used to version-control the project throughout the development process.

The project was initialised as a Git repository and changes were tracked using Git.

The workflow included:

```text
Create project
     ↓
Create Bash scripts
     ↓
Test scripts
     ↓
Track changes with Git
     ↓
Commit changes
     ↓
Push repository to GitHub
```

Git was used to maintain a history of changes and provide version control for the project.

The completed project was pushed to GitHub.

---

# Technologies and Tools Used

* **Linux / WSL** – Development environment
* **Bash** – Scripting and data processing
* **Environment Variables** – Storing configuration such as the CSV URL
* **Cron** – Scheduling automated ingestion
* **Git** – Version control
* **GitHub** – Remote repository
* **CSV** – Source and processed data format
* **JSON** – File movement exercise

---

# Project Structure

A simplified representation of the project is:

```text
git_and_linux/
│
├── .gitignore
├── .env
├── README.md
│
├── ingest.sh
├── json_csv.sh
│
├── raw/
│   └── annual-enterprise-survey-2023-financial-year-provisional.csv
│
├── transform/
│   └── 2023_year_finance.csv
│
├── gold/
│   └── 2023_year_finance.csv
│
│
└── json_csv/
    ├── events.json
    └── customers.csv
    ├── orders.json
    └── products.csv
```

> **Note:** The `.env` file is intentionally excluded from Git using `.gitignore` so that the environment variable and its value are not uploaded to GitHub.

---

# Summary

This project demonstrates the fundamental components of a simple automated data pipeline.

The main pipeline downloads data from an externally defined URL, stores the original data in a Raw layer, performs basic transformations, and produces a final dataset in the Gold layer.

The process is automated using Bash and Cron.

A separate Bash script demonstrates the movement of CSV and JSON files between directories.

Finally, Git and GitHub were used to version-control and store the project remotely.

The project provided practical experience with **Linux file management, Bash scripting, environment variables, data transformation, logging, Cron scheduling, Git and GitHub**.
