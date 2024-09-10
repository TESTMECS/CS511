-module(bt).
-compile(nowarn_export_all).
-compile(export_all).
-type btree() :: {empty}
                | {node, number(), btree(), btree()}.
%% Example of a complete bt
-spec t1() -> btree().
t1() ->
    {node, 1,{node, 2, {empty}, {empty}},{node, 3, {empty}, {empty}}}.
%% Example of a non-complete bt
-spec t2() -> btree().
t2() ->
    {node, 1,
        {node, 2, {empty}, {empty}},
        {node, 3,
            {empty},
            {node, 3, {empty}, {empty}}}}.
%% Checks that all the trees in the queue are empty trees.
-spec all_empty(queue:queue()) -> boolean().
all_empty(Q) ->
    case queue:out(Q) of
        {{value, {empty}}, Q2} -> all_empty(Q2);
        {empty, _} -> true;
        _ -> false
    end.
%% helper function for ic
-spec ich(queue:queue()) -> boolean().
ich(Q) ->
    case queue:out(Q) of
        {{value, {empty}}, Q2} -> 
            all_empty(Q2);
        {{value, {node, _, Left, Right}}, Q2} ->
            Q3 = queue:in(Left, Q2),
            Q4 = queue:in(Right, Q3),
            % check updated queue
            ich(Q4);
        {empty, _} -> 
            true
    end.
-spec ic(btree()) -> boolean().
ic(T) ->
    ich(queue:in(T, queue:new())).