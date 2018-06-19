-module(weather).
-export([forecast/1,current/1]).

%%!-------------------------------------------------------------------
%% forecast -- Returns the forecast details of the Cities.
%%
%% forecast() -> Returns list of forecast
%%--------------------------------------------------------------------

forecast(Cities) when is_list(Cities) -> 
    lists:flatmap(fun(City)-> [weather_api:get_forecast(City)] end,Cities).
	
%%!-------------------------------------------------------------------
%% current -- Returns the current climate of the Cities.
%%
%% current() -> Returns list of current climate
%%--------------------------------------------------------------------
current(Cities) when is_list(Cities) -> 

    lists:flatmap(fun(City)-> [weather_api:get_current(City)] end,Cities).
