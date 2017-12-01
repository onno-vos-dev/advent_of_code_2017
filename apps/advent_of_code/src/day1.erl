-module(day1).

-export([ one/0
        ]).

-define(LF(X), lists:flatten(X)).
-define(REX_OPTS, [{capture, first, list}, global]).

one() ->
  {ok, Bin} = file:read_file(code:priv_dir(advent_of_code) ++ "/day1.txt"),
  {match, L} = re:run(binary_to_list(Bin), "([0-9])", ?REX_OPTS),
  {_, A} = captcha(L, 1),
  {_, B} = captcha(L, length(L) div 2),
  {{day1, A}, {day2, B}}.

captcha(List, Nth) ->
  LL = List ++ List,
  lists:foldl(fun(L, {N, Sum}) ->
                  case L =:= lists:nth(N + Nth, LL) of
                    true -> {N + 1, Sum + list_to_integer(?LF(L))};
                    false -> {N + 1, Sum}
                  end
              end, {1, 0}, List).
