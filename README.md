# gatech-cse6242-citibike

### Get Bike Data
1. Run python code `create_bike_data_script.py` which creates bash script `get_bike_data.sh`
2. Run bash script in Google Cloud terminal (probably need to make this more configurable so it doesn't do every single file):
  ```
  sh get_bike_data.sh
  ```

### dbt project notes
Folder [citibike_dbt](citibike_dbt) contains a dbt project that builds a series of queries in sequence and runs tests on them.  Docs are published to github pages connected to this repo: https://bbrewington.github.io/gatech-cse6242-citibike/

### How to update dbt docs (via command line)
1. cd into `/citibike_dbt`
2. update & test dbt model, and update docs:
    ```
    dbt run
    dbt test
    dbt docs generate
    ```

    This will output file: `/citibike_dbt/target/index.html` which is intended to be viewed interactively after running `dbt docs serve`, but this doesn't work well with github pages, so we use the next step to generate a compatible static page

3. run `dbt_utility.py` (assuming you're still within `/citibike_dbt` folder)
    ```
    % python3
    >>> from dbt_utiliity import generate_static_dbt_docs
    >>> generate_static_dbt_docs()
    >>> quit()
    % cp target/index.html ../index.html
    ```
4. Once above changes merged into the `main` branch (or if not main, the branch specified in [Settings/Pages](https://github.com/bbrewington/gatech-cse6242-citibike/settings/pages)), the dbt docs page will be updated
