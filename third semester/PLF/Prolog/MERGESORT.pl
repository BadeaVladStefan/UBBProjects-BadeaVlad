split([],[],[]).
split([A],[A],[]).
split([H1,H2|T],[H1|R1],[H2|R2]):-
    split(T,R1,R2).

merge(A,[],A).
merge([],A,A).
merge([H1|T1],[H2|T2],[H1|R]):-
    H1 < H2,
    merge(T1,[H2|T2],R).
merge([H1|T1],[H2|T2],[H2|R]):-
    H1 > H2,
    merge([H1|T1],T2,R).
merge([H1|T1],[H2|T2],[H1|R]):-
    H1 =:= H2,
    merge(T1,[H2|T2],R).

mergeSort([A],[A]).
mergeSort([],[]).
mergeSort([H1,H2|T],R):-
    split([H1,H2|T],Left,Right),
    mergeSort(Left,ResLeft),
    mergeSort(Right,ResRight),
    merge(ResLeft,ResRight,R).
