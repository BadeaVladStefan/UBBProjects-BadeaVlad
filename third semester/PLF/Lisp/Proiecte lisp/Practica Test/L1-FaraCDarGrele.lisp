;2-c) Write a function to sort a linear list without keeping the double values. 
#|
Mathematical Model:
inserare(L elem) = { {elem} if L = []
                    { {elem} U L if elem < l1
                    { l1 U inserare(l2...ln elem) if elem > L1
                    { L if elem = L1
sortare(L) = { [] if L = []
              { inserare(sortare(l2...ln)) if L1 is not in L2...Ln
              { sortare(l2...ln) if L1 is in L2...Ln
 |#

 (defun inserare (l elem)
    (cond
        ((null l) (list elem))
        ((< elem (car l)) (cons elem l))
        ((> elem (car l)) (cons (car l) (inserare (cdr l) elem)))
        (t l)
    )
 )
 (defun sortare (l)
    (cond
        ((null l) nil)
        ((null (cdr l)) l)
        ((null (member (car l) (cdr l))) (inserare (sortare (cdr l)) (car l)))
        (t (sortare (cdr l)))
    )
 )
 ;(print (sortare '(1 3 2 6 7 2 1 10 5 3 2 1)))

 ;d) Write a function to return the intersection of two sets. 
 #|
    Mathematical Model:
    intersecare(L1 L2) = { [] if L1 = [] or L2 = []
                          { L1 if L2 = []
                          { L2 if L1 = []
                          { L1 U intersecare(l2...ln L2) if l1 is in L2
                          { intersecare(l2...ln L2) if l1 is not in L2
  |#

    (defun intersecare (l1 l2)
        (cond
            ((null l1) nil)
            ((null l2) nil)
            ((member (car l1) l2) (cons (car l1) (intersecare (cdr l1) l2)))
            (t (intersecare (cdr l1) l2))
        )
    )

    (print (intersecare '(1 2 3 4 5 6 7 8 9) '(7 8 9 10 11 12 13 14 15)))

    ;c) Write a function that returns the greatest common divisor of all numbers in a nonlinear list. 
    #|
    Mathematical Model:
    cmmdc(a b) = { a if b = 0
                  { cmmdc(b a mod b) if b != 0
    cmmdclist(L) = { 0 if L = []
                    { cmmdc(l1 cmmdclist(l2...ln)) if l1 atom
                    { cmmdc(cmmdclist(l1) cmmdclist(l2...ln)) if l1 list
    |#

    (defun cmmdc (a b)
        (cond
            ((= b 0) a)
            (t (cmmdc b (mod a b)))
        )
    )
    (defun cmmdclist (l)
        (cond
            ((null l) 0)
            ((atom (car l)) (cmmdc (car l) (cmmdclist (cdr l))))
            (t (cmmdc (cmmdclist (car l)) (cmmdclist (cdr l))))
        )
    )
    (print (cmmdclist '(100 (75 50 (300)))))

;a) Write a function to return the difference of two sets. 

#|
    Mathematical Model:
    diferenta(L1 L2) = { [] if L1 = [] or L2 = []
                        { L1 if L2 = []
                        { L2 if L1 = []
                        { diferenta(l2...ln L2) if l1 is in L2
                        { l1 U diferenta(l2...ln L2) if l1 is not in L2
|#
    
        (defun diferenta (l1 l2)
            (cond
                ((null l1) nil)
                ((null l2) l1)
                ((member (car l1) l2) (diferenta (cdr l1) l2))
                (t (cons (car l1) (diferenta (cdr l1) l2)))
            )
        )
        (print (diferenta '(1 2 3 4 5 6 7 8 9) '(7 8 9 10 11 12 13 14 15)))


;b) Write a function to test if a linear list of numbers has a "mountain" aspect (a list has a "mountain" aspect if the items increase to a certain point and then decreases.       
; Eg. (10 18 29 17 11 10). The list must have at least 3 atoms to fullfil this criteria. 

#|
    Mathematical Model:
    munte(L flag) = { false if L = []
                        { true if flag = 1
                        { munte(l2...ln 1) if l1 < l2 and flag = 0
                        { munte(l2...ln 0) if l1 > l2 and flag = 1
                        { false if l1 < l2 and flag = 1
                        { false if l1 > l2 and flag = 0
                
 |#

    (defun munte (l flag)
        (cond
            ((null l) nil)
            ((= flag 1) t)
            ((< (car l) (cadr l)) (munte (cdr l) 1))
            ((> (car l) (cadr l)) (munte (cdr l) 0))
            (t nil)
        )
    )
    (print (munte '(1 2 3 4 7 6 7 8 9) 0))

;c) Remove all occurrences of a maximum numerical element from a nonlinear list. 

#|
maxim(a b) = { a if b is not a number
             { b if a is not a number
             { a if a > b
             { b otherwise
maximList(l) = { nil if l=[]
               { maxim(l1 maximList(l2..ln)) if l1 is an atom
               { maxim(maximList(l1) maximList(l2...ln)) otherwise

removeElem(l elem) = { = [] if l = []
                     { removeElem(l2...ln elem) if l1 = elem
                     { removeElem(l1 elem) U removeElem(l2...ln elem) if l1 is a list
                     { l1 U removeElem(l2...ln elem) if l1 is an atom and l1 != elem
                     { l1 U removeElem(l2...ln elem) otherwise

wrapper(l) = removeElem(l maximList(l))
 |#

(defun maxim (a b)
    (cond
        ((not (numberp a)) b)
        ((not (numberp b)) a)
        ((> a b) a)
        (t b)
    )
)
(defun maximList (l)
    (cond
        ((null l) nil)
        ((atom (car l)) (maxim (car l) (maximList (cdr l))))
        (t (maxim (maximList (car l)) (maximList (cdr l))))
    )
)

(print (maximList '(1 2 3 (4 (15)) 5 (3 4 (5)))))

(defun removeElem (l elem)
    (cond
        ((null l) nil)
        ((equal (car l) elem) (removeElem (cdr l) elem))
        ((atom (car l)) (cons (car l) (removeElem (cdr l) elem)))
        (t (cons (removeElem (car l) elem) (removeElem (cdr l) elem)))
    )
)

(defun wrapper (l)
    (removeElem l (maximList l))
)
(print (wrapper '(1 2 3 (4 (15)) 5 (3 4 (5)))))


 

    