create or replace table `cse-6242-sp22-nyatl.CITIBIKE.citibike_trip_cleaned`
  options(description = 'SQL code to populate this table tracked in github: https://github.com/bbrewington/gatech-cse6242-citibike/tree/main/citibike_trip_history')
as

select *
from `cse-6242-sp22-nyatl.CITIBIKE.citibike_trip`
where ifnull(start_station_name,'') <> ''
and ifnull(end_station_name,'') <> ''
and trip_duration_mins > 0
