-module(advent_of_code).

-export([ run_all/0
        , run_challenge/1
        ]).

run_all() ->
    advent_of_code_day_0:run().

%% Not recommended and it's nasty but it does work
-spec run_challenge(integer()) -> any().
run_challenge(Day) ->
    Module = list_to_atom("advent_of_code_day_" ++ integer_to_list(Day)),
    erlang:apply(Module, run, []).
