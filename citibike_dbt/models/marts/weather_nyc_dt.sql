with w as (
  select
    date,
    station_id,
    temp_max,
    temp_avg,
    temp_min,
    dew_avg,
    wind_spd_max,
    wind_spd_avg,
    pressure_avg,
    precipitation_total
  from {{ ref('stg_weather_data') }}
)

select
  w.date,
  max(w.temp_max) as temp_max,
  avg(w.temp_avg) as temp_avg,
  min(w.temp_min) as temp_min,
  avg(w.dew_avg) as dew_avg,
  max(w.wind_spd_max) as wind_spd_max,
  avg(w.wind_spd_avg) as wind_spd_avg,
  avg(w.pressure_avg) as pressure_avg,
  avg(w.precipitation_total) as precipitation_total
from w
inner join {{ ref('stg_noaa_gsod_stations_nyc') }} as s
  using(station_id)
group by 1
