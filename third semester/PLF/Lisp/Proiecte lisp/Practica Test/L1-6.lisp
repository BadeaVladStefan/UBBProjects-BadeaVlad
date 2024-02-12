;6

;a) Write a function to test whether a list is linear. 
#|
testlinear(l)= { T(true) if l=[]
               { nil(F) if l1 is a list
               { testlinear(l2..ln)
 |#

 (defun testlinear (l)
    (cond
        ((null l) T)
        ((listp (car l)) nil)
        (t (testlinear (cdr l)))
    )
 )
 ;(print (testlinear '(1 2 3 4 5 6 7 8 9 10)))
 ;(print (testlinear '(1 (2) 3)))

 ;b) Write a function to replace the first occurence of an element
 ; E in a given list with an other element O.

 #|
 Mathematical model:

 replaceapp(l e c)]= { nil if l=[]
                     { 'O' U replaceapp(l2..ln e c+1) if l1 = e and c=0
                     {  e U replaceapp(l2..ln e c+1) if l1 = e and c!=0
                     {  l1 U replaceapp(l2..ln e c) otherwise

wrapper(l e) = replaceapp(l e 0)         
  |#

(defun replaceapp (l e c)
    (cond
        ((null l) nil)
        ((and (= c 0) (= (car l) e)) (cons 'O (replaceapp (cdr l) e (+ c 1)) ))
        ( (and (not (= c 0)) (= (car l) e)) (cons (car l) (replaceapp (cdr l) e (+ c 1))))
        (t (cons (car l) (replaceapp (cdr l) e c)))
    )
)
(defun wrapper1 (l e)
    (cond
        (t (replaceapp l e 0))
    )
)
;(print (wrapper1 '(1 2 3 4 5 6 7 8 9 5) 5))
