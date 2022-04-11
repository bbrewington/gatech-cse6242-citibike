with source as (
    select
        -- Date/Time, Station Info, Lat/Lon
          datetime(starttime) as started_at
        , datetime(stoptime) as ended_at
        , cast(start_station_id as string) as start_station_id
        , cast(start_station_name as string) as start_station_name
        , cast(start_station_latitude as float64) as start_lat
        , cast(start_station_longitude as float64) as start_lng
        , cast(end_station_id as string) as end_station_id
        , cast(end_station_name as string) as end_station_name
        , cast(end_station_latitude as float64) as end_lat
        , cast(end_station_longitude as float64) as end_lng

        -- Other Attributes
        , datetime_diff(datetime(stoptime), datetime(starttime), minute) as trip_duration_mins
        , cast(bikeid as int64) as bike_id
        , cast(usertype as string) as user_type -- values: Subscriber, Consumer
        , cast(birth_year as int64) as birth_year -- 4 digit year
        , cast(gender as string) as gender -- values: 0, 1, 2
    from (
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20161001` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20161101` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20161201` union all

        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20170101` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20170201` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20170301` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20170401` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20170501` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20170601` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20170701` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20170801` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20170901` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20171001` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20171101` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20171201` union all

        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20180101` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20180201` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20180301` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20180401` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20180501` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20180601` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20180701` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20180801` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20180901` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20181001` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20181101` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20181201` union all

        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20190101` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20190201` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20190301` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20190401` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20190501` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20190601` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20190701` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20190801` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20190901` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20191001` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20191101` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20191201` union all

        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20200101` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20200201` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20200301` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20200401` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20200501` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20200601` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20200701` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20200801` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20200901` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20201001` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20201101` union all
        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20201201` union all

        select * from `cse-6242-sp22-nyatl.CITIBIKE_STG.citibike_trip_20210101`
    )
)

select * from source
