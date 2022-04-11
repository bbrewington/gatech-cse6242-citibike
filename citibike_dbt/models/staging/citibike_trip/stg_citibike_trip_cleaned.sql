select *
from {{ ref('stg_citibike_trip') }}
where ifnull(start_station_name,'') <> ''
and ifnull(end_station_name,'') <> ''
and trip_duration_mins > 0
