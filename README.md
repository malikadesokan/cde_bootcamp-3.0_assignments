# Social Media Advertising Analytics Engineering Project

> **Project status:** Work in progress 

## Overview

This project explores how social media advertising data can be organised
and transformed to help a marketing team understand campaign performance
across **Facebook and Snapchat**.

The business problem is that marketers need a consistent way to
understand:

-   Advertising spend
-   Impressions and clicks
-   Campaign performance over time
-   Differences in performance between advertising platforms

The project uses dbt to organise data transformations and Databricks as
the data platform. The intended outcome is a reliable, reusable data
model that can support reporting and campaign analysis.

## Business Questions

The data model is intended to help answer questions such as:

1.  How much have campaigns spent over a selected period?
2.  How many impressions and clicks have campaigns generated?
3.  How do key performance metrics change over time?
4.  Which campaigns and ad groups contribute most to spend, impressions
    and clicks?
5.  How does performance differ between Facebook and Snapchat?


## Technology Stack

  Technology     Purpose
  -------------- -----------------------------------------------------------
  Databricks     Data platform and execution environment
  dbt            SQL-based transformations, model organisation and testing
  SQL            Data transformation and analysis
  Git / GitHub   Version control and project documentation


## Data Sources

The project uses supplied Facebook and Snapchat advertising datasets.
Files discussed during development include:

### Facebook datasets

-   `ads_stats.csv`
-   `new_account_de_randomized.csv`
-   `new_adgroup_de_randomized.csv`
-   `new_ads_de_randomized.csv`
-   `new_campaign_de_randomized.csv`

### Snapchat datasets

-   `snapchat_ads_ad_history_new_ad_names.csv`
-   `snapchat_ads_adgroup_history_new_ad_group_names.csv`
-   `snapchat_ads_campaign_history_new_campaign_names.csv`
-   `snapchat_ads_stats.csv`


### Grain and duplicate records

The `ads_stats` dataset can contain multiple records for the same ad.
The **date is a distinguishing attribute**, because performance
statistics can be recorded for the same ad across multiple dates.
Therefore, repeated ad identifiers should not automatically be treated
as duplicate records.


## Architecture

The project is intended to follow a layered data-modelling approach,
separating source data from cleaned and business-ready models.

``` text
Facebook and Snapchat source files
                |
                v
       Source / raw tables
                |
                v
        Staging models
   - Standardise column names
   - Cast data types
   - Apply basic cleaning
                |
                v
     Intermediate models
   - Join related entities
   - Resolve source-specific logic
   - Prepare reusable transformations
                |
                v
          Mart models
   - Campaign performance
   - Ad group performance
   - Ad performance
   - Cross-platform reporting
                |
                v
      Reporting and analysis
```

This diagram describes the intended logical flow.

## Data Modelling Approach

### Staging layer

The staging layer is intended to provide a consistent starting point for
downstream transformations. Typical responsibilities include:

-   Selecting and renaming source columns
-   Standardising data types and formats
-   Handling nulls according to defined business rules
-   Checking source-level uniqueness and data quality where appropriate


### Intermediate layer

The intermediate layer is intended to combine and prepare data from
staging models, keeping complex logic out of the final reporting models.

Possible responsibilities include:

-   Joining ads to ad groups, campaigns and account information
-   Aligning Facebook and Snapchat fields where their structures differ
-   Preparing consistent campaign and performance attributes



### Mart layer

The mart layer is intended to expose business-friendly data for
reporting and analysis.

Potential outputs include:

-   Campaign-level performance
-   Ad-group-level performance
-   Ad-level performance over time
-   Platform-level comparisons


## Metrics

The project focuses on advertising performance measures such as:

  -----------------------------------------------------------------------
  Metric                              Meaning
  ----------------------------------- -----------------------------------
  Spend                               Amount spent on advertising

  Impressions                         Number of times an advert was
                                      displayed

  Clicks                              Number of clicks recorded

  -----------------------------------------------------------------------


## Data Quality and Testing

Data quality is important because incorrect joins, duplicate grain and
inconsistent source definitions can distort performance reporting.

Potential checks include:

-   Required fields are populated
-   Data types are valid
-   Records are unique at the intended model grain
-   Relationships between campaigns, ad groups and ads are valid where
    applicable
-   Spend, impressions and clicks are checked for unexpected values
-   Model-level tests verify key assumptions


## Repository Structure

The structure below is a suggested example. Adapt it to the actual
folders and files in your repository.

``` text
dbt_project/
├── models/
│   ├── staging/
│   │   ├── facebook/
│   │   └── snapchat/
│   ├── intermediate/
│   └── marts/
│   │   ├── fact/
│   │   └── dim/
├── tests/
├── macros/
├── seeds/
├── snapshots/
├── dbt_project.yml
├── dbt_project.yml
├── packages.yml
├── profiles.yml
├── README.md
└── .gitignore
```



## Configuration

The dbt project uses a profile to connect to Databricks. Connection
details should be supplied through environment variables or a managed
secret store rather than committed to version control.

Example environment variables might include:

``` text
DATABRICKS_HOST
DATABRICKS_HTTP_PATH
DATABRICKS_TOKEN
```

For separate development and production environments, configure distinct
dbt targets and use the appropriate catalog, schema, warehouse and
credentials for each environment.

**Security:** Never commit access tokens, passwords, private keys or a
populated `.env` file. Add `.env` to `.gitignore`. Use your
organisation's approved secret-management approach for deployed
workloads.


## Running the Project

The commands below are typical dbt Core commands. Run them from the
project directory in an environment where dbt and the Databricks adapter
are installed and configured.

``` bash
# Check the connection and profile configuration
dbt debug

# Install dependencies declared in packages.yml, if applicable
dbt deps

# Check model compilation
dbt compile

# Build models and run applicable tests
dbt build
```

To select a specific configured target:

``` bash
dbt build --target dev
```

``` bash
dbt build --target prod
```

To generate static dbt documentation:

```bash
uv run dbt docs generate --static
```

Use `dev` and `prod` only if those targets exist in your `profiles.yml`.
Production builds should be run only through an approved, tested
deployment process.


## Results and Deliverables

The intended deliverable is a structured analytics data model that makes
campaign performance easier to analyse across Facebook and Snapchat.


-   Models successfully built
-   Tests executed and their outcomes
-   Screenshots of the dbt lineage graph



## Data Lineage

The dbt lineage graph illustrates how Facebook and Snapchat advertising data flows from source tables through the staging, intermediate and mart layers to support campaign performance analysis.

![dbt lineage graph showing Facebook and Snapchat data transformations](images/dbt_lineage.png)




## Challenges and Learnings

While working on this, I encountered the following challenges


-   Handling repeated ad identifiers across different reporting dates
-   Aligning fields across advertising platforms
-   Choosing the grain of fact tables
-   Preventing double-counting when joining performance data to campaign
    or ad-group dimensions
-   Separating staging, intermediate and mart transformations
-   Configuring dbt targets and Databricks schemas
-   Adding tests to protect data quality


## Future Improvements

Potential next steps, depending on the current state of the project:

-   Complete and document the cross-platform reporting models
-   Expand dbt tests and source freshness checks
-   Automate builds and tests through CI/CD
-   Add scheduled refreshes and monitoring
-   Build a marketing performance dashboard
-   Document model lineage, definitions and metric ownership
-   Explore the macros and understand how they work




