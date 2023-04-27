SELECT
  ZCTA5CE10 as zipcode,
  geometry as zip_boundary
FROM {{ source('geo_data', 'ny_zips_2010') }}
