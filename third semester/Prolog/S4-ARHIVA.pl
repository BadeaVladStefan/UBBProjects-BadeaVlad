
deleteList([],[]).
deleteList([H|T],[H|R]):-
    number(H),
    Res is H mod 2,
    Res =:= 0,
    deleteList(T,R).
deleteList([H|T],R):-
    (atom(H);number(H), Res is H mod 2, Res =\= 0),
    deleteList(T,R).

gcd(A,A,A).
gcd(A,B,R):-
    NewA is A - B,
    A > B,
    gcd(NewA,B,R).
gcd(A,B,R):-
    NewB is B - A,
    A < B,
    gcd(A,NewB,R).

gcdList([],1).
gcdList([A],A).
gcdList([H1,H2|T],R):-
    gcd(H1,H2,Res),
    gcdList([Res|T],R).

doubleList([],[]).
doubleList([H|T],[H,H|R]):-
    doubleList(T,R).

wrapper(L,R1,R2):-
    deleteList(L,R1),
    gcdList(R1,GCD),
    write('GCD is:'),write(GCD),nl,
    doubleList(R1,R2).

