/*
a. Write a predicate to transform a list in a set, considering the first occurrence.
Eg: [1,2,3,1,2] is transform in [1,2,3].
b. Write a predicate to decompose a list in a list respecting the following: [list of even numbers list of odd
numbers] and also return the number of even numbers and the numbers of odd numbers.
*/

/*
A:
                         {0 if n=0
noOfOccurences(l1..ln,e)={noOfOccurences(l2..ln) if n>=1 and l1!=e
                         {1+noOfOCcurences(l2..ln) if n>=1 and l1=e
noOfOCcurences(L-initial element,E-element that is searched,R-result)
flowmodel(i,i,o)

                  { [] if n=0
createSet(l1..ln)={ l1UcreateSet(l2..ln) if n>=1 and
                    noOfOccurences(l1..ln,l1)=1
                  { createSet(l2...ln) if n>=1 and
                    noOfOccurences(l1..ln,l1)>1
createSet(L-initial list,CopyList - copy of the List,R-ResultList)
(i,i,o)

wrapperSet(L,R)=createSet(L,L,R)
(i,o)
*/

noOfOccurences([],_,0).
noOfOccurences([E|T],E,R):-
    noOfOccurences(T,E,NewR),
    R is NewR+1.
noOfOccurences([H|T],E,R):-
    noOfOccurences(T,E,R),
    H\=E.


createSet([],_,[]).
createSet([H|T],CopyList,[H|R]):-
    noOfOccurences(CopyList,H,Result),
    Result=:=1,
    createSet(T,CopyList,R).
createSet([H|T],CopyList,R):-
    noOfOccurences(CopyList,H,Result),
    Result>1,
    createSet(T,CopyList,R).

wrapper(List,Result):-
    createSet(List,List,Result).


/*
 B:
                                { [] if n=0 and m=0
 concatenateList(a1..an,b1..bm)={ a1UconcatenateList(a2..an,b1..bm) if
                                  n>0 and m>0
                                { b1UconcatenateList(..,b2..bm) if m>0
 concatenateList(L1,L2,R)
 (i,i,o)

                                    { [],[] if n=0
 decomposeList(l1l2..ln,EvenL,OddL)={ l1UEvenL if n>=1 and l1%2=0
                                    { l1UOddL if n>=1 and l1%2=1
 decomposeList(L-initial list,EvenL-result,OddL-result)
 (i,i,i)/(i,o,o)

                             { 0,0 if n=0
 countParity(l1..ln,NoE,NoO)={ countParity(l2..ln,NoE+1,NoO) if n>=1
                               l1%2=0
                             { countParity(l2..ln,NoE,NoO+1) if n>=1
                               l1%2=1
 countParity(L-initial list,R1,R2)
 (i,i,i)/(i,o,o)
 */

concatenateList([],[],[]).
concatenateList([H|T],List2,[H|R]):-
    concatenateList(T,List2,R).
concatenateList([],[H|T],[H|R]):-
    concatenateList([],T,R).

decomposeList([],[],[]).
decomposeList([H|T],[H|R1],R2):-
    H mod 2 =:= 0,
    decomposeList(T,R1,R2).
decomposeList([H|T],R1,[H|R2]):-
    H mod 2 =:= 1,
    decomposeList(T,R1,R2).

countParity([],0,0).
countParity([H|T],R1,R2):-
    H mod 2 =:= 0,
    countParity(T,NewR1,R2),
    R1 is NewR1+1.
countParity([H|T],R1,R2):-
    H mod 2 =:= 1,
    countParity(T,R1,NewR2),
    R2 is NewR2+1.




testFunction(List,ResultList,NoE,NoO):-
    decomposeList(List,R1,R2),
    concatenateList(R1,R2,ResultList),
    countParity(ResultList,NoE,NoO).
