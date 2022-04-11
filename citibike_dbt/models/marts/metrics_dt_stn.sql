select
    cast(citi.started_at as date) as cal_dt
  , Temp_Max
  , Temp_Avg
  , Temp_Min
  , Dew_Max
  , Dew_Avg
  , Dew_Min
  , Humidity_Max
  , Humidity_Avg
  , Humidity_Min
  , Wind_spd_Max
  , Wind_spd_Avg
  , Wind_spd_Min
  , Pressure_Max
  , Pressure_Avg
  , Pressure_Min
  , Precipitation_Total
  , citi.start_station_name as station_name
  , geo.neighborhood as station_neighborhood
  , geo.boro as station_boro
  , geo.zipcode as station_zipcode
  , geo.latitude as station_lat
  , geo.longitude as station_lon
  , count(*) as num_trips
  , sum(if(citi.started_hour between 0 and 5, 1, 0)) as num_trips_hr_0_5
  , sum(if(citi.started_hour between 6 and 9, 1, 0)) as num_trips_hr_6_9
  , sum(if(citi.started_hour between 10 and 13, 1, 0)) as num_trips_hr_10_13
  , sum(if(citi.started_hour between 14 and 19, 1, 0)) as num_trips_hr_14_19
  , sum(if(citi.started_hour between 20 and 23, 1, 0)) as num_trips_hr_20_23
  , sum(trip_duration_mins) as trip_duration_mins_total
  , avg(trip_duration_mins) as trip_duration_mins_avg
from (
  select *
    , extract(hour from started_at) as started_hour
  from {{ ref('stg_citibike_trip_cleaned') }}
) as citi
left join {{ ref('geo_data') }} as geo
  on geo.station_name = citi.start_station_name
left join {{ ref('weather_data') }} as w
  on w.Date = cast(citi.started_at as date)
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23
