import pandas as pd
import plotly.graph_objects as go
import plotly.io as pio

df = pd.read_csv("weather_trips_per_day.csv")
#print(df.head())

df_t=df[['num_trips_per_day', 'Temperature_Avg']].copy()
df_t['Temperature_Avg'] = df_t['Temperature_Avg'].round()
df_t = df_t.groupby(['Temperature_Avg']).mean()
df_t.reset_index(inplace=True)


df_d=df[['num_trips_per_day', 'Dew_Avg']].copy()
df_d['Dew_Avg'] = df_d['Dew_Avg'].round()
df_d = df_d.groupby(['Dew_Avg']).mean()
df_d.reset_index(inplace=True)

df_h=df[['num_trips_per_day', 'Humidity_Avg']].copy()
df_h['Humidity_Avg'] = df_h['Humidity_Avg'].round()
df_h = df_h.groupby(['Humidity_Avg']).mean()
df_h.reset_index(inplace=True)
              
df_w=df[['num_trips_per_day', 'Wind Speed_Avg']].copy()
df_w['Wind Speed_Avg'] = df_w['Wind Speed_Avg'].round()
df_w = df_w.groupby(['Wind Speed_Avg']).mean()
df_w.reset_index(inplace=True)

df_p=df[['num_trips_per_day', 'Pressure_Avg']].copy()
df_p['Pressure_Avg'] = df_p['Pressure_Avg'].round()
df_p = df_p.groupby(['Pressure_Avg']).mean()
df_p.reset_index(inplace=True)

              
df_r=df[['num_trips_per_day', 'Precipitation_Avg']].copy()
df_r['Precipitation_Avg'] = df_r['Precipitation_Avg'].round()
df_r = df_r.groupby(['Precipitation_Avg']).mean()
df_r.reset_index(inplace=True)

fig=go.Figure()

fig.add_traces(go.Bar(x=df_t["Temperature_Avg"], y= df_t["num_trips_per_day"], name='Temperature', visible=True, marker={'color':df_t["Temperature_Avg"]}))
fig.update_layout(title="Number of Trips impacted by Temperature",xaxis_title="Average Temperature",yaxis_title="Average Number of Trips")
dropdown_buttons =[{'label': 'Temperature', 
                    'method' : 'update', 
                    'args': [{'x' :[df_t["Temperature_Avg"]], 'y': [df_t["num_trips_per_day"]],
                             'name': 'Temperature',
                             'visible': True},
                             {'title': 'Number of Trips impacted by Temperature', 
                              'xaxis': {'title': 'Average Temperature'},
                              'yaxis': {'title': 'Average Number of Trips'}}
                            ]},
                   {'label': 'Dew', 
                    'method' : 'update', 
                    'args': [{'x' :[df_d["Dew_Avg"]], 'y': [df_d["num_trips_per_day"]],
                             'name':'Dew',
                             'visible': True}, 
                             {'title': 'Number of Trips impacted by Dew',
                              'xaxis': {'title': 'Average Dew'},
                              'yaxis': {'title': 'Average Number of Trips'}}
                            ]},
                    {'label': 'Humidity', 
                    'method' : 'update', 
                    'args': [{'x' :[df_h["Humidity_Avg"]], 'y': [df_h["num_trips_per_day"]],
                             'name':'Humidity',
                             'visible': True}, 
                             {'title': 'Number of Trips impacted by Humidity', 
                              'xaxis': {'title': 'Average Humidity'},
                              'yaxis': {'title': 'Average Number of Trips'}}
                            ]},
                   {'label': 'Wind Speed', 
                    'method' : 'update', 
                    'args': [{'x' :[df_w["Wind Speed_Avg"]], 'y': [df_w["num_trips_per_day"]],
                             'name':'Wind Speed',
                             'visible': True}, 
                             {'title': 'Number of Trips impacted by Wind Speed', 
                              'xaxis': {'title': 'Average Wind Speed'},
                              'yaxis': {'title': 'Average Number of Trips'}}
                            ]},
                    {'label': 'Pressure', 
                    'method' : 'update', 
                    'args': [{'x' :[df_p["Pressure_Avg"]], 'y': [df_p["num_trips_per_day"]],
                             'name':'Pressure',
                             'visible': True}, 
                             {'title': 'Number of Trips impacted by Pressure', 
                              'xaxis': {'title': 'Average Pressure'},
                              'yaxis': {'title': 'Average Number of Trips'}}
                            ]},
                    {'label': 'Precipitation', 
                    'method' : 'update', 
                    'args': [{'x' :[df_r["Precipitation_Avg"]], 'y': [df_r["num_trips_per_day"]],
                             'name':'Precipitation',
                             'visible': True}, 
                             {'title': 'Number of Trips impacted by Precipitation', 
                              'xaxis': {'title': 'Average Precipitation'},
                              'yaxis': {'title': 'Average Number of Trips'}}
                            ]},
                    ]

fig.update_layout({'updatemenus':[{'type': 'dropdown', 'showactive': True, 'active': 0, 'buttons': dropdown_buttons}]})

# fig.show()

with open('../../docs/_includes/weather_factors_impact.html', 'w') as f:
    f.write(pio.to_html(fig, include_plotlyjs='cdn'))