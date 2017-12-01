-ifndef(_ADVENT_OF_CODE_LOGGER_).
-define(_ADVENT_OF_CODE_LOGGER_, true).

-define(info(Format, Args),
        lager:log(info, self(), Format, Args)).

-define(debug(Format, Args),
        lager:log(debug, self(), Format, Args)).

-define(alert(Format, Args),
        lager:log(alert, self(), Format, Args)).

-endif.

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
