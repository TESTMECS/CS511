-module(queue).
-export([new/0, is_empty/1, in/2, out/1]).

% Creates a new empty queue
new() ->
    queue:new().

% Checks if the queue is empty
is_empty(Q) ->
    queue:is_empty(Q).

% Inserts an item at the rear of the queue
in(Item, Q) ->
    queue:in(Item, Q).

% Removes an item from the front of the queue
out(Q) ->
    case queue:out(Q) of
        {{value, Item}, Q2} -> {{value, Item}, Q2};
        {empty, Q} -> {empty, Q}
    end.