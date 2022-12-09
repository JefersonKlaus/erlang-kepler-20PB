-module(kepler).
-export([start/0, loop/1]).

loop(N) ->
    receive
        stop ->
            io:format("Finish him ~n"),
            ok
    after 2000 ->
        io:format("Loop ~p | Hello Erlan!~n", [N]),
        ?MODULE:loop(N+1)
    end.

start() ->
    spawn(?MODULE, loop, [1]).