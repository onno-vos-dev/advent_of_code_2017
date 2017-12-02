-module(day2).

-export([ two/0
        ]).

%% My solution for 2b is pretty damn nasty. Will try to clean up later tonight
two() ->
  L = input(),
  A = solve_a(L),
  B = solve_b(L),
  {{day1, A}, {day2, B}}.

solve_a(List) ->
  lists:sum(
    lists:map(fun(Row) ->
                  [L|T] = lists:sort(Row),
                  lists:last(T) - L
              end, List)).

solve_b(List) ->
  lists:foldl(
    fun(Row, Acc) ->
        lists:sum(
          lists:flatten(
            lists:map(
              fun(Val1) ->
                  lists:filtermap(
                    fun(Val2) ->
                        case Val1 == Val2 orelse (Val1 rem Val2 =/= 0) of
                          true -> false;
                          _ -> {true, Acc + (Val1 div Val2)}
                        end
                    end, Row)
              end, Row)
           )
         )
    end, 0, List).

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
