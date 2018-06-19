-module(weather_tests).
-compile([export_all]).
-include_lib("eunit/include/eunit.hrl").

% The api module must simulate time spent in an API call.
% Don't remove the sleep!
api_test() ->
  {Time, _} = timer:tc(weather_api, get_weather, [foo]),
  ?assert(Time >= 500000).

forecast_test() ->
  {Time, Value} = timer:tc(weather, forecast, [["Chicago", "Sydney", "London", "San Antonio", "Antarctica"]]),
  % We got the right data
  ?assertEqual(["Windy", "Clear", "Rainy", "Hot", "Cold"], Value),
  % And it took less than 2 seconds
  ?assert(Time < 1 * 1000 * 1000),
   {Time_C, Value_C} = timer:tc(weather, forecast, [["Chicago"]]),
    ?assertEqual(["Windy"],Value_C),
    ?assert(Time < 1 * 1000).
current_test() ->
  {Time, Value} = timer:tc(weather, current, [["Chicago", "Sydney", "London", "San Antonio", "Antarctica"]]),
  % We got the right data
  ?assertEqual(["Clear", "Rainy", "Hot", "Hot", "Cold"], Value),
  % And it took less than 2 seconds
  ?assert(Time < 1 * 1000 * 1000),
   {Time_C, Value_C} = timer:tc(weather, current, [["London"]]),
    ?assertEqual(["Hot"],Value_C),
    ?assert(Time < 1 * 1000).

    
