

rmEven([],[]).
rmEven([H|T],R):-
    number(H),
    Result is H mod 2,
    Result =:=0,
    rmEven(T,R).
rmEven([H|T],[H|R]):-
    (atom(H);number(H),Result is H mod 2, Result =\= 0),
    rmEven(T,R).

getNumbers([],[]).
getNumbers([H|T],[H|R]):-
    number(H),
    getNumbers(T,R).
getNumbers([H|T],R):-
    atom(H),
    getNumbers(T,R).

doubleNumbers([],[]).
doubleNumbers([H|T],[H,H|R]):-
    number(H),
    doubleNumbers(T,R).
doubleNumbers([H|T],[H|R]):-
    atom(H),
    doubleNumbers(T,R).

gcd(A,A,A).
gcd(A,B,R):-
    A > B,
    NewA is A - B,
    gcd(NewA,B,R).
gcd(A,B,R):-
    A < B,
    NewB is B - A,
    gcd(A,NewB,R).

gcdList([],1).
gcdList([A],A).
gcdList([H1,H2|T],R):-
    gcd(H1,H2,Result),
    gcdList([Result|T],R).


multiplyList([],1).
multiplyList([H|T],R):-
    multiplyList(T,NewR),
    R is NewR * H.



wrapper(L,R):-
    rmEven(L,L1),
    doubleNumbers(L1,R),
    getNumbers(L1,ListNumbers),
    multiplyList(ListNumbers,Mul),
    gcdList(ListNumbers,GCD),
    LCM is Mul / GCD,
    write('Lcm is: '), write(LCM), nl.
