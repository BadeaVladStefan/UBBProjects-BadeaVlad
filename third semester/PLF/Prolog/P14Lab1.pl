/*
a. Write a predicate to test equality of two sets without using the set difference.
b. Write a predicate to select the n-th element of a given list
*/

/*
A:
isElemOnPosEqual(l1..ln,pos,counter,e)=
      {isElemOnPosEqual(l2..ln,pos,counter+1,e) is counter<pos
      {true if isElemOnPosEqual(l1..ln,pos,counter,e) if counter=pos and
      l1 = e
(i,i,i,i)



*/


isElemOnPosEqual([_|T],Pos,Counter,R):-
    Counter<Pos,
    NewCounter is Counter+1,
    isElemOnPosEqual(T,Pos,NewCounter,R).
isElemOnPosEqual([E|_],Pos,Pos,E).

testPos(L,Pos,Elem):-isElemOnPosEqual(L,Pos,1,Elem).

equalLists([],[]).
equalLists([H|T1],[H|T2]):-
    equalLists(T1,T2).


/*
 * Write a predicate to select the n-th element of a given list.
*/




