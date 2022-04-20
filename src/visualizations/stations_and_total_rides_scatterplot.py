# This code generates the interactive scatterplot displaying total rides & station Count
# For all neighborhoods across the boroughs

import pandas as pd
import plotly.express as px
import plotly.io as pio

citi_scatter = pd.read_csv('interactive_scatter3.csv')

fig = px.scatter(citi_scatter, x="station_count", y="ride_count", animation_frame="year", animation_group="neighborhood",
           size="station_count", color="boro", hover_name="neighborhood",
           log_x = True, size_max=55, range_x=[1, 145], range_y=[100, 1600000],
           labels = {'ride_count': 'Total Rides', 'station_count': 'Count of Stations (Log Scale)'},
           color_discrete_map = {'Queens': 'orange', 'The Bronx': 'green', 'Brooklyn': 'red', 'Manhattan': 'blue'},
           title = 'Count of Stations and Total Rides By Neighborhood, Year Over Year')

with open('stations_and_total_rides_scatterplot.html', 'w') as f:
    f.write(pio.to_html(fig, include_plotlyjs='cdn'))
