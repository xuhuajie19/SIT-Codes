%% 10442734 Huajie Xu

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
    case maps:find(ChatName, State#serv_st.chatrooms) of
        {ok, R} ->
            S = R,
            FindClients = element(2,maps:find(ChatName, State#serv_st.registrations)),
            NewPID = FindClients++[ClientPID],
            NewState = #serv_st{nicks = State#serv_st.nicks, registrations = maps:put(ChatName, NewPID, State#serv_st.registrations), chatrooms = State#serv_st.chatrooms};
        error ->
            S = spawn(chatroom, start_chatroom, [ChatName]),
            NewPID = [ClientPID],
            NewState = #serv_st{nicks = State#serv_st.nicks, registrations = maps:put(ChatName, NewPID, State#serv_st.registrations), chatrooms = maps:put(ChatName, S, State#serv_st.registrations)}
    end,
    NewNick=element(2,maps:find(ClientPID,State#serv_st.nicks)),
    S!{self(),Ref,register,ClientPID,NewNick},
    NewState.

%% executes leave protocol from server perspective
do_leave(ChatName, ClientPID, Ref, State) ->
    Clients=element(2,maps:find(ChatName, State#serv_st.registrations)),
    NewClients=[X || X<-Clients, X/=ClientPID],
    NewState =#serv_st{nicks = State#serv_st.nicks, registrations = maps:put(ChatName, NewClients, State#serv_st.registrations), chatrooms = State#serv_st.chatrooms},
    ChatRoomPID=element(2,maps:find(ChatName,State#serv_st.chatrooms)),
    ChatRoomPID!{self(),Ref, unregister,ClientPID},
    ClientPID!{self(),Ref,ack_leave,ChatName},
    NewState.

%% executes new nickname protocol from server perspective
do_new_nick(State, Ref, ClientPID, NewNick) ->
    NicknameList = maps:values(State#serv_st.nicks),
    Bool=lists:any(fun(Id) -> lists:member(Id,NicknameList) end, [NewNick]),
    if
        Bool ->
            ClientPID!{self(),Ref,err_nick_used},
            NewState = State;
        true ->
            NewState = #serv_st{nicks = maps:put(ClientPID, NewNick, State#serv_st.nicks), registrations = State#serv_st.registrations, chatrooms = State#serv_st.chatrooms},
            Registers = maps:to_list(State#serv_st.registrations),
            ChatRoomName = [element(1,X) || X <- Registers, lists:member(ClientPID, element(2,X))],
            ChatRoomPID=[element(2, maps:find(X, State#serv_st.chatrooms)) || X<-ChatRoomName],
            lists:map(fun(X)->X!{self(), Ref, update_nick, ClientPID, NewNick} end, ChatRoomPID),
            ClientPID!{self(), Ref, ok_nick, NewNick}
    end,
    NewState.

%% executes client quit protocol from server perspective
do_client_quit(State, Ref, ClientPID) ->
    Registers=maps:to_list(State#serv_st.registrations),
    ChatRoomName=[element(1,X) || X <- Registers, lists:member(ClientPID, element(2,X))],
    ChatRoomPID=[element(2,maps:find(X,State#serv_st.chatrooms)) || X<-ChatRoomName],
    lists:map(fun(X)->X!{self(),Ref,unregister,ClientPID} end,ChatRoomPID),
    io:format("The value is: ~p.", [State#serv_st.registrations]),
    Newregistrations=foldl(fun(A,H)->maps:update_with(H,fun(Id)->lists:delete(ClientPID,Id) end,A) end,State#serv_st.registrations,ChatRoomName),
    io:format("The value is: ~p.", [Newregistrations]),
    NewState = #serv_st{nicks = maps:remove(ClientPID,State#serv_st.nicks), registrations = Newregistrations, chatrooms = State#serv_st.chatrooms},
    ClientPID!{self(),Ref,ack_quit},
    NewState.

%% preparation :(
foldl(_F,A,[]) ->
    A;
foldl(F,A,[H|T]) ->
     foldl(F,F(A,H),T).
