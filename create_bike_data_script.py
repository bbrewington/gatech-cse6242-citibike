def fill_template(YYYYMM):
    template = f"""
curl https://s3.amazonaws.com/tripdata/{YYYYMM}-citibike-tripdata.csv.zip | gsutil cp - gs://citibike_trip_history/{YYYYMM}-citibike-tripdata.csv.zip

gsutil cat gs://citibike_trip_history/{YYYYMM}-citibike-tripdata.csv.zip | zcat | gsutil cp - gs://citibike_trip_history/{YYYYMM}-citibike-tripdata.csv

gsutil rm gs://citibike_trip_history/{YYYYMM}-citibike-tripdata.csv.zip

"""

    return template

def get_bike_data_script():
    """
    Given an f-string template with placeholders of {YYYYMMDD}
    Prints a script that can be run in Google Cloud terminal to download
    Citibike data into GCS bucket (defined in template)

    Note there are particular years & months - data before 2018 is available
    in BigQuery public data
    """
    months_2018 = ['2018' + m for m in ['07','08','09','10','11','12']]

    months_2019_2021 = []
    month_nums = ['01','02','03','04','05','06','07','08','09','10','11','12']
    for y in ['2019','2020','2021']:
        months_2019_2021.extend([y + m for m in month_nums])

    print(months_2019_2021)

    months_2022 = ['202201']

    all_yyyymm = months_2018 + months_2019_2021 + months_2022

    script_output = ''
    for yyyymm in all_yyyymm:
        script_output += fill_template(yyyymm)

    return script_output

with open('get_bike_data.sh', 'w') as f:
    f.write(get_bike_data_script())
