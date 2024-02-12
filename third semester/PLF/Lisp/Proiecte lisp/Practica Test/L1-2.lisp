;1
;a) Write a function to return the product of two vectors. 

#|
Mathematical model:
                
dotProduct(a b) =  { 0 if a = []
                   { a1*b1+ dotProduct(a2..an,b2..bn) otherwise

 |#

(defun dotProduct (a b)
    (cond
        ((null a) 0)
        (t (+ ( * (car a) (car b)) (dotproduct (cdr a) (cdr b))))
    )
)

;(print (dotProduct '(1 2 3) '(4 5 6)))

;b) Write a function to return the depth of a list. Example: the depth of a linear list is 1. 

#|
Mathematical model:
 depthList(list counter) = { counter if list=[]
                              { maxi(depthList(l1 counter+1) depthList(l2..ln counter) if l1 = list
                              { depthList(l2..ln counter) otherwise

wrapper1(list) = depthList(list 1)
 |#

(defun maxi (a b)
    (cond
        ((< a b) b)
        (t a)
    )
)

 (defun depthList (list counter)
    (cond 
        ((null list) counter)
        ((listp (car list)) (maxi (depthList (car list) (+ counter 1)) (depthList (cdr list) counter)))
        (t (depthList (cdr list) counter))
    )
 )
 (defun wrapper1 (list)
    (cond
        (t (depthList list 1))
    )
 )

 ;(print (wrapper1 '(1 2 (1 (2 (3)) (4 (5 (6 (7))))))))

 ;c) Write a function to sort a linear list without keeping the double values. 

#|
Mathematical model:

inserare(list elem) = { list(elem)  if l = []
                      { elem U list if elem < l1
                      { list if elem = l1
                      { l1 U inserare(l2..ln elem) otherwise

sortare(list) = { nil if l=[]
                { inserare(sortare(l2...ln) elem) otherwise

 |#

 (defun inserare (l elem)
    (cond
        ((null l) (list elem ) )
        ( (= elem (car l)) l )
        ( (< elem (car l)) (cons elem l))
        (t (cons (car l) (inserare (cdr l) elem)))
    )
 )

 (defun sortare (l)
    (cond
        ((null l) nil)
        (t (inserare (sortare (cdr l)) (car l)))
    )
 )

 ;(print (sortare '(9 4 6 5 6 1 2 4 6 9 1 2)))

 ;d) Write a function to return the intersection of two sets. 

 #|
 intersection of two sets ce e in a si apare in b

noofoccurences(s elem c)={ c if s=[]
                         { noofoccurences(s2..sn elem c+1) if s1=elem
                         { noofoccurences(s2..sn elem c) if s1!=elem
intersection(A B) = { nil if A=[]
                    { a1Uintersction(a2..an B) if noofoccurences(B a1 0) = 1
                    { intersection(a2..an B) otherwise

  |#

(defun noofoccurences (s elem c)
    (cond
        ((null s) c)
        ((= (car s) elem) (noofoccurences (cdr s) elem (+ c 1)))
        (t (noofoccurences (cdr s) elem c))
    )
)

(defun intersectionofsets (a b)
    (cond
        ((null a) nil)
        ((= 1 (noofoccurences b (car a) 0)) (cons (car a) (intersectionofsets (cdr a) b)))
        (t (intersectionofsets (cdr a) b))
    )
)

;(print (intersectionofsets '(1 2 3 4 5 6 7) '(4 5 6 8 9 10 7)))