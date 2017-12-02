-module(day2).

-export([ run/0
        ]).

run() ->
  L = input(),
  A = solve_a(L),
  B = solve_b(L),
  {{day2a, A}, {day2b, B}}.

solve_a(List) ->
  lists:sum(
    lists:map(fun(Row) ->
                  [L|T] = lists:sort(Row),
                  lists:last(T) - L
              end, List)).

solve_b(List) ->
  lists:foldl(
    fun(Row, Acc) ->
        Acc + div_sum(Row)
    end, 0, List).

div_sum(Row) ->
  lists:foldl(
    fun(V1, Acc) ->
        lists:foldl(
          fun(V2, A) when V1 =/= V2 andalso (V1 rem V2 =:= 0) ->
              A + (V1 div V2);
             (_,A) -> A
          end, Acc, Row)
    end, 0, Row).

input() ->
  {ok, Bin} = file:read_file(code:priv_dir(advent_of_code) ++ "/day2.txt"),
  R = [string:tokens(S, "\t") || S <- string:tokens(binary_to_list(Bin), "\n")],
  lists:map(fun(Row) ->
                lists:map(fun(Rv) -> list_to_integer(Rv) end, Row)
            end, R).

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
