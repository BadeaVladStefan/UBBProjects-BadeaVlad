/*a. Write a predicate to compute the intersection of two sets.
b. Write a predicate to create a list (m, ..., n) of all integer numbers from the interval [m, n]*/

/*
                     { false if n=0
isNumInSet(l1..ln,e)={ true if l1=e
                     { isNumInSet(l2..ln,e) otherwise

                         { [] if n=0
intersect(a1..an,b1..bm)={

*/

isNumInSet([H|_],H).
isNumInSet([H|T],E):-
    H \= E,
    isNumInSet(T,E).

intersect([],_,[]).
intersect([H|T],List,Result):-
    (isNumInSet(List,H) -> Result=[H|R]; Result=R ),
    intersect(T,List,R).

/*
                   { mUcreate_list(m,n,c+1) if c=m
create_list(m,n,c)={ cUcreate_list(m,n,c+1) if c<n
                   { nUcreate_list(m,n,c+1) if c=n
                   { [] if c>n
*/

create_list(_,N,C,[]):-
    C>N.
create_list(M,N,C,[C|R]):-
    C >= M,
    C =< N,
    NewC is C + 1,
    create_list(M,N,NewC,R).


wrapper(M,N,R):-create_list(M,N,M,R).


