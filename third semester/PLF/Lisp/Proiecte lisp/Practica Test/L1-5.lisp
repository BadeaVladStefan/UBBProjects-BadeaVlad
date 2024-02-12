;5

;a) Write twice the n-th element of a linear list. Example: for (10 20 30 40 50) and n=3 will produce (10 20 30 30 40 50). 

#|
Mathematical model: 
doubleval(l index)={ nil if l=[]
                   { l1Ul1Udoubleval(l2..ln index-1) if index = 1
                   { l1Udoubleval(l2..ln index-1) otherwise
 |#

(defun doubleval (l index)
    (cond
        ((null l) nil)
        ((= index 1) (append (list (car l) (car l)) (doubleval (cdr l) (- index 1))))
        (t (cons (car l) (doubleval (cdr l) (- index 1))))
    )
)
;(print (doubleval '(10 20 30 40 50) 5))

;b) Write a function to return an association list with the two lists given as parameters.
;Example: (A B C) (X Y Z) --> ((A.X) (B.Y) (C.Z)). 

#|
assList(a b) ={ nil if a=[]
              { list(a1 b1) U assList(a2..an,b2..bn) otherwise
 |#

(defun asslist (a b)
  (cond
    ((null a) nil)
    (t (append (list (cons (car a) (car b))) (asslist (cdr a) (cdr b))))
  )
)

;(print (asslist '(A B C) '(X Y Z)))

;c) Write a function to determine the number of all sublists of a given list, on any level.       
;A sublist is either the list itself, or any element that is a list, at any level. Example:       
;(1 2 (3 (4 5) (6 7)) 8 (9 10)) => 5 lists:  (list itself, (3 ...), (4 5), (6 7), (9 10)). 

#|
Mathematical model:
sublists(l) ={ 1 if l=[]
             { sublists(l1) + sublists(l2..ln) if l1 - list
             { sublists(l2..ln) otherwise
 |#

(defun sublists (l)
  (cond
    ((null l) 1)
    ((listp (car l)) (+ (sublists (cdr l)) (sublists (car l))))
    (t (sublists (cdr l)))
  )
)

;(print (sublists '(1 2 (3 (4 5) (6 7)) 8 (9 10))))

;d) Write a function to return the number of all numerical atoms in a list at superficial level. 

#|
Mathematical model:
count(l) = {0 if l=[]
           { 1+ count(l2...ln) if l1 is a number
           { count(l2..ln) otherwise
 |#

(defun countNumbers (l)
    (cond
        ((null l) 0)
        ((numberp (car l)) (+ 1 (countNumbers (cdr l))))
        (T (countNumbers (cdr l)))
    )
)

;(print (countNumbers '(1 2 (3 (4 5) (6 7)) 8 (9 10))))