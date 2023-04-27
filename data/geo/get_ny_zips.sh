cd $(git rev-parse --show-toplevel)/data

curl \
  https://raw.githubusercontent.com/OpenDataDE/State-zip-code-GeoJSON/master/ny_new_york_zip_codes_geo.min.json | \
  jq -c '.features[]' > \
  geo/ny-zips-2010-jsonl.geojson

bq load \
  --source_format=NEWLINE_DELIMITED_JSON \
  --json_extension=GEOJSON \
  --autodetect \
  --replace \
  GEO.ny_zips_2010 \
  geo/ny-zips-2010-jsonl.geojson
