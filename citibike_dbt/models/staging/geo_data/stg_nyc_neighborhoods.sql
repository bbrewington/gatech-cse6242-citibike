select
  ST_GEOGFROMTEXT(the_geom) as neighborhood_boundary,
  BoroName,
  NTA2020,
  NTAName,
  NTAType
from {{ source('geo_data', 'nyc_neighborhoods_raw_2020') }}
