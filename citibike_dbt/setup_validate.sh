# Confirm dbt is installed & we're in a virtual environment
echo "Currently in virtual environment: \n   $VIRTUAL_ENV\n"
echo "venv has dbt version: $(pip freeze | grep dbt-bigquery)"

dbt debug
