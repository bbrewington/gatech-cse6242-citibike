with tripsbyday as (
  SELECT
      extract(date FROM started_at) as date
    , count(*) as num_trips_per_day
  FROM {{ ref('stg_citibike_trip_cleaned') }}
  group by 1
)
select
    t.date
  , t.num_trips_per_day
  , w.Temp_Max
  , w.Temp_Avg
  , w.Temp_Min
  , w.Dew_Max
  , w.Dew_Avg
  , w.Dew_Min
  , w.Humidity_Max
  , w.Humidity_Avg
  , w.Humidity_Min
  , w.Wind_spd_Max
  , w.Wind_spd_Avg
  , w.Wind_spd_Min
  , w.Pressure_Max
  , w.Pressure_Avg
  , w.Pressure_Min
  , w.Precipitation_Total
from tripsByDay as t
inner join {{ ref('stg_weather_data') }} as w 
  on t.date = w.date