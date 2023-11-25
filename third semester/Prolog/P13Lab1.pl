/*GCD in a list

         { A if A=B
gcd(A,B)={ gcd(A-B,B) if A>B
         { gcd(A,B-A) if A<B

gcd(A-inital number,B-initial number,R-result)
(i,i,o)

                 { 0 if n=0
gcd_list(l1..ln)={ l1 if n=1
                 { gcd(l1,l2)Ugcd_list(l3..ln) if n>=2
gcd_list(L-initial list,R-result number)
(i,o)

*/

gcd(A,0,A):-!.
gcd(0,B,B):-!.
gcd(A,A,A).
gcd(A,B,R):-
    A>B,
    NewA is A-B,
    gcd(NewA,B,R).
gcd(A,B,R):-
    A<B,
    NewB is B-A,
    gcd(A,NewB,R).

gcd_list([],0).
gcd_list([A],A).
gcd_list([H1,H2|T],R):-
    gcd(H1,H2,Result),
    gcd_list([Result|T],R).
