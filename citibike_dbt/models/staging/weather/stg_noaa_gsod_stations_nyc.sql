select
  station_id,
  station_name,
  station_lat,
  station_lon
from {{ ref('stg_noaa_gsod_stations') }}
where ( -- Bounding Box of NYC Area
      station_lat between 40.687570 and 40.901739
  and station_lon between -74.029212 and -73.823905
)
