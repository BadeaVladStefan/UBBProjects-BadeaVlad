;4

;a) Write a function to return the sum of two vectors. 
#|
sumofvectors(a b)={ nil a=[]
                  { (a+b)Usumofvectors(a2..an,b2..bn)
 |#

 (defun sumofvectors (a b)
    (cond
        ((null a) nil)
        (t (cons (+ (car a) (car b)) (sumofvectors (cdr a) (cdr b))))
    )
 )

 ;(print (sumofvectors '(1 2 3) '(4 5 6)))

 ;b) Write a function to get from a given list the list of all atoms, on any
 ; level, but on the same order. 
 ;Example:      (((A B) C) (D E)) ==> (A B C D E) 

 #|
 Mathematical model:
 insertBefore(l)= { nil if l=[]
                  { l1UinsertBefore(l2..ln) if l1 is an atom
                  { insertBefore(l1)UinsertBefore(l2..ln) otherwise
  |#

  (defun insertbefore (l)
    (cond
        ((null l) nil)
        ((atom (car l)) (cons (car l) (insertbefore (cdr l))))
        (t (append (insertbefore (car l)) (insertbefore (cdr l))))
    )
  )
 ; (print (insertbefore '(((a b) c) (d e))))

 ;d) Write a list to return the maximum value of the numerical atoms from a list, at superficial level. 

#|
    Mathematical model:
    maxi(a b)=  { a if b is not a numerical atom
                { b if a is not a numerical atom
                {a if a>b
                {b otherwise

    maxlist(l)= {0 if l=[]
                {maxi(l1,maxlist(l2..ln)) if l1 is a numerical atom
                {maxlist(l2..ln) otherwise
 |#

    (defun maxi (a b)
        (cond
            ((not (numberp b)) a)
            ((not (numberp a)) b)
            ((> a b) a)
            (t b)
        )
    )

    (defun maxlist (l)
        (cond
            ((null l) nil)
            ((numberp (car l)) (maxi (car l) (maxlist (cdr l))))
            (t (maxlist (cdr l)))
        )
    )

    (print (maxlist '(1 10 (5 8) 20 (3 15)))) ; Should print 20

; c) Write a function that, with a list given as parameter, inverts only continuous sequences of atoms. 
 ; Example: (a b c (d (e f) g h i)) ==> (c b a (d (f e) i h g))

 ; mathematical model:
 ; invertCont(l1l2...ln, aux) = { aux, if n = 0
 ;                              { myappend(aux, myappend(list(invertCont(l1, nil), invertCont(l2...ln, nil)))), 
 ;                                          if l1 is a list
 ;                              { invertCont(l2...ln, myappend(list(l1), aux)), otherwise

 (defun invertCont (l aux)
    (cond
        ((null l) aux)
        ((listp (car l)) (append aux (append (list (invertCont (car l) nil)) (invertCont (cdr l) nil))))
        (t (invertCont (cdr l) (append (list (car l)) aux)))
    )
 )

 (print (invertCont '((a b c (d (e f) g h i))) nil))