/*DOAR CERINTA DE 5*/

rmElem([],_,[]).
rmElem([H|T],E,[H|R]):-
    H \= E,
    rmElem(T,E,R).
rmElem([E|T],E,R):-
    rmElem(T,E,R).
