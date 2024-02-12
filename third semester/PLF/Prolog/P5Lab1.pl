/*
Write a predicate to compute the union of two sets.
b. Write a predicate to determine the set of all the pairs of elements in a list.
Eg.: L = [a b c d] => [[a b] [a c] [a d] [b c] [b d] [c d]].
*/

/*             { [] if [] []
concLists(A,B)={ a1U(a2..an,B) if n>=1
               { b1U(_,b2..bm) if n=0 and m>=1


union(L1,L2)=

*/
noApps([],_,0).
noApps([E|T],E,R):-
    noApps(T,E,NewR),
    R is NewR + 1.
noApps([H|T],E,R):-
    H \= E,
    noApps(T,E,R).



concLists([],[],[]).
concLists([H|T],L2,[H|R]):-
    concLists(T,L2,R).
concLists([],[H|T],[H|R]):-
    concLists([],T,R).


union(L,[],L).
union(L1,[H|T],[H|R]):-
    noApps(L1,H,Result),
    Result =:= 0,
    union(L1,T,R).
union(L1,[H|T],R):-
    noApps(L1,H,Result),
    Result =\= 0,
    union(L1,T,R).



