-module(advent_of_code_day_1).

-export([ run_1a/0
        , run_1b/0
        ]).

%%==============================================================================
%% API functions
%%==============================================================================
run_1a() ->
    {ok, Bin} = file:read_file(code:priv_dir(advent_of_code) ++ "/1a.txt"),
    captcha_1a(binary_to_list(Bin)).

run_1b() ->
    {ok, Bin} = file:read_file(code:priv_dir(advent_of_code) ++ "/1b.txt"),
    captcha_1b(binary_to_list(Bin)).

%%==============================================================================
%% Internal: 1a
%%==============================================================================
captcha_1a(List) ->
    SplitList = split(List),
    sum_captcha_1a(SplitList).

sum_captcha_1a([H|[_|T]] = List) ->
    Acc = case H =:= T of
              true -> list_to_integer(H);
              false -> 0
          end,
    sum_captcha_1a(List, Acc).

sum_captcha_1a([], Acc) -> Acc;
sum_captcha_1a([H1|[H1|_] = T], Acc) ->
    sum_captcha_1a(T, Acc + list_to_integer(H1));
sum_captcha_1a([_|T], Acc) ->
    sum_captcha_1a(T, Acc).

%%==============================================================================
%% Internal: 1b
%%==============================================================================
captcha_1b(List) ->
    %% Duping the list makes it easier to walk ahead
    SplitList = split(List ++ List),
    sum_captcha_1b(SplitList, 0, length(List) div 2, length(List)).

sum_captcha_1b([], Acc, _, _) -> Acc;
sum_captcha_1b(_, Acc, _HalfLength, 0) -> Acc;
sum_captcha_1b([H|T], Acc, HalfLength, Counter) ->
    NewAcc = case H =:= lists:nth(HalfLength, T) of
                 true -> Acc + list_to_integer(H);
                 false -> Acc
             end,
    sum_captcha_1b(T, NewAcc, HalfLength, Counter - 1).

%%==============================================================================
%% Internal
%%==============================================================================
split(List) ->
    %% Can't be bothered figuring out how to filter [] from re:split/3
    lists:filter(
      fun([]) -> false;
         (_) -> true
      end, re:split(List, "([0-9])",  [{return, list}])).
