-module(server).

-export([start_server/0]).

-include_lib("./defs.hrl").

-spec start_server() -> _.
-spec loop(_State) -> _.
-spec do_join(_ChatName, _ClientPID, _Ref, _State) -> _.
-spec do_leave(_ChatName, _ClientPID, _Ref, _State) -> _.
-spec do_new_nick(_State, _Ref, _ClientPID, _NewNick) -> _.
-spec do_client_quit(_State, _Ref, _ClientPID) -> _NewState.

start_server() ->
    catch(unregister(server)),
    register(server, self()),
    case whereis(testsuite) of
	undefined -> ok;
	TestSuitePID -> TestSuitePID!{server_up, self()}
    end,
    loop(
      #serv_st{
	 nicks = maps:new(), %% nickname map. client_pid => "nickname"
	 registrations = maps:new(), %% registration map. "chat_name" => [client_pids]
	 chatrooms = maps:new() %% chatroom map. "chat_name" => chat_pid
	}
     ).

loop(State) ->
    receive 
	%% initial connection
	{ClientPID, connect, ClientNick} ->
	    NewState =
		#serv_st{
		   nicks = maps:put(ClientPID, ClientNick, State#serv_st.nicks),
		   registrations = State#serv_st.registrations,
		   chatrooms = State#serv_st.chatrooms
		  },
	    loop(NewState);
	%% client requests to join a chat
	{ClientPID, Ref, join, ChatName} ->
	    NewState = do_join(ChatName, ClientPID, Ref, State),
	    loop(NewState);
	%% client requests to join a chat
	{ClientPID, Ref, leave, ChatName} ->
	    NewState = do_leave(ChatName, ClientPID, Ref, State),
	    loop(NewState);
	%% client requests to register a new nickname
	{ClientPID, Ref, nick, NewNick} ->
	    NewState = do_new_nick(State, Ref, ClientPID, NewNick),
	    loop(NewState);
	%% client requests to quit
	{ClientPID, Ref, quit} ->
	    NewState = do_client_quit(State, Ref, ClientPID),
	    loop(NewState);
	{TEST_PID, get_state} ->
	    TEST_PID!{get_state, State},
	    loop(State)
    end.

%% executes join protocol from server perspective
do_join(ChatName, ClientPID, Ref, State) ->
    %% 4. check if the chatroom already exists
    case maps:find(ChatName, State#serv_st.chatrooms) of
        {ok, ChatPID} ->
            %% 5. chatroom exists, retrieve the client's nickname
            {ok, ClientNick} = maps:find(ClientPID, State#serv_st.nicks),
            %% 6. register the client in the chatroom
            ChatPID ! {self(), Ref, register, ClientPID, ClientNick},
            %% 7. update the registrations map with the new client
            UpdatedRegistrations = maps:update(
                ChatName,
                [ClientPID | maps:get(ChatName, State#serv_st.registrations)],
                State#serv_st.registrations
            ),
            %% return the updated server state
            #serv_st{
                nicks = State#serv_st.nicks,
                registrations = UpdatedRegistrations,
                chatrooms = State#serv_st.chatrooms
            };
        error ->
            %% chatroom does not exist, create a new one
            ChatPID = spawn(chatroom, start_chatroom, [ChatName]),
            {ok, ClientNick} = maps:find(ClientPID, State#serv_st.nicks),
            %% register the client in the new chatroom
            ChatPID ! {self(), Ref, register, ClientPID, ClientNick},
            %% update the registrations and chatrooms maps with the new chatroom
            UpdatedRegistrations = maps:put(ChatName, [ClientPID], State#serv_st.registrations),
            UpdatedChatrooms = maps:put(ChatName, ChatPID, State#serv_st.chatrooms),
            %% return the updated server state
            #serv_st{
                nicks = State#serv_st.nicks,
                registrations = UpdatedRegistrations,
                chatrooms = UpdatedChatrooms
            }
    end.



%% executes leave protocol from server perspective
do_leave(ChatName, ClientPID, Ref, State) ->
    %% lookup chatroom PID from server state
    ChatPID = maps:get(ChatName, State#serv_st.chatrooms),
    %% update the registrations map by removing the client
    UpdatedRegistrations = maps:update(
        ChatName,
        lists:delete(ClientPID, maps:get(ChatName, State#serv_st.registrations)),
        State#serv_st.registrations
    ),
    %% create the new state with updated registrations
    NewState = State#serv_st{
        registrations = UpdatedRegistrations
    },
    %% notify the chatroom of the client's departure
    ChatPID ! {self(), Ref, unregister, ClientPID},
    %% acknowledge the leave request to the client.
    ClientPID ! {self(), Ref, ack_leave},
    NewState.


%% executes new nickname protocol from server perspective
do_new_nick(State, Ref, ClientPID, NewNick) ->
    case lists:member(NewNick, maps:values(State#serv_st.nicks)) of
        true ->
            %% nickname is already in use, notify the client
            ClientPID ! {self(), Ref, err_nick_used},
            State;
        false ->
            %% find all chatrooms the client is registered in.
            Rooms = maps:filter(
                fun(_, Clients) -> lists:member(ClientPID, Clients) end,
                State#serv_st.registrations
            ),
            %% notify each chatroom of the nickname change
            UpdateNickInRoom = fun(ChatName) ->
                {ok, ChatPID} = maps:find(ChatName, State#serv_st.chatrooms),
                ChatPID ! {self(), Ref, update_nick, ClientPID, NewNick}
            end,
            lists:foreach(UpdateNickInRoom, maps:keys(Rooms)),
            %% update the nickname in the server state
            UpdatedNicks = maps:put(ClientPID, NewNick, State#serv_st.nicks),
            %% notify the client that the nickname was updated successfully
            ClientPID ! {self(), Ref, ok_nick},
            %% return the updated server state
            #serv_st{
                nicks = UpdatedNicks,
                registrations = State#serv_st.registrations,
                chatrooms = State#serv_st.chatrooms
            }
    end.
%% executes client quit protocol from server perspective
do_client_quit(State, Ref, ClientPID) ->
    %% remove the clients nickname
    NewNicks = maps:remove(ClientPID, State#serv_st.nicks),
    %% update the registrations by removing the client from all chatrooms.
    UpdatedRegistrations =
        maps:map(
            fun(_ChatName, ClientList) ->
                lists:delete(ClientPID, ClientList)
            end,
            State#serv_st.registrations
        ),
    %% send the unregister message to each chatroom that the client was part of
    ChatroomNames = maps:keys(State#serv_st.chatrooms),
    lists:foreach(
        fun(ChatName) ->
            case maps:find(ChatName, UpdatedRegistrations) of
                {ok, _} ->
                    case maps:find(ChatName, State#serv_st.chatrooms) of
                        {ok, ChatroomPID} ->
                            ChatroomPID ! {self(), Ref, unregister, ClientPID};
                        error -> ok 
                    end;
                error -> ok 
            end
        end,
        ChatroomNames
    ),
    %% acknowledge the client's quit
    ClientPID ! {self(), Ref, ack_quit},
    %% return the updated state.
    State#serv_st{nicks = NewNicks, registrations = UpdatedRegistrations}.




