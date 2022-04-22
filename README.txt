###############
# DESCRIPTION #
###############
Team project for Georgia Tech Masters in Analytics, Spring 2022 - CSE 6242: Data & Visual Analytics

Citi Bike is a bike sharing service in New York City with over 24,500 bikes and 1,500 bike stations.

Project goal is to provide holistic insights and visualizations for Citi Bike trends and factors impacting ridership behavior to empower city and transit planning

The code in this repository orchestrates extraction of raw bike trip data and loading into a Google BigQuery project

Team Members:
* Kevin Schneider
* Roshni Mahtani
* Stephanie Chueh
* Brent Brewington

################
# INSTALLATION #
################

1. Set up virtual environment & install Python libraries:
  % python3 -m venv venv_my
  % source venv_my/bin/activate
  % pip install --upgrade pip
  % pip install --upgrade protobuf
  % pip install boto3
  % pip install google-cloud-storage google-cloud-bigquery
  % pip install dbt-bigquery

2. Set these credentials as environment variables:
    AWS API Credentials:
      % export AWS_ACCESS_KEY=your_key_here
      % export AWS_SECRET_ACCESS_KEY=your_key_here
    Google Cloud service account JSON key:
      % export GCP_CREDENTIALS=

#############
# EXECUTION #
#############
        python src/copy_aws_to_gcs.py \
          --aws_bucket tripdata \
          --aws_access_key ${{ env.AWS_ACCESS_KEY }} \
          --aws_secret_access_key ${{ env.AWS_SECRET_ACCESS_KEY }} \
          --project_id cse-6242-sp22-nyatl \
          --gcs_bucket citibike_trip_history \
          --aws_exclude_pattern '(JC-)|(\d{4}-\d{4})'
