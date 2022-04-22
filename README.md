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

### /src folder
* Weather Analysis Notebooks
  - [src/WeatherAnalysis_LinearRegression_R_Final.ipynb](src/WeatherAnalysis_LinearRegression_R_Final.ipynb): Analysis document walking through steps to predict weather impact on ridership via Linear Regression
  - [src/WeatherAnalysis_RandomForest_Python_Final.ipynb](src/WeatherAnalysis_RandomForest_Python_Final.ipynb): Analysis document walking through steps to predict weather impact on ridership via Random Forest

* Analysis files used in website
  - [src/visualizations/choropleth_by_year.py](src/visualizations/choropleth_by_year.py): creates map of ridership by zip by year (year drop-down selection)
  - [src/visualizations/choropleth_timeofday.py](src/visualizations/choropleth_timeofday.py): creates map of ridership by zip by time of day (time of day drop-down selection)
  - [src/visualizations/stations_and_total_rides_scatterplot.py](src/visualizations/stations_and_total_rides_scatterplot.py): creates animated scatterplot showing rides by neighborhood by year
  - [src/visualizations/weather_factors_impact.py](src/visualizations/weather_factors_impact.py): creates bar plots exploring how weather factors impact ridership (weather factor selection via drop-down)

* Other Python files
  - [src/copy_aws_to_gcs.py](src/copy_aws_to_gcs.py): This is the script that orchestrates getting the data from AWS and staging in GCS
  - [src/dbt_utility.py](src/dbt_utility.py): Python code to be run manually as described below in appendix
  - [src/gcs_to_gbq.py](src/gcs_to_gbq.py): Python code to load staged GCS data into BigQuery staging dataset (which is referenced by dbt)

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
