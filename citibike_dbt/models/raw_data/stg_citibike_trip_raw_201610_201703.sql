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
from `cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_201610_201703_raw`
