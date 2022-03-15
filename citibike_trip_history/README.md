# Citibike Trip History Data

### Citibike Trip Data: Pipeline
  1. BigQuery Public Data
    - Raw: \`bigquery-public-data.new_york_citibike.citibike_trips\` (view)
    - Transformed: \`cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_bq_public\` (view)
  1. CSV's in AWS S3 Bucket
    1. Copy files into Google Cloud Storage bucket
      - Code: [get_bike_data.sh](get_bike_data.sh)
      - Land CSV's in Bucket: gs://citibike_trip_history
    1. Ingest CSV's into BigQuery tables
      - Code: [citibike_trips_gcs_to_gbq.py](citibike_trips_gcs_to_gbq.py)
    1. Publish for data transformation (view definitions saved here: [citibike_views.sql](citibike_views.sql))
    1. June 2018 - Jan 2021
      - Raw: \`cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_201806_202101_raw\` (table)
      - Transformed: \`cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_201806_202101\` (view)
    1. Feb 2021 onward
      - Raw: \`cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_202102_onward\` (table)
      - Transformed: \`cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_202102_onward\` (view)
    1. All data combined
      - \`cse-6242-sp22-nyatl.CITIBIKE.citibike_trip\` (view)
    1. Final, filtered trip data
      - \`cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_cleaned\` (table)
      - Populated via:

### Data Dictionary for view citibike_trip
| column name | data type | description |
|---|---|---|
| started_at | datetime | when ride started |
| ended_at | datetime | when ride ended |
| start_station_id | string | station id ride started at |
| start_station_name | string | station name ride started at |
| start_lat | float | latitude ride started at |
| start_lng | float | longitude ride started at |
| end_station_id | string | station id ride ended at |
| end_station_name | string | station name ride ended at |
| end_lat | float | latitude ride ended at |
| end_lng | float | longitude ride ended at |
| trip_duration_mins | integer | minutes from started_at to ended_at |
| bike_id | integer | unique identifier of bike |
| user_type | string | one of Customer, Subscriber, or blank |
| birth_year | integer | rider's birth year (started populating Feb 1, 2021) |
| gender | string | rider's gender (started populating Feb 1, 2021) |
| rideable_type | string | thru Jan 2021: all blank.  Feb 2021 - May 2021: all docked_bike w/ tiny amt of elecric_bike.  June 2021: 35% classic_bike, 65% docked_bike.  July 2021 forward: 98.5-100% classic_bike, 0-1.5% docked_bike  |
| member_casual | string | type of rider membership.  values: member, casual (started populating Feb 1, 2021) |
| ride_id | string | unique identifier for ride (started populating Feb 1, 2021) |

### CSV Headers from June 2018 (201806) to Jan 2021 (202101):
"tripduration","starttime","stoptime","start station id","start station name","start station latitude","start station longitude","end station id","end station name","end station latitude","end station longitude","bikeid","usertype","birth year","gender"

### CSV Headers from Feb 2021 (202102) onward (at least Jan 2022: 202201)
ride_id,rideable_type,started_at,ended_at,start_station_name,start_station_id,end_station_name,end_station_id,start_lat,start_lng,end_lat,end_lng,member_casual
