with base as (
  select
    date,
    year,
    mo,
    da,
    stn,
    max,
    temp,
    min,
    dewp,
    cast(mxpsd as float64) as mxpsd,
    cast(wdsp as float64) as wdsp,
    stp,
    prcp
  from {{ source('weather', 'noaa_gsod_2013_onward') }}
),

cleaned as (
  select
    IFNULL(date, date(concat(year, '-', mo, '-', da))) as date
  , stn as station_id
  , if(max = 9999.9, NULL, max) as temp_max
  , if(temp = 9999.9, NULL, temp) as temp_avg
  , if(min = 9999.9, NULL, min) as temp_min
  , cast(NULL as float64) as dew_max
  , if(dewp = 9999.9, NULL, dewp) as dew_avg
  , cast(NULL as float64) as dew_min
  , cast(NULL as float64) as humidity_max
  , cast(NULL as float64) as humidity_avg
  , cast(NULL as float64) as humidity_min
  , if(mxpsd = 999.9, NULL, mxpsd) as wind_spd_max
  , if(wdsp = 999.9, NULL, wdsp) as wind_spd_avg
  , NULL as wind_spd_min
  , NULL as pressure_max
  , if(stp = 9999.9, NULL, stp) as pressure_avg
  , NULL as pressure_min
  , if(prcp = 99.99, NULL, prcp) as precipitation_total
  from base
)

select * from cleaned