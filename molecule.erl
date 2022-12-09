-module(molecule).
-export([startMolecule/1]).


startMolecule(MoleculeType) ->
    Time = random(10,30),
    io:format("Molecula (~p) precisa ~p segundos para adiquirir energia. ~n", [MoleculeType, integer_to_list(Time)]),
    time:sleeper(Time * 1000),
    io:format("Molecula (~p) precisa ~p segundos para adiquirir energia. ~n", [MoleculeType, integer_to_list(Time)]).
    

random(RandomMin, RandomMax) ->
    Result = round(rand:uniform(RandomMin - RandomMax) + RandomMin),
    Result.