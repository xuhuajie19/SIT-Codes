-module(watcher).
-export([watcher/2,watcher/3]).

watcher(PID, Table) ->
    process_flag(trap_exit, true),

    UpdateTable=[X || X <- Table, element(2,X)=/=PID],
    Index=[element(1,X) || X <- Table, element(2,X)==PID],

    {NewPID, Ref}=spawn_monitor(sensors,sensors,[lists:nth(1,Index),self()]),
    NewTable=[{lists:nth(1,Index), NewPID}] ++ UpdateTable,

    io:format("The Updated List is ~p~n", [NewTable]),
    process(NewTable).

watcher(init, Start, N) ->
    process_flag(trap_exit,true),
    Table=[{Id, element(1,spawn_monitor(sensors, sensors, [Id, self()]))} || Id <- lists:seq(Start, Start+N-1)],

    io:format("The original List is ~p~n", [Table]),
    process(Table).

process(Table) ->
    receive
        {'DOWN', Ref, process, PID, Reason}->
            Index=[element(1,X) || X <- Table, element(2, X)==PID],

            io:format("The sensor number is ~p and its reason is ~p~n", [lists:nth(1,Index),Reason]),
            watcher(PID,Table);
        {Id, Measurement}->
            io:format("sensor number is ~p measurement number is ~p~n", [Id,Measurement]),
            process(Table)
    end.