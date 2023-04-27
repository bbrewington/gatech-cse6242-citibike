cd $(git rev-parse --show-toplevel)/data

curl \
  https://data.cityofnewyork.us/api/geospatial/cpf4-rkhq\?method\=export\&format\=GeoJSON | \
  jq -c '.features[]' > \
  geo/nyc-2010-ntas-jsonl.geojson

bq load \
  --source_format=NEWLINE_DELIMITED_JSON \
  --json_extension=GEOJSON \
  --autodetect \
  --replace \
  GEO.nyc_neighborhoods_raw_2010 \
  geo/nyc-2010-ntas-jsonl.geojson
