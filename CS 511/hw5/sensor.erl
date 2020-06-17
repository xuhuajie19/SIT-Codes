-module(sensor).
-export([sensor/2]).

sensor(Id, From)->
    Measurement = rand:uniform(11),
    Bool = (Measurement == 11),
    if 
        Bool ->
            exit(anomalous_reading);
        true ->
            From!{Id, Measurement}
    end,
    Sleep_time = rand:uniform(10000),
    timer:sleep(Sleep_time),
    sensor(Id, From).
