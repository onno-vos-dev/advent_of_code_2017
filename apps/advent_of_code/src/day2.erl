-module(day2).

-export([ two/0
        ]).

-export([input/0]).

two() ->
  L = input(),
  A = solve_a(L),
  B = solve_b(L),
  {{day1, lists:sum(A)}, {day2, lists:sum(B)}}.

solve_a(List) ->
  lists:map(fun(Row) ->
                [L|T] = lists:sort(Row),
                lists:last(T) - L
            end, List).

%% Here be dragons
solve_b(List) ->
  lists:map(
    fun(Row) ->
        [{RowRes}] = lists:flatten(
                     lists:map(
                       fun(Val1) ->
                           lists:filtermap(
                             fun(Val2) ->
                                 if Val1 == Val2 ->
                                     false;
                                    true ->
                                     case Val1 rem Val2 of
                                       0 ->
                                         {true, {Val1 div Val2}};
                                       _ -> false
                                     end
                                 end
                             end, Row)
                       end, Row)),
          RowRes
    end, List).

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
