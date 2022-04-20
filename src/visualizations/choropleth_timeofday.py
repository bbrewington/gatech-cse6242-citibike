#!/usr/bin/env python
# coding: utf-8

### This code generates the interactive choropleth graph that visualizes ridership at different times of day

import pandas as pd
import plotly.express as px
import plotly.io as pio
import json

nycmap = json.load(open('nyc.geojson'))
hm = pd.read_csv('time_choro.csv')

fig = px.choropleth_mapbox(hm,
                           geojson = nycmap,
                          mapbox_style = 'carto-positron',
                          locations = 'zipcode',
                          featureidkey='properties.postalCode',
                          color = 'Early Morning (12AM-4AM)',
                          center = {"lat": 40.71911552, "lon": -74.00666661},
                          labels = {'Early Morning (12AM-4AM)': 'Ride Count'},
                          opacity = 0.7,
                          color_continuous_scale="YlGnBu")


dropdown_buttons =[{'label': 'Early Morning (12AM-4AM)', 'method' : 'restyle', 'args': [{'z': [hm["Early Morning (12AM-4AM)"]]}, {'visible': [True, False, False, False, False, False, False, False, False]}, {'title': 'Early Morning (12AM-4AM)'}]},
                   {'label': 'Morning (5AM-8AM)', 'method' : 'restyle', 'args': [{'z': [hm["Morning (5AM-8AM)"]]}, {'visible': [False, True, False, False, False, False, False, False, False]}, {'title': 'Morning (5AM-8AM)'}]},
                   {'label': 'Late Morning (9AM - 11AM)', 'method' : 'restyle', 'args': [{'z': [hm["Late Morning (9AM - 11AM)"]]}, {'visible': [False, False, True, False, False, False, False, False, False]}, {'title': 'Late Morning (9AM - 11AM)'}]},
                   {'label': 'Afternoon (12PM - 4PM)', 'method' : 'restyle', 'args': [{'z': [hm["Afternoon (12PM - 4PM)"]]}, {'visible': [False, False, False, True, False, False, False, False, False]}, {'title': 'Afternoon (12PM - 4PM)'}]},
                   {'label': 'Early Evening (5PM - 9PM)', 'method' : 'restyle', 'args': [{'z': [hm["Early Evening (5PM - 9PM)"]]}, {'visible': [False, False, False, False, True, False, False, False, False]}, {'title': 'Early Evening (5PM - 9PM)'}]},
                   {'label': 'Late Evening (10PM - 11PM)', 'method' : 'restyle', 'args': [{'z': [hm["Late Evening (10PM - 11PM)"]]}, {'visible': [False, False, False, False, False, True, False, False, False]}, {'title': 'Late Evening (10PM - 11PM)'}]}]

fig.update_layout({'updatemenus':[{'type': 'dropdown', 'showactive': True, 'active': 0, 'buttons': dropdown_buttons}]})

# fig.show()

with open('../../docs/_includes/choropleth_timeofday.html', 'w') as f:
    f.write(pio.to_html(fig, include_plotlyjs='cdn'))
