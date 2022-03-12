from google.cloud import bigquery

gbq_schema_201806_202101 = [
    bigquery.SchemaField("tripduration", "STRING"),
    bigquery.SchemaField("starttime", "STRING"),
    bigquery.SchemaField("stoptime", "STRING"),
    bigquery.SchemaField("start_station_id", "STRING"),
    bigquery.SchemaField("start_station_name", "STRING"),
    bigquery.SchemaField("start_station_latitude", "STRING"),
    bigquery.SchemaField("start_station_longitude", "STRING"),
    bigquery.SchemaField("end_station_id", "STRING"),
    bigquery.SchemaField("end_station_name", "STRING"),
    bigquery.SchemaField("end_station_latitude", "STRING"),
    bigquery.SchemaField("end_station_longitude", "STRING"),
    bigquery.SchemaField("bikeid", "STRING"),
    bigquery.SchemaField("usertype", "STRING"),
    bigquery.SchemaField("birth_year", "STRING"),
    bigquery.SchemaField("gender", "STRING")
]

gbq_schema_202102_onward = [
    bigquery.SchemaField("ride_id", "STRING"),
    bigquery.SchemaField("rideable_type", "STRING"),
    bigquery.SchemaField("started_at", "STRING"),
    bigquery.SchemaField("ended_at", "STRING"),
    bigquery.SchemaField("start_station_name", "STRING"),
    bigquery.SchemaField("start_station_id", "STRING"),
    bigquery.SchemaField("end_station_name", "STRING"),
    bigquery.SchemaField("end_station_id", "STRING"),
    bigquery.SchemaField("start_lat", "STRING"),
    bigquery.SchemaField("start_lng", "STRING"),
    bigquery.SchemaField("end_lat", "STRING"),
    bigquery.SchemaField("end_lng", "STRING"),
    bigquery.SchemaField("member_casual", "STRING")
]

def gcs_to_bigquery(project_id, source_bucket, source_blob, dest_dataset, dest_table, dest_schema):
    client = bigquery.Client(project_id)

    table_id = project_id + '.' + dest_dataset + '.' + dest_table

    job_config = bigquery.LoadJobConfig(
        schema=dest_schema,
        skip_leading_rows=1,
        source_format = bigquery.SourceFormat.CSV,
        write_disposition = bigquery.WriteDisposition.WRITE_APPEND
    )

    uri = "gs://" + source_bucket + '/' + source_blob

    load_job = client.load_table_from_uri(
        uri, table_id, job_config=job_config
    )

    load_job.result()

gcs_to_bigquery(project_id='cse-6242-sp22-nyatl', source_bucket='citibike_trip_history', source_blob='202102-citibike-tripdata.csv', dest_dataset='STAGING_EXP_24HR', dest_table='citibike_trip_202102_onward', dest_schema=gbq_schema_202102_onward)
