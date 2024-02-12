/*
a. Insert an element on the position n in a list.
b. Define a predicate to determine the greatest common divisor of all numbers from a list.*/

/*
A:
                        { [] n=0
                        { l1UElemUinsert(l2..ln) if n>=1 and p=1
insert(l1..ln,pos,elem)={ l1Uinsert(l2..ln,pos-1,elem) if n>=1 and p!=1
*/

insert([],_,_,[]).
insert([_|T],Pos,Elem,[Elem|R]):-
    Pos =:= 1,
    NewPos is Pos - 1,
    insert(T,NewPos,Elem,R).
insert([H|T],Pos,Elem,[H|R]):-
    Pos =\= 1,
    NewPos is Pos - 1,
    insert(T,NewPos,Elem,R).
