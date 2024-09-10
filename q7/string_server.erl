-module(string_server).
-compile(export_all).
-compile(nowarn_export_all).
start() ->
    S = spawn(?MODULE, server, []),
    [spawn(?MODULE, client, [S]) || _ <- lists:seq(1, 10000)].
client(S) -> 
    R = make_ref(),
    S ! {self(), R, start},
    receive
        {ok, Servlet, R} ->
            client_loop(Servlet),
            receive
                {done, Str} ->
                    io:format("Client ~p received result: ~s~n", [self(), Str])
            end
    end.
client_loop(Servlet) ->
    Servlet!{add, "h"},
    Servlet!{add, "e"},
    Servlet!{add, "l"},
    Servlet!{add, "l"},
    Servlet!{add, "o"},
    Servlet!{done, self()}.
server() -> 
    receive 
        {From, Ref, start} ->
            Servlet = spawn(?MODULE, servlet_loop, [""]),
            From ! {ok, Servlet, Ref},
        server()
    end.
servlet_loop(CurrentString) ->
    receive 
        {add, S} ->
            servlet_loop(CurrentString ++ S);
        {done, From} ->
            From ! {done, CurrentString}
    end.


