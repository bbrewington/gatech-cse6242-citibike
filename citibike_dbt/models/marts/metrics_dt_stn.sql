select
    cast(citi.started_at as date) as cal_dt
  , citi.start_station_name as station_name
  , geo.neighborhood as station_neighborhood
  , geo.boro as station_boro
  , geo.zipcode as station_zipcode
  , geo.latitude as station_lat
  , geo.longitude as station_lon
  , w.temp_max
  , w.temp_avg
  , w.temp_min
  , w.dew_avg
  , w.wind_spd_max
  , w.wind_spd_avg
  , w.pressure_avg
  , w.precipitation_total
  , count(*) as num_trips
  , sum(if(citi.started_hour between 0 and 5, 1, 0)) as num_trips_hr_0_5
  , sum(if(citi.started_hour between 6 and 9, 1, 0)) as num_trips_hr_6_9
  , sum(if(citi.started_hour between 10 and 13, 1, 0)) as num_trips_hr_10_13
  , sum(if(citi.started_hour between 14 and 19, 1, 0)) as num_trips_hr_14_19
  , sum(if(citi.started_hour between 20 and 23, 1, 0)) as num_trips_hr_20_23
  , sum(citi.trip_duration_mins) as trip_duration_mins_total
  , avg(citi.trip_duration_mins) as trip_duration_mins_avg
from (
  select *
    , extract(hour from started_at) as started_hour
  from {{ ref('stg_citibike_trip') }}
) as citi
left join {{ ref('int_geo_data') }} as geo
  on geo.station_name = citi.start_station_name
left join {{ ref('weather_nyc_dt') }} as w
  on w.date = cast(citi.started_at as date)
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
