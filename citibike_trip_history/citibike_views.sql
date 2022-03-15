create or replace view `cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_201806_202101`
  options(description = 'view definition tracked in github: https://github.com/bbrewington/gatech-cse6242-citibike/tree/main/citibike_trip_history')
  as

  select
    -- Date/Time, Station Info, Lat/Lon
      datetime(starttime) as started_at
    , datetime(stoptime) as ended_at
    , cast(start_station_id as string) as start_station_id
    , cast(start_station_name as string) as start_station_name
    , cast(start_station_latitude as float64) as start_lat
    , cast(start_station_longitude as float64) as start_lng
    , cast(end_station_id as string) as end_station_id
    , cast(end_station_name as string) as end_station_name
    , cast(end_station_latitude as float64) as end_lat
    , cast(end_station_longitude as float64) as end_lng

    -- Other Attributes
    , datetime_diff(datetime(stoptime), datetime(starttime), minute) as trip_duration_mins
    , cast(bikeid as int64) as bike_id
    , cast(usertype as string) as user_type -- values: Subscriber, Consumer
    , cast(birth_year as int64) as birth_year -- 4 digit year
    , cast(gender as string) as gender -- values: 0, 1, 2
  from `cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_201806_202101_raw`
;

create or replace view `cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_202102_onward`
  options(description = 'view definition tracked in github: https://github.com/bbrewington/gatech-cse6242-citibike/tree/main/citibike_trip_history')
  as

  select
    -- Date/Time, Station Info, Lat/Lon
      datetime(started_at) as started_at
    , datetime(ended_at) as ended_at
    , cast(start_station_id as string) as start_station_id
    , cast(start_station_name as string) as start_station_name
    , cast(start_lat as float64) as start_lat
    , cast(start_lng as float64) as start_lng
    , cast(end_station_id as string) as end_station_id
    , cast(end_station_name as string) as end_station_name
    , cast(end_lat as float64) as end_lat
    , cast(end_lng as float64) as end_lng

    -- Other Attributes
    , datetime_diff(datetime(ended_at), datetime(started_at), minute) as trip_duration_mins
    , cast(rideable_type as string) as rideable_type -- values: electric_bike, docked_bike, classic_bike
    , cast(member_casual as string) as member_casual -- values: member, casual
    , cast(ride_id as string) as ride_id
  from `cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_202102_onward_raw`
;

create or replace view `cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_bq_public`
  options(description = 'view definition tracked in github: https://github.com/bbrewington/gatech-cse6242-citibike/tree/main/citibike_trip_history')
  as

  select
    -- Date/Time, Station Info, Lat/Lon
      starttime as started_at
    , stoptime as ended_at
    , cast(start_station_id as string) as start_station_id
    , start_station_name
    , start_station_latitude as start_lat
    , start_station_longitude as start_lng
    , cast(end_station_id as string) as end_station_id
    , end_station_name
    , end_station_latitude as end_lat
    , end_station_longitude as end_lng

    -- Other Attributes
    , datetime_diff(stoptime, starttime, minute) as trip_duration_mins
    , bikeid as bike_id
    , usertype as user_type -- values: Subscriber, Consumer
    , birth_year as birth_year
    , gender
    -- , customer_plan -- leaving this out (all blank)
  from `bigquery-public-data.new_york_citibike.citibike_trips`
;

create or replace view `cse-6242-sp22-nyatl.CITIBIKE.citibike_trip`
  options(description = 'view definition tracked in github: https://github.com/bbrewington/gatech-cse6242-citibike/tree/main/citibike_trip_history')
  as

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
  from `cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_bq_public`

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
  from `cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_201806_202101`

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
  from `cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_202102_onward`
