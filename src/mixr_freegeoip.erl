-module(mixr_freegeoip).
-compile([{parse_transform, lager_transform}]).

-export([
         start/1,
         stop/1,
         find/2
        ]).

start(State) ->
  case application:ensure_all_started(?MODULE) of
    {ok, _} -> {ok, State};
    _ -> error
  end.

stop(_State) ->
  ok.

find(Key, State) ->
  case httpc:request(get,
                     {"http://freegeoip.net/json/" ++ eutils:to_string(Key), []},
                     State,
                     [{sync, true}]) of
    {ok, {{_, 200, _}, _, Body}} ->
      {ok, {eutils:to_binary(Key), eutils:to_binary(lists:flatten(Body)), 0, 3600, 0}};
    {error, _} ->
      not_found
  end.

