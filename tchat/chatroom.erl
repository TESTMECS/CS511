-module(chatroom).

-include_lib("./defs.hrl").

-export([start_chatroom/1]).

-spec start_chatroom(_ChatName) -> _.
-spec loop(_State) -> _.
-spec do_register(_State, _Ref, _ClientPID, _ClientNick) -> _NewState.
-spec do_unregister(_State, _ClientPID) -> _NewState.
-spec do_update_nick(_State, _ClientPID, _NewNick) -> _NewState.
-spec do_propegate_message(_State, _Ref, _ClientPID, _Message) -> _NewState.

start_chatroom(ChatName) ->
    loop(#chat_st{name = ChatName,
		  registrations = maps:new(), history = []}),
    ok.

loop(State) ->
    NewState =
	receive
	    %% Server tells this chatroom to register a client
	    {_ServerPID, Ref, register, ClientPID, ClientNick} ->
		do_register(State, Ref, ClientPID, ClientNick);
	    %% Server tells this chatroom to unregister a client
	    {_ServerPID, _Ref, unregister, ClientPID} ->
		do_unregister(State, ClientPID);
	    %% Server tells this chatroom to update the nickname for a certain client
	    {_ServerPID, _Ref, update_nick, ClientPID, NewNick} ->
		do_update_nick(State, ClientPID, NewNick);
	    %% Client sends a new message to the chatroom, and the chatroom must
	    %% propegate to other registered clients
	    {ClientPID, Ref, message, Message} ->
		do_propegate_message(State, Ref, ClientPID, Message);
	    {TEST_PID, get_state} ->
		TEST_PID!{get_state, State},
		loop(State)
end,
    loop(NewState).

%% Registers a new client to the chatroom
do_register(State, Ref, ClientPID, ClientNick) ->
    UpdatedRegistrations = maps:put(ClientPID, ClientNick, State#chat_st.registrations),
    ClientPID ! {self(), Ref, connect, State#chat_st.history},
    State#chat_st{registrations = UpdatedRegistrations}.

%% Unregisters a client from the chatroom
do_unregister(State, ClientPID) ->
    UpdatedRegistrations = maps:remove(ClientPID, State#chat_st.registrations),
    State#chat_st{registrations = UpdatedRegistrations}.

%% Updates the nickname of a specified client
do_update_nick(State, ClientPID, NewNick) ->
    UpdatedRegistrations = maps:update(ClientPID, NewNick, State#chat_st.registrations),
    State#chat_st{registrations = UpdatedRegistrations}.

%% Propagates a new message to all clients except the sender
do_propegate_message(State, Ref, ClientPID, Message) ->
    %% acknowledge the sender
    ClientPID ! {self(), Ref, ack_msg},
    %% filter out the sender from the list of clients
    FilteredClients = maps:filter(fun(PID, _) -> PID =/= ClientPID end, State#chat_st.registrations),
    ClientPIDs = maps:keys(FilteredClients),
    %% retrieve the sender's nickname
    {ok, Nick} = maps:find(ClientPID, State#chat_st.registrations),
    %% send the message to each client in the chatroom
    lists:foreach(
        fun(PID) ->
            PID ! {request, self(), Ref, {incoming_msg, Nick, State#chat_st.name, Message}}
        end,
        ClientPIDs
    ),
    %% update chat history
    UpdatedHistory = State#chat_st.history ++ [{Nick, Message}],
    State#chat_st{history = UpdatedHistory}.



