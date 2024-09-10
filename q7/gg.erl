-module(gg).
-compile(export_all).
-compile(nowarn_export_all).

%% Aug 1, 2024

start(N) ->
    S = spawn(fun server/0),
    [ spawn(?MODULE,client,[S]) || _ <- lists:seq(1,N)].

server() -> 
    receive 
	{From,Ref,start} ->
            Servlet = spawn(?MODULE,servlet_loop,[rand:uniform(100)]),
	    From!{ok,Servlet,Ref},
	    server()
    end.


servlet_loop(N) ->
    receive 
	{From,Guess,Ref,guess} ->
	    case Guess==N of
		true ->
		    From!{self(),Ref,gotit};
		_ ->
		    From!{self(),Ref,tryAgain},
		    servlet_loop(N)
	    end
    end.

		    

client_loop(Servlet,C) ->
    R = make_ref(),
    N = rand:uniform(100),
    Servlet!{self(),N,R,guess},
    receive
	{Servlet,R,gotit} ->
	    io:format("Client ~p guessed the number ~w in ~w tries~n",[self(),N,C]);
	{Servlet,R,tryAgain} ->
	    client_loop(Servlet,C+1)
    end.

client(S) -> 
    R = make_ref(),
    S!{self(),R,start},
    receive
	{ok,Servlet,R} ->
	    client_loop(Servlet,0)
    end.

	    
