-module(molecule).
-export([startMolecule/2]).


random(RandomMin, RandomMax) ->
    Result = round(rand:uniform(RandomMax - RandomMin) + RandomMin),
    Result.

startMolecule(MoleculeType, PidKepler) ->
    Time = random(10,30),
    io:format("Molecula (~p) precisa ~p segundos para adiquirir energia. ~n", [MoleculeType, integer_to_list(Time)]),
    
    timer:sleep(Time * 1000),
    
    io:format("Molecula (~p) pronta. ~n", [MoleculeType]),
    PidKepler ! {MoleculeType}.