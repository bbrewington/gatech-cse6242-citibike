with tripsbyday as (
  SELECT
      extract(date FROM started_at) as date
    , count(*) as num_trips_per_day
  FROM {{ ref('stg_citibike_trip_cleaned') }}
  group by 1
)

select
  t.date,
  t.num_trips_per_day,
  w.temp_max,
  w.temp_avg,
  w.temp_min,
  w.dew_avg,
  w.wind_spd_max,
  w.wind_spd_avg,
  w.pressure_avg,
  w.precipitation_total
from tripsByDay as t
inner join {{ ref('weather_nyc_dt') }} as w 
  on t.date = w.date
