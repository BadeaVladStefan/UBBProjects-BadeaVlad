/*
o lista => set?
*/

noApps([],_,0).
noApps([E|T],E,R):-
    noApps(T,E,NewR),
    R is NewR + 1.
noApps([H|T],E,R):-
    H \= E,
    noApps(T,E,R).

isSet([],_,1).
isSet([H|T],CopyList,1):-
    noApps(CopyList,H,Res),
    Res =:= 1,
    isSet(T,CopyList,1).
isSet([H|T],CopyList,1):-
    noApps(CopyList,H,Res),
    Res =\= 1,
    isSet(T,CopyList,0).
isSet([_|T],CopyList,0):-
    isSet(T,CopyList,0).

wrapper(L):-
    isSet(L,L,1).
