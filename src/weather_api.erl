-module(weather_api).
-export([get_weather/1,get_forecast/1,get_current/1]).

%%--------------------------------------------------------------------
%% Records
%%--------------------------------------------------------------------
-record(current, {temp, climate}).
-record(forecast, {temp,climate}).
-record(weather,{current=#current{},forecast=#forecast{}}).

%%====================================================================
%% API
%%====================================================================

get_weather(City) ->
  % Simulated delay in calling an external API.
  timer:sleep(500),
  proplists:get_value(City, weathers()).

weathers() -> [
  {"Chicago",     {weather, {current,  84, "Clear"}, {forecast,  72, "Windy"}}},
  {"Sydney",      {weather, {current,  68, "Rainy"}, {forecast,  53, "Clear"}}},
  {"London",      {weather, {current,  85, "Hot"},   {forecast,  66, "Rainy"}}},
  {"San Antonio", {weather, {current, 102, "Hot"},   {forecast, 105, "Hot"}}},
  {"Antarctica",  {weather, {current, -85, "Cold"},  {forecast, -73, "Cold"}}}].
get_forecast(City) ->
   ((proplists:get_value(City, weathers()))#weather.forecast)#forecast.climate.
get_current(City) ->
   ((proplists:get_value(City, weathers()))#weather.current)#current.climate.
