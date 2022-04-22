## Introduction

<a href="https://citibikenyc.com/">Citi Bike</a> is a bike sharing service in New York City with over 24,500 bikes and 1,500 bike stations

The goal of this project is to provide holistic insights and visualizations for Citi Bike trends and factors impacting ridership behavior to inform city planning and transit planning

## Stations and Total Rides

In this scatterplot, each <b>circle</b> is a neighborhood, and the <b>circle size</b> indicates number of stations in the neighborhood.

{% include stations_and_total_rides_scatterplot.html %}

## Choropleth Map: Ridership By Zip Code Per Year

In 2013, Citi Bike operated less than 300 stations, spanning from just below central park in Midtown Manhattan to Lower Manhattan, with a small network of stations expanding out into Northern and Downtown Brooklyn. 

In 2021, Citi Bike has +1,000 stations, spans the entirety of Manhattan, has significantly expanded its footprint in Brooklyn and now operates in the Bronx and Queens.

Manhattan and Brooklyn remain the boroughs with the largest amount of stations

{% include choropleth_by_year.html %}

## Choropleth Map: Ridership Trends By Zip Code Throughout The Day

Using 2021 ridership data, this chart shows the geographic trends by time of day.

Use the drop-down menu to explore different times

{% include choropleth_timeofday.html %}

## Membership Signups

Observations:
* Annual membership signups have stayed relatively consistent
* Casual member sign-ups have grown significantly, especially in 2020, 2021
* Annual members still account for 50% of membership revenue

{% include citibike_membership_signups.html %}

<br>

## Impact of Weather Factors on Ridership

Use the drop-down options to explore how ridership is impacted by different weather factors

{% include weather_factors_impact.html %}