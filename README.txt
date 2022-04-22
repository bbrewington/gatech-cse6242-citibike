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

1. cd into root directory of this repo (or unzipped zip file)
2. Install Python libraries:
    % pip install pandas==1.4.2
    % pip install plotly==5.7.0
3. Install R

#############
# EXECUTION #
#############

Data Extraction & Warehousing
-----------------------------
This is all configured in github repo: https://github.com/bbrewington/gatech-cse6242-citibike
It requires access to the Google Cloud project `cse-6242-sp22-nyatl`, as well as some credentials saved in GitHub as secrets
Dr. Chau has access to the Google Cloud project (BigQuery, Storage) via polo@gatech.edu
If you need access as a grader please reach out to brent.brewington@gmail.com 
Here is a sample GitHub Actions run which extracted data from AWS and loaded into BigQuery:
    https://github.com/bbrewington/gatech-cse6242-citibike/runs/6124015985

Visualization & Analysis Scripts
--------------------------------
1. Run visualization scripts:
    These scripts are designed to output to an HTML file in the docs/_includes folder, which is used by the GitHub Pages site
    If you prefer to view the actual Plotly output, you can comment out the last couple lines and uncomment fig.show()
    All HTML outputs are visible here: https://bbrewington.github.io/gatech-cse6242-citibike/
      % python3 src/visualizations/choropleth_by_year.py
      % python3 src/visualizations/choropleth_timeofday.py
      % python3 src/visualizations/stations_and_total_rides_scatterplot.py
      % python3 src/visualizations/weather_factors_impact.py

2. Use Jupyter to view/run these analysis notebooks:
    src/WeatherAnalysis_LinearRegression_R_Final.ipynb
    src/WeatherAnalysis_RandomForest_Python_Final.ipynb