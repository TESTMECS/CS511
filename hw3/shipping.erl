-module(shipping).
-compile(export_all).
-include_lib("./shipping.hrl").
-include_lib("eunit/include/eunit.hrl").

get_ship(Shipping_State, Ship_ID) ->
    Result = lists:keyfind(Ship_ID, #ship.id, Shipping_State#shipping_state.ships),
    case Result of
        false -> throw(error);
        Ship -> Ship 
    end.

get_container(Shipping_State, Container_ID) ->
    Result = lists:keyfind(Container_ID, #container.id, Shipping_State#shipping_state.containers),
    case Result of
        false -> throw(error);
        Container -> Container 
    end.

get_port(Shipping_State, Port_ID) ->
    Result = lists:keyfind(Port_ID, #port.id, Shipping_State#shipping_state.ports),
    case Result of
        false -> throw(error);
        Port -> Port 
    end.

get_occupied_docks(Shipping_State, Port_ID) ->
    Locations = Shipping_State#shipping_state.ship_locations,
    Docks = lists:filter(
        fun({Port, _, _}) -> 
            Port == Port_ID end, 
            Locations
        ),
    case Docks of
        [] -> throw(error);
        DocksList -> [Dock || {_, Dock, _} <- DocksList]
    end.

get_ship_location(Shipping_State, Ship_ID) ->
    Result = lists:keyfind(Ship_ID, 3, Shipping_State#shipping_state.ship_locations),
    case Result of
        {Port_id, Dock_id, _} -> {Port_id, Dock_id};
        false -> throw(error)
    end.

get_container_weight(Shipping_State, Container_IDs) -> 
    case Container_IDs of
        [] -> 0;
        [_|_] ->
            lists:foldl(
                fun(ID, Weight) ->
                    case get_container(Shipping_State, ID) of
                        #container{weight = W} -> W + Weight;
                        false -> throw(error)
                    end
                end, 
                0, 
                Container_IDs
            );
        _ -> throw(error)
    end.

get_ship_weight(Shipping_State, Ship_ID) ->
    Inventory = Shipping_State#shipping_state.ship_inventory,
    case get_ship(Shipping_State, Ship_ID) of
        error -> throw(error);
        _ -> get_container_weight(Shipping_State, maps:get(Ship_ID, Inventory))
    end.

% helper function that removes containers from port_inventory
remove_containers_from_port(Shipping_State, Container_IDs) ->
    Port_Inventory = Shipping_State#shipping_state.port_inventory, 
    Updated_Port_Inventory = maps:fold(
        fun(Port_ID, Containers, Acc) ->
            New_Containers = lists:subtract(Containers, Container_IDs),
            maps:put(Port_ID, New_Containers, Acc)
        end,
        maps:from_list([]),
        Port_Inventory
    ),
    Updated_Port_Inventory.
load_ship(Shipping_State, Ship_ID, Container_IDs) ->
    case maps:find(Ship_ID, Shipping_State#shipping_state.ship_inventory) of
        {ok, Existing_Containers} ->
            New_Containers = lists:append(Existing_Containers, Container_IDs),
            New_Inventory = maps:put(Ship_ID, New_Containers, Shipping_State#shipping_state.ship_inventory), 
            Updated_Shipping_State = Shipping_State#shipping_state{ship_inventory = New_Inventory},
            Updated_Port_Inventory = remove_containers_from_port(Updated_Shipping_State, Container_IDs),
            print_state(Updated_Shipping_State#shipping_state{port_inventory = Updated_Port_Inventory});
        error ->
            throw({error, {ship_inventory_not_found, Ship_ID}})
    end.

unload_ship_all(Shipping_State, Ship_ID) ->
    case maps:find(Ship_ID, Shipping_State#shipping_state.ship_inventory) of
        {ok, Containers} ->
            
            New_Inventory = maps:remove(Ship_ID, Shipping_State#shipping_state.ship_inventory), 
            Updated_Shipping_State = Shipping_State#shipping_state{ship_inventory = New_Inventory}, 
            {Port_ID, _Dock_ID} = get_ship_location(Shipping_State, Ship_ID),  
            
            Updated_Port_Inventory = add_containers_to_specific_port(Updated_Shipping_State, Port_ID, Containers), 

            print_state(Updated_Shipping_State#shipping_state{port_inventory = Updated_Port_Inventory});
        error ->
            throw(error)
    end.

% Helper function to add containers back to the specific port inventory
add_containers_to_specific_port(Shipping_State, Port_ID, Container_IDs) ->
    Port_Inventory = Shipping_State#shipping_state.port_inventory,
    Updated_Port_Inventory = case maps:find(Port_ID, Port_Inventory) of
        {ok, Existing_Containers} -> 
            New_Containers = lists:append(Existing_Containers, Container_IDs),
            maps:put(Port_ID, New_Containers, Port_Inventory);
        error ->
            throw(error)
    end,
    Updated_Port_Inventory.

unload_ship(Shipping_State, Ship_ID, Container_IDs) ->
    case maps:find(Ship_ID, Shipping_State#shipping_state.ship_inventory) of
        {ok, Existing_Containers} ->
            
            New_Containers = lists:subtract(Existing_Containers, Container_IDs),
            New_Inventory = maps:put(Ship_ID, New_Containers, Shipping_State#shipping_state.ship_inventory),
            Updated_Shipping_State = Shipping_State#shipping_state{ship_inventory = New_Inventory},
            {Port_ID, _Dock_ID} = get_ship_location(Updated_Shipping_State, Ship_ID),
            
            Updated_Port_Inventory = add_containers_to_specific_port(Updated_Shipping_State, Port_ID, Container_IDs),

            print_state(Updated_Shipping_State#shipping_state{port_inventory = Updated_Port_Inventory});
        error ->
            throw(error)
    end.

set_sail(Shipping_State, Ship_ID, {New_Port_ID, New_Dock}) ->
    {Current_Port_ID, _} = get_ship_location(Shipping_State, Ship_ID),
    if Current_Port_ID == New_Port_ID -> 
        throw({error, ship_already_at_destination});
    true ->
        DocksTaken = get_occupied_docks(Shipping_State, New_Port_ID),
        case lists:member(New_Dock, DocksTaken) of
            true -> throw({error, dock_occupied});
            false ->    
                New_Ship_Locations = lists:keyreplace(Ship_ID, 3, Shipping_State#shipping_state.ship_locations, {New_Port_ID, New_Dock, Ship_ID}),
                Updated_Shipping_State = Shipping_State#shipping_state{ship_locations = New_Ship_Locations},

                print_state(Updated_Shipping_State)
        end
    end.

%% Determines whether all of the elements of Sub_List are also elements of Target_List
%% @returns true is all elements of Sub_List are members of Target_List; false otherwise
is_sublist(Target_List, Sub_List) ->
    lists:all(fun (Elem) -> lists:member(Elem, Target_List) end, Sub_List).

%% Prints out the current shipping state in a more friendly format
print_state(Shipping_State) ->
    io:format("--Ships--~n"),
    _ = print_ships(Shipping_State#shipping_state.ships, Shipping_State#shipping_state.ship_locations, Shipping_State#shipping_state.ship_inventory, Shipping_State#shipping_state.ports),
    io:format("--Ports--~n"),
    _ = print_ports(Shipping_State#shipping_state.ports, Shipping_State#shipping_state.port_inventory).

%% helper function for print_ships
get_port_helper([], _Port_ID) -> error;
get_port_helper([ Port = #port{id = Port_ID} | _ ], Port_ID) -> Port;
get_port_helper( [_ | Other_Ports ], Port_ID) -> get_port_helper(Other_Ports, Port_ID).

print_ships(Ships, Locations, Inventory, Ports) ->
    case Ships of
        [] ->
            ok;
        [Ship | Other_Ships] ->
            {Port_ID, Dock_ID, _} = lists:keyfind(Ship#ship.id, 3, Locations),
            Port = get_port_helper(Ports, Port_ID),
            {ok, Ship_Inventory} = maps:find(Ship#ship.id, Inventory),
            io:format("Name: ~s(#~w)    Location: Port ~s, Dock ~s    Inventory: ~w~n", [Ship#ship.name, Ship#ship.id, Port#port.name, Dock_ID, Ship_Inventory]),
            print_ships(Other_Ships, Locations, Inventory, Ports)
    end.

print_containers(Containers) ->
    io:format("~w~n", [Containers]).

print_ports(Ports, Inventory) ->
    case Ports of
        [] ->
            ok;
        [Port | Other_Ports] ->
            {ok, Port_Inventory} = maps:find(Port#port.id, Inventory),
            io:format("Name: ~s(#~w)    Docks: ~w    Inventory: ~w~n", [Port#port.name, Port#port.id, Port#port.docks, Port_Inventory]),
            print_ports(Other_Ports, Inventory)
    end.
%% This functions sets up an initial state for this shipping simulation. You can add, remove, or modidfy any of this content. This is provided to you to save some time.
%% @returns {ok, shipping_state} where shipping_state is a shipping_state record with all the initial content.
shipco() ->
    Ships = [#ship{id=1,name="Santa Maria",container_cap=20},
              #ship{id=2,name="Nina",container_cap=20},
              #ship{id=3,name="Pinta",container_cap=20},
              #ship{id=4,name="SS Minnow",container_cap=20},
              #ship{id=5,name="Sir Leaks-A-Lot",container_cap=20}
             ],
    Containers = [
                  #container{id=1,weight=200},
                  #container{id=2,weight=215},
                  #container{id=3,weight=131},
                  #container{id=4,weight=62},
                  #container{id=5,weight=112},
                  #container{id=6,weight=217},
                  #container{id=7,weight=61},
                  #container{id=8,weight=99},
                  #container{id=9,weight=82},
                  #container{id=10,weight=185},
                  #container{id=11,weight=282},
                  #container{id=12,weight=312},
                  #container{id=13,weight=283},
                  #container{id=14,weight=331},
                  #container{id=15,weight=136},
                  #container{id=16,weight=200},
                  #container{id=17,weight=215},
                  #container{id=18,weight=131},
                  #container{id=19,weight=62},
                  #container{id=20,weight=112},
                  #container{id=21,weight=217},
                  #container{id=22,weight=61},
                  #container{id=23,weight=99},
                  #container{id=24,weight=82},
                  #container{id=25,weight=185},
                  #container{id=26,weight=282},
                  #container{id=27,weight=312},
                  #container{id=28,weight=283},
                  #container{id=29,weight=331},
                  #container{id=30,weight=136}
                 ],
    Ports = [
             #port{
                id=1,
                name="New York",
                docks=['A','B','C','D'],
                container_cap=200
               },
             #port{
                id=2,
                name="San Francisco",
                docks=['A','B','C','D'],
                container_cap=200
               },
             #port{
                id=3,
                name="Miami",
                docks=['A','B','C','D'],
                container_cap=200
               }
            ],
    %% {port, dock, ship}
    Locations = [
                 {1,'B',1},
                 {1, 'A', 3},
                 {3, 'C', 2},
                 {2, 'D', 4},
                 {2, 'B', 5}
                ],
    Ship_Inventory = #{
      1=>[14,15,9,2,6],
      2=>[1,3,4,13],
      3=>[],
      4=>[2,8,11,7],
      5=>[5,10,12]},
    Port_Inventory = #{
      1=>[16,17,18,19,20],
      2=>[21,22,23,24,25],
      3=>[26,27,28,29,30]
     },
    #shipping_state{ships = Ships, containers = Containers, ports = Ports, ship_locations = Locations, ship_inventory = Ship_Inventory, port_inventory = Port_Inventory}.