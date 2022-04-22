select
    w.Date
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
from {{ source('weather', 'weather_data') }} as w