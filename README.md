# gatech-cse6242-citibike

### What it is
Team project for Georgia Tech Masters in Analytics, Spring 2022 - CSE 6242: Data & Visual Analytics

Citi Bike is a bike sharing service in New York City with over 24,500 bikes and 1,500 bike stations.  Project goal is to provide holistic insights and visualizations for Citi Bike trends and factors impacting ridership behavior to empower city and transit planning

This github repository contains the code for data pipeline, visualization, and website generation

Team Members:
* Kevin Schneider
* Roshni Mahtani
* Stephanie Chueh
* Brent Brewington

### How it works
Data is ingested into BigQuery via automation within GitHub Actions connected to this repo.  Details in file: [citibike_trip_history.yml](.github/workflows/citibike_trip_history.yml), and Actions executions can be viewed in ["Actions" tab in this repo](https://github.com/bbrewington/gatech-cse6242-citibike/actions)

The approach with BigQuery data in this project is "ELT", or "Extract, Load, Transform":

1. **Extract & Load**
  - Weather Data: manually sourced from Weather Underground; loaded into BigQuery
  - Neighborhood Attributes (a.k.a. "GEO"): manually sourced from raw Citibike Trip Data, cleaned, and aggregated to neighborhood; loaded into BigQuery
  - Citibike Trip Data: raw data extracted from [AWS bucket tripdata](https://s3.amazonaws.com/tripdata/index.html) via [/src/copy_aws_to_gcs.py](/src/copy_aws_to_gcs.py) (executed in github action with command line arguments: [citibike_trip_history.yml](.github/workflows/citibike_trip_history.yml)) - lands in staging dataset in BigQuery
2. **Transform**
  - Once raw data staged in BigQuery, the tool "dbt" in folder [/citibike_dbt](/citibike_dbt) orchestrates a sequence of queries going from raw data to intermediate tables, and outputting final clean tables at defined granularities.  There are also some data cleaning rules and assumptions built in via tests in this step.
  - dbt project documentation is published here: https://bbrewington.github.io/gatech-cse6242-citibike/dbt_docs.html

### Appendix: How to update dbt docs (via command line)
1. cd into `/citibike_dbt`
2. update & test dbt model, and update docs:
    ```
    dbt run
    dbt test
    dbt docs generate
    ```

    This will output file: `/citibike_dbt/target/index.html` which is intended to be viewed interactively after running `dbt docs serve`, but this doesn't work well with github pages, so we use the next step to generate a compatible static page
3. cd into root dir; run `python3 src/dbt_utility.py`
