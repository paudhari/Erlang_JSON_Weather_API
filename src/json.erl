-module(json).
-export([render/1]).

%%====================================================================
%% API
%%====================================================================

render({Proplist}) when is_list(Proplist) ->
    erl_obj_to_json(Proplist, "");

render(_)->
    io:format("Invalid Json\n"),
    ok.

%%--------------------------------------------------------------------
%% Internal functions
%%--------------------------------------------------------------------

erl_obj_to_json(Proplist, Json_str)->
    Str = erl_obj_to_json_str(Proplist, Json_str),
    "{" ++ string:sub_string(Str, 2) ++ "}".


erl_obj_to_json_str([], Json_str)->
    Json_str;

erl_obj_to_json_str([Hd| Tl], Json_str)->
    {Key, Value} = Hd,
    DecodedValue = format_value_to_json(Value),
    Str = "," ++ "\"" ++atom_to_list(Key) ++ "\"" ++ ":" ++ DecodedValue,
    erl_obj_to_json_str(Tl, Json_str ++ Str).

%%--------------------------------------------------------------------
%% Internal functions - To convert Erlang data types to JSON values
%%--------------------------------------------------------------------
format_value_to_json(Value) when is_list(Value) ->

    L = lists:map(fun(X) ->
			  format_value_to_json(X)
		  end, Value),
    Str = lists:foldl(fun(X, ACC) ->
			      ACC ++ "," ++X
		      end, "", L),
    "[" ++ string:sub_string(Str, 2) ++ "]";
format_value_to_json(Value) when is_tuple(Value) ->
    {Value1} =Value,
    Str = erl_obj_to_json_str(Value1, ""),
    "{" ++ string:sub_string(Str, 2) ++ "}";
format_value_to_json(Value)  when is_atom(Value) ->
    "\"" ++ atom_to_list(Value) ++ "\"";
format_value_to_json(Value)  when is_integer(Value) ->
    integer_to_list(Value);
format_value_to_json(Value)  when is_binary(Value) ->
    "\"" ++ binary_to_list(Value) ++ "\"";
format_value_to_json(_Value) ->
    "Unkown".
