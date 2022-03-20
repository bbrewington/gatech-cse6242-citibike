# gatech-cse6242-citibike

### Get Bike Data
1. Run python code `create_bike_data_script.py` which creates bash script `get_bike_data.sh`
2. Run bash script in Google Cloud terminal (probably need to make this more configurable so it doesn't do every single file):
  ```
  sh get_bike_data.sh
  ```

### dbt project notes
Folder [citibike_dbt](citibike_dbt) contains a dbt project that builds a series of queries in sequence and runs tests on them.  Docs are published to github pages connected to this repo: https://bbrewington.github.io/gatech-cse6242-citibike/
