-module(day1).

-export([ one/0
        , parallel/0
        ]).

-define(REX_OPTS, [{capture, first, list}, global]).

one() ->
  L = input(),
  {_, A} = captcha(L, 1),
  {_, B} = captcha(L, length(L) div 2),
  {{day1, A}, {day2, B}}.

parallel() ->
  L = input(),
  A = fun() -> captcha(L, 1) end,
  B = fun() -> captcha(L, length(L) div 2) end,
  Self = self(),
  Pid1 = spawn_link(fun() -> Self ! {self(), {day1, A()}} end),
  Pid2 = spawn_link(fun() -> Self ! {self(), {day2, B()}} end),
  [ receive {Pid, R} -> R end || Pid <- [Pid1, Pid2] ].

input() ->
  {ok, Bin} = file:read_file(code:priv_dir(advent_of_code) ++ "/day1.txt"),
  {match, L} = re:run(binary_to_list(Bin), "([0-9])", ?REX_OPTS),
  L.

captcha(List, Nth) ->
  LL = List ++ List,
  lists:foldl(fun(L, {N, Sum}) ->
                  case L =:= lists:nth(N + Nth, LL) of
                    true -> {N + 1, Sum + list_to_integer(lists:flatten(L))};
                    false -> {N + 1, Sum}
                  end
              end, {1, 0}, List).
