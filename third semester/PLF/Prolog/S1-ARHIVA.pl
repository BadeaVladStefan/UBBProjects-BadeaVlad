/*
          { A A>B
maxi(A,B)={ B A=<B

              {0 n=0
maxList(l1..ln)={l1 n=1
              {maxi(l1,l2)UmaxList(l3..ln) if n>=2
*/

maxi(A,B,A):-
    A > B.
maxi(A,B,B):-
    A =< B.

maxiList([],0).
maxiList([A],A).
maxiList([H1,H2|T],Result):-
    maxi(H1,H2,Maxi),
    maxiList([Maxi|T],Result).

/*
                  {[] if n=0
doubleVal(l1..ln)={(l1*2)UdoubleVal(l2...ln)

*/

doubleVal([],[]).
doubleVal([H|T],[NewH|R]):-
    NewH is H * 2,
    doubleVal(T,R).

wrapper(L1,L2,R):-
    maxiList(L1,M1),
    maxiList(L2,M2),
    write('First max is '), write(M1),nl,
    write('Second max is '),write(M2),nl,
    doubleVal([M1,M2],R).
