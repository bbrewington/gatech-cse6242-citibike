from google.cloud import storage, bigquery
from google.cloud.exceptions import NotFound
import argparse
import re


# TODO: combine this w/ gcs_list_objects in src/copy_aws_to_gcs.py
def gcs_list_blobs(project_id, gcs_bucket, file_regex):
    storage_client = storage.Client(project_id)
    blobs = storage_client.list_blobs(gcs_bucket)

    return [blob.name for blob in blobs if bool(re.search(file_regex, blob.name))]

def gcs_to_bigquery(project_id, source_bucket, source_blob, dest_dataset, dest_table, dest_schema):
    client = bigquery.Client(project_id)

    job_config = bigquery.LoadJobConfig(
        schema=dest_schema,
        skip_leading_rows=1,
        source_format = bigquery.SourceFormat.CSV,
        write_disposition = bigquery.WriteDisposition.WRITE_TRUNCATE
    )

    uri = "gs://" + source_bucket + '/' + source_blob
    table_id = project_id + '.' + dest_dataset + '.' + dest_table

    print(f'writing {source_blob} to {table_id}')
    load_job = client.load_table_from_uri(uri, table_id, job_config=job_config)
    load_job.result()

def gcs_move_file_in_bucket(project_id, bucket_name, file_path_from, file_path_to):
    storage_client = storage.Client(project_id)

    source_bucket = storage_client.bucket(bucket_name)
    source_blob = source_bucket.blob(file_path_from)
    source_bucket.copy_blob(source_blob, source_bucket, new_name=file_path_to)
    try:
        source_bucket.delete_blob(file_path_from)
    except NotFound:    
        print(f'Blob not deleted; not found: {bucket_name}/{file_path_from}')


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

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--project_id', default='cse-6242-sp22-nyatl')
    parser.add_argument('--gcs_bucket', default='citibike_trip_history')
    parser.add_argument('--gbq_dataset', default='CITIBIKE_STG')
    parser.add_argument('--gbq_table_prefix', default='citibike_trip')
    parser.add_argument('--file_regex', default=r'\.csv')
    args = parser.parse_args()

    filelist = gcs_list_blobs(args.project_id, args.gcs_bucket, args.file_regex)
    filelist_prepped = sorted(filelist)

    for filename in filelist_prepped:
        print(filename)
        month_key = filename[:6]
        dest_table = f'{args.gbq_table_prefix}_{month_key}01' # using 01 to enable date sharded tables
        dest_schema = gbq_schema_201806_202101 if month_key <= '202101' else gbq_schema_202102_onward

        gcs_to_bigquery(project_id=args.project_id, source_bucket=args.gcs_bucket, source_blob=filename, \
            dest_dataset=args.gbq_dataset, dest_table=dest_table, dest_schema=dest_schema)
        
        file_path_to = 'loaded_to_gbq/' + filename
        gcs_move_file_in_bucket(args.project_id, args.gcs_bucket, filename, file_path_to)
