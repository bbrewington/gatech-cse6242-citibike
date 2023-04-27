with unioned as (
  select
    start_station_name as station_name,
    start_lat as station_lat,
    start_lng as station_lng
  from {{ ref('stg_citibike_trip') }}
  where start_station_name is not null
  and start_lat is not null
  and start_lng is not null

  union distinct

  select
    end_station_name as station_name,
    end_lat as station_lat,
    end_lng as station_lng
  from {{ ref('stg_citibike_trip') }}
  where end_station_name is not null
  and end_lat is not null
  and end_lng is not null
),

geo_agg as (
  select
    station_name,
    st_centroid_agg(
      st_geogpoint(station_lng, station_lat)
    ) as station_geopoint
  from unioned
  group by 1
)

select *
from geo_agg
