;3

;a) Write a function that inserts in a linear list a given atom A after the 2nd, 4th, 6th, ... element. 

#|
MathematcalModel:


insertEven(l elem c) = { elem if l=[] and c%2=0
                       { nil if l=[] and c%2=1
                       { l1UinsertEven(l2..ln elem c+1) if c%2=1
                       { l1UelemUinsertEven(l2..ln elem c+1) otherwise 

wrapper1(l elem) = insertEven(l elem 1)
 |#

(defun insertEven (l elem c)
    (cond
        ((and (= 0 (mod c 2)) (null l)) elem)
        ((and (= 1 (mod c 2)) (null l)) nil)
        ((= 1 (mod c 2)) (cons (car l) (insertEven (cdr l) elem (+ c 1))))
        (t (append (list (car l) elem) (inserteven (cdr l) elem (+ c 1))))
    )
)
(defun wrapper1 (l elem)
    (cond
        (t (inserteven l elem 1))
    )
)

;(print (wrapper1 '(1 2 3 4 5 6 7 8 9 10) 'x))

;b) Write a function to get from a given list the list of all atoms, on any 
;level, but reverse order. 
;Example:      (((A B) C) (D E)) ==> (E D C B A) 

#|
Mathematical model:
insertAfter(l)={ nil if l=[]
               { insertAfter(l2..ln)U l1 if l1 is an atom
               { insertAfter(l2..ln) U insertAfter(l1) otherwise
 |#

 (defun insertafter (l)
    (cond
        ((null l) nil)
        ((atom (car l)) (append (cdr l) (list (car l))))
        (t (append (insertafter (cdr l) ) (insertafter (car l))))
    )
 )

 ;(print (insertafter '(((A B) C) (D E))))

 ;c) Write a function that returns the greatest common divisor of all numbers in a nonlinear list. 

 #|
    gcd(a b) = { a if a=b
               { gcd(a-b b) if a>b
               { gcd(a b-a) otherwise
    gcdlist(l)= { 1 if l=[]
                { gcd(l1 gcdlist(l2..ln))  if l1 is atom
                { gcd(gcdlist(l1) gcdlist(l2..ln)) otherwise (if l1 is a list)
  |#

  (defun mygcd (a b)
    (cond
        ((= a b) a)
        ((> a b) (mygcd (- a b) b))
        (t (mygcd a (- b a)))
    )
  )

 (defun gcdlist (l)
  (cond
    ((null l) 1)
    ((atom (car l)) (mygcd (car l) (gcdlist (cdr l))))
    (t (mygcd (gcdlist (car l)) (gcdlist (cdr l))))
  )
)

;(print (gcdlist '((20 30 (40) 50) 60 (70 (80 (90)) 100))))

;d) Write a function that determines the number of occurrences of a given atom in a nonlinear list. 

#|
Mathematical model:
noofoccurences(l a c) = { c if l=[]
                        { noofoccurences(l1 a c) noofoccurence(l2..ln a c) if l1 list
                        { noofoccurences(l2..ln a c+1) if l1 = a
                        { noofoccurences(l2..ln a c) otherwise
|#

;d) Write a function that determines the number of occurrences of a given atom in a nonlinear list. 
(defun noofoccurences (l a c)
    (cond 
        ((null l) c)
        ((equal (car l) a) (noofoccurences (cdr l) a (+ c 1)))
        ((listp (car l))  (noofoccurences (car l) a c) (noofoccurences (cdr l) a c))
        (t (noofoccurences (cdr l) a c))
    )
)

(defun wrapper2 (l a)
    (cond
        (t (noofoccurences l a 0))
    )
)

;(print (wrapper2 '((1 8 3) 4 (5 6 7) 8 (9 (8) 11)) 8))
