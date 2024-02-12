
separateList([],[],[]).
separateList([H|T],[H|P],N):-
    H >= 0,
    separateList(T,P,N).
separateList([H|T],P,[H|N]):-
    H =< 0,
    separateList(T,P,N).


mini(A,B,A):-
    A < B.
mini(A,B,B):-
    A >= B.

miniList([],0).
miniList([A],A).
miniList([H1,H2|T],R):-
    mini(H1,H2,Mini),
    miniList([Mini|T],R).

wrapper(L,P,N):-
    separateList(L,P,N),
    miniList(P,MiniP),
    miniList(N,MiniN),
    write('Min negative: '),write(MiniN),nl,
    write('Min pozitive: '),write(MiniP),nl.
