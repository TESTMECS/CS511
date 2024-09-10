-module(train).
-compile(export_all).
-compile(nowarn_export_all).

start() ->
    register(loading_machine, spawn(fun loadingMachine/0)),
    register(control_center, spawn(?MODULE,controlCenterLoop,[1,1])),
    [ spawn(?MODULE,passengerTrain,[0]) || _ <- lists:seq(1,10) ],
    [ spawn(?MODULE,passengerTrain,[1]) || _ <- lists:seq(1,10) ],
    [ spawn(?MODULE,freightTrain,[0]) || _ <- lists:seq(1,5) ],
    [ spawn(?MODULE,freightTrain,[1]) || _ <- lists:seq(1,5) ].

passengerTrain(Direction) ->
    % io:format("Passenger train attempting to acquire track ~p~n", [Direction]),
    acquireTrack(Direction),
    % io:format("Passenger train acquired track ~p~n", [Direction]),
    
    %% Simulate passengers getting on/off the train
    timer:sleep(rand:uniform(1000)),
    
    % io:format("Passenger train releasing track ~p~n", [Direction]),
    releaseTrack(Direction).
    % io:format("Passenger train released track ~p~n", [Direction]).

freightTrain(_Direction) ->
    % io:format("Freight train attempting to acquire track 0~n"),
    acquireTrack(0),
    % io:format("Freight train acquired track 0~n"),

    % io:format("Freight train attempting to acquire track 1~n"),
    acquireTrack(1),
    % io:format("Freight train acquired track 1~n"),

    % io:format("Freight train waiting for the loading machine~n"),
    waitForLoadingMachine(),
    % io:format("Freight train finished loading~n"),

    % io:format("Freight train releasing track 0~n"),
    releaseTrack(0),
    % io:format("Freight train released track 0~n"),

    % io:format("Freight train releasing track 1~n"),
    releaseTrack(1).
    % io:format("Freight train released track 1~n").

%% Continues on next page



loadingMachine() ->
    receive
       {From,permToProcess} ->
	    timer:sleep(rand:uniform(1000)), % processing
	    From!{doneProcessing},
	    loadingMachine()
    end.

%% activate loading machine and then wait for it to finish
waitForLoadingMachine() -> %% TODO
    loading_machine ! {self(), permToProcess},
    receive
        {doneProcessing} -> ok
    end.


releaseTrack(N) ->
    whereis(control_center)!{self(),release,N}.
 
acquireTrack(N) ->  %% TODO
    whereis(control_center) ! {self(), acquire, N},
    receive
        {acquired, N} -> ok
    end.


%% used by acquireTrack and releaseTrack
%% S0 is 0 (track 0 has been acquired) or 1 (track 0 is free) 
%% S1 is 0 (track 1 has been acquired) or 1 (track 1 is free) 
%% understands two types of messages:
%% {From,acquire,N}  -- acquire track N
%% {From,release,N}  -- release track N
controlCenterLoop(S0,S1) -> %% TODO
    receive
    {From, acquire, 0} when S0 == 1 ->
        From ! {acquired, 0},
        controlCenterLoop(0, S1);
    {From, acquire, 1} when S1 == 1 ->
        From ! {acquired, 1},
        controlCenterLoop(S0, 0);
    {_, release, 0} ->
        controlCenterLoop(1, S1);
    {_, release, 1} ->
        controlCenterLoop(S0, 1)
    end.
 
