with nyc_nbr_source as (
  SELECT
    neighborhood_boundary,
    BoroName,
    NTA2020,
    NTAName,
    NTAType
  FROM {{ ref('stg_nyc_neighborhoods') }}
),

nyc_nbr_renamed as (
  select
    NTAName as neighborhood,
    BoroName as boro,
    neighborhood_boundary
  from nyc_nbr_source
),

stations as (
  select
    station_name,
    station_geopoint,
    st_y(station_geopoint) as station_lat,
    st_x(station_geopoint) as station_lng
  from {{ ref('stg_citibike_trip__stations') }}
),

zips as (
  select
    zipcode,
    zip_boundary
  from {{ ref('stg_zip') }}
)

select
  nyc_nbr_renamed.neighborhood,
  nyc_nbr_renamed.boro,
  zips.zipcode,
  stations.station_name,
  stations.station_lat as latitude,
  stations.station_lng as longitude
from stations
cross join nyc_nbr_renamed
cross join zips
where st_contains(nyc_nbr_renamed.neighborhood_boundary, stations.station_geopoint)
and st_contains(zips.zip_boundary, stations.station_geopoint)
