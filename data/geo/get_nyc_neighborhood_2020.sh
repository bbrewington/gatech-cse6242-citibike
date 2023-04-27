cd $(git rev-parse --show-toplevel)/data

curl 'https://data.cityofnewyork.us/api/views/9nt8-h7nd/rows.csv?accessType=DOWNLOAD' \
  --output geo/nyc-2020-ntas.csv

bq load \
  --source_format=CSV \
  --autodetect \
  --replace \
  GEO.nyc_neighborhoods_raw_2020 \
  geo/nyc-2020-ntas.csv
