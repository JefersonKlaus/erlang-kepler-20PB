-module(kepler).
-export([start/0, loop/1, createMolecule/2]).
-import(molecule,[startMolecule/2]).

loop(N) ->
    receive
        stop ->
            io:format("Finish him ~n"),
            ok
    after 2000 ->
        io:format("Loop ~p | Hello Erlan!~n", [N]),
        ?MODULE:loop(N+1)
    end.


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

        

start() ->
    spawn(?MODULE, createMolecule, [2000, self()]).
    % spawn(?MODULE, loop, [1]).