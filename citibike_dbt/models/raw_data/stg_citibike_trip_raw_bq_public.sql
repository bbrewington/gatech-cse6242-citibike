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
  , if(usertype = '', NULL, usertype) as user_type -- values: Subscriber, Consumer
  , birth_year as birth_year
  , gender
  -- , customer_plan -- leaving this out (all blank)
from `bigquery-public-data.new_york_citibike.citibike_trips`
