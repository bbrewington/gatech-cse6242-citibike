with source as (
    select
        -- Date/Time, Station Info, Lat/Lon
          datetime(started_at) as started_at
        , datetime(ended_at) as ended_at
        , cast(start_station_id as string) as start_station_id
        , cast(start_station_name as string) as start_station_name
        , cast(start_lat as float64) as start_lat
        , cast(start_lng as float64) as start_lng
        , cast(end_station_id as string) as end_station_id
        , cast(end_station_name as string) as end_station_name
        , cast(end_lat as float64) as end_lat
        , cast(end_lng as float64) as end_lng

        -- Other Attributes
        , datetime_diff(datetime(ended_at), datetime(started_at), minute) as trip_duration_mins
        , cast(rideable_type as string) as rideable_type -- values: electric_bike, docked_bike, classic_bike
        , cast(member_casual as string) as member_casual -- values: member, casual
        , cast(ride_id as string) as ride_id
    from `cse-6242-sp22-nyatl.{{target.dataset}}.citibike_trip_*`
    where _TABLE_SUFFIX >= '20210201'
)

select * from source