-module(main).
-export([start/0]).

setup_loop(Start, N, 1) ->
	spawn(watcher, watcher, [init, Start, N]);

setup_loop(Start, N, Num_watchers) ->
	spawn(watcher, watcher, [init, Start, 10]);
	setup_loop(Start+10, N-10, Num_watchers-1).

start() ->
	{ok, [N]} = io:fread("enter number of sensors > ", "~d"),
	if (N =< 1) ->
		io:fwrite(" setup : range must be at least 2~n", []);
	true ->
		Num_watchers = 1 + (N div 10),
		setup_loop(0, N, Num_watchers)
	end .