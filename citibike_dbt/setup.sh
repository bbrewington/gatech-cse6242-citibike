#!/usr/bin/env bash

# Change to citibike_dbt directory
cd $(git rev-parse --show-toplevel)/citibike_dbt

# Create virtual environment and install requirements
python3 -m venv venv &&
source venv/bin/activate &&
pip install --upgrade pip &&
pip install -r requirements.txt

# Set default dbt profiles dir to current directory
export DBT_PROFILES_DIR='.'

# Run setup validation script
source setup_validate.sh
