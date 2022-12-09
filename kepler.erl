-module(kepler).
-export([start/1, loop/1, createMolecule/2]).
-import(molecule,[startMolecule/2]).

loop(State) ->
    receive
        {Type} ->
            io:format("Molecula (~p).~n", [Type]),

            Increment = fun(X) -> X + 1 end, 
            NewState = maps:update_with(Type, Increment, 1, State),

            io:format("~p~n", [maps:to_list(NewState)]),

            CanCreate = canCreateParticle(NewState),

            if
                CanCreate == true ->
                    io:format("PARTICULAR DE AGUA CRIADA.~n"),

                    DecrementH = fun(H) -> H - 2 end,
                    DecrementO = fun(O) -> O - 1 end,
                    Contador = fun(C) -> C + 1 end,
                    NewMapH = maps:update_with("H", DecrementH, NewState),
                    NewMapO = maps:update_with("O", DecrementO, NewMapH),
                    NewMapContador = maps:update_with("PARTICULAS FORMADAS", Contador, 1, NewMapO),

                    io:format("~p~n", [maps:to_list(NewMapContador)]),
                    
                    loop(NewMapContador);
                true ->
                    loop(NewState)
            end
    end.

canCreateParticle(Map) ->
    Length = length(maps:keys(Map)),

    if
        Length >= 2 ->
            HydrogenNumber = maps:get("H", Map),
            OxygenNumber = maps:get("O", Map),

            if
                (HydrogenNumber >= 2) and (OxygenNumber >= 1) ->
                    CanCreate = true;
                true ->
                    CanCreate = false
            end;
        true ->
            CanCreate = false
    end,
    CanCreate.

createMolecule(IntervaleToNew, PidKepler) ->
    MoleculeType = round(rand:uniform(2)),

    if 
        MoleculeType == 1 ->
            spawn(molecule, startMolecule, ["H", PidKepler]);
        MoleculeType == 2 ->
            spawn(molecule, startMolecule, ["O", PidKepler])
    end,

    timer:sleep(IntervaleToNew),
    createMolecule(IntervaleToNew, PidKepler).

        

start(IntervaleToNew) ->
    spawn(?MODULE, createMolecule, [IntervaleToNew, self()]),
    loop(maps:new()).
    % spawn(?MODULE, loop, [1]).