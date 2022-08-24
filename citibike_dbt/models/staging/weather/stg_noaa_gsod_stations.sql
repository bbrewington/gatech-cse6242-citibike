with base as (
  select
    usaf,
    wban,
    name,
    lat,
    lon
  from {{ source('bigquery_public_data__noa_gsod', 'stations') }}
),

cleaned as (
  SELECT 
    coalesce(
      if(regexp_contains(usaf, '^9+$'), NULL, usaf),
      if(regexp_contains(wban, '^9+$'), NULL, wban)
    ) as station_id,
    name as station_name,
    lat as station_lat,
    lon as station_lon
  FROM base
)

select * from cleaned

