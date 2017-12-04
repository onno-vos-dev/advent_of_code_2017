-module(day4).

-export([ run/0 ]).

run() ->
  L = input(),
  { {day4a, length(v(fun(P) -> P end, L))}
  , {day4b, length(v(fun(P) -> lists:map(fun lists:sort/1, P) end, L))}}.

v(SF, L) when is_function(SF) -> lists:filter(fun(P) -> v(SF(P), false) end, L);
v([], V) when V =:= false -> true;
v(_, true) -> false;
v([H|T], _) -> v(T, lists:member(H,T)).

input() ->
  {ok, Bin} = file:read_file(code:priv_dir(advent_of_code) ++ "/day4.txt"),
  [string:tokens(S, " ") || S <- string:tokens(binary_to_list(Bin), "\n")].

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
