select
    started_at
  , ended_at
  , start_station_id
  , start_station_name
  , start_lat
  , start_lng
  , end_station_id
  , end_station_name
  , end_lat
  , end_lng
  , trip_duration_mins
  , bike_id
  , user_type
  , birth_year
  , gender
  , cast(null as string) as rideable_type
  , cast(null as string) as member_casual
  , cast(null as string) as ride_id
  , 'bq_public' as source
from {{ ref('stg_citibike_trip_raw_bq_public') }}

union all

select
    started_at
  , ended_at
  , start_station_id
  , start_station_name
  , start_lat
  , start_lng
  , end_station_id
  , end_station_name
  , end_lat
  , end_lng
  , trip_duration_mins
  , bike_id
  , user_type
  , birth_year
  , gender
  , cast(null as string) as rideable_type
  , cast(null as string) as member_casual
  , cast(null as string) as ride_id
  , 'aws_201610_201703' as source
from {{ ref('stg_citibike_trip_raw_201610_201703') }}

union all

select
    started_at
  , ended_at
  , start_station_id
  , start_station_name
  , start_lat
  , start_lng
  , end_station_id
  , end_station_name
  , end_lat
  , end_lng
  , trip_duration_mins
  , bike_id
  , user_type
  , birth_year
  , gender
  , cast(null as string) as rideable_type
  , cast(null as string) as member_casual
  , cast(null as string) as ride_id
  , 'aws_201806_202101' as source
from {{ ref('stg_citibike_trip_raw_201806_202101') }}

union all

select
    started_at
  , ended_at
  , start_station_id
  , start_station_name
  , start_lat
  , start_lng
  , end_station_id
  , end_station_name
  , end_lat
  , end_lng
  , trip_duration_mins
  , cast(null as int64) as bike_id
  , cast(null as string) as user_type
  , cast(null as int64) as birth_year
  , cast(null as string) as gender
  , rideable_type
  , member_casual
  , ride_id
  , 'aws_202102_onward' as source
from {{ ref('stg_citibike_trip_raw_202102_onward') }}
