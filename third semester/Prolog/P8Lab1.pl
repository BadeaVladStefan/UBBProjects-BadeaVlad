/*
a. Write a predicate to determine if a list has even numbers of elements
without counting the elements from the list. */

/*
 *            { true n=0
count(l1..ln)={ false n=1
              { count(l3..ln) n>=2
*/

count([]).
count([_,_|T]):-
    count(T).

/*
 * b. Write a predicate to delete first occurrence of the minimum number from a list.
 *
 *          { A if A<B
 * min(A,B)={ B if A>=B
 *
 * min_list={l1 if n=1
 *          {min(l1,l2)Umin_list(l3..ln) if n>=2
*/


min(A, B, A) :-
    A < B.
min(A, B, B) :-
    A >= B.

mini_list([A], A).
mini_list([H|T], R) :-
    mini_list(T, NewR),
    min(H, NewR, R).

delete_first_occurrence([], _, _, []).
delete_first_occurrence([Value|T], Value, 0, T).
delete_first_occurrence([Value|T], Value, Counter, [Value|R]) :-
    Counter = 1,
    delete_first_occurrence(T, Value, 0, R).
delete_first_occurrence([H|T], Value, Counter, [H|R]) :-
    H \= Value,
    delete_first_occurrence(T, Value, Counter, R).

wrapper(L, R) :-
    mini_list(L, MinValue),
    Counter = 0,
    delete_first_occurrence(L, MinValue, Counter, R).


