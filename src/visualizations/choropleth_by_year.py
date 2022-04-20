#!/usr/bin/env python
# coding: utf-8

### This code generates the interactive choropleth graph that visualizes ridership for each year (2013-2021)

import pandas as pd
import plotly.express as px
import plotly.io as pio
import json

nycmap = json.load(open('nyc.geojson'))
sm = pd.read_csv('zipcode_choro3.csv')

fig = px.choropleth_mapbox(sm,
                           geojson = nycmap,
                          mapbox_style = 'carto-positron',
                          locations = 'zipcode',
                          featureidkey='properties.postalCode',
                          color = '2013',
                          center = {"lat": 40.71911552, "lon": -74.00666661},
                          labels = {'2013': 'Ride Count'},
                          opacity = 0.7,
                          color_continuous_scale="thermal")


dropdown_buttons =[{'label': '2013', 'method' : 'restyle', 'args': [{'z': [sm["2013"]]}, {'visible': [True, False, False, False, False, False, False, False, False]}, {'title': '2013'}]},
                   {'label': '2014', 'method' : 'restyle', 'args': [{'z': [sm["2014"]]}, {'visible': [False, True, False, False, False, False, False, False, False]}, {'title': '2014'}]},
                   {'label': '2015', 'method' : 'restyle', 'args': [{'z': [sm["2015"]]}, {'visible': [False, False, True, False, False, False, False, False, False]}, {'title': '2015'}]},
                   {'label': '2016', 'method' : 'restyle', 'args': [{'z': [sm["2016"]]}, {'visible': [False, False, False, True, False, False, False, False, False]}, {'title': '2016'}]},
                   {'label': '2017', 'method' : 'restyle', 'args': [{'z': [sm["2017"]]}, {'visible': [False, False, False, False, True, False, False, False, False]}, {'title': '2017'}]},
                   {'label': '2018', 'method' : 'restyle', 'args': [{'z': [sm["2018"]]}, {'visible': [False, False, False, False, False, True, False, False, False]}, {'title': '2018'}]},
                  {'label': '2019', 'method' : 'restyle', 'args': [{'z': [sm["2019"]]}, {'visible': [False, False, False, False, False, False, True, False, False]}, {'title': '2019'}]},
                  {'label': '2020', 'method' : 'restyle', 'args': [{'z': [sm["2020"]]}, {'visible': [False, False, False, False, False, False, False, True, False]}, {'title': '2020'}]},
                  {'label': '2021', 'method' : 'restyle', 'args': [{'z': [sm["2021"]]}, {'visible': [False, False, False, False, False, False, False, False, True]}, {'title': '2021'}]},]

fig.update_layout({'updatemenus':[{'type': 'dropdown', 'showactive': True, 'active': 0, 'buttons': dropdown_buttons}]})

# fig.show()

with open('../../docs/_includes/choropleth_by_year.html', 'w') as f:
    f.write(pio.to_html(fig, include_plotlyjs='cdn'))
