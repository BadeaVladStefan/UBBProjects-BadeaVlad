;1)

;a) Write a function to return the n-th element of a list, or NIL if such an element does not exist. 

#|
MathematicalModel:
returnElement(l1..ln  index counter)= { nil if l=[]
                                       { l1 if index = counter 
                                       { returnElem(l2..ln index counter+1)
 |#

 (defun returnElem(l i c)
    (cond
    ((null l) nil)
    ((= i c) (car l))
    (t (returnElem (cdr l) i (+ c 1)))
    )
 )

(defun wrapper(l i)
    (cond
        (t (returnElem l i 0))
    )
)

;(print (wrapper '(1 2 3 4 5 (6 (9) 7) 8) 5))

;b) Write a function to check whether an atom E is a member of a list which is not necessarily linear. 

#|
MathematicalModel:
checkElem(list elem) = { false if l=[]
                       { true if l1 is an atom and l1 = elem
                       { checkElem(l1 elem) or checkElem(l2..ln elem) if l1 is a list
                       { checkElem(l2..ln elem) otherwise
 |#

 (defun checkElem(l e)
    (cond
        ((null l) nil)
        ( (and (atom (car l)) (equal (car l) e)) T)
        ( (listp (car l)) (or (checkElem (car l) e) (checkElem (cdr l) e)) )
        (t (checkElem (cdr l) e))
    )
 )

 ;(print (checkElem '(1 2 3 4 5 (6 (9) 7) 8) 8))

 #|
 c) Write a function to determine the list of all sublists of a given list, on any level. 
 A sublist is either the list itself, or any element that is a list, at any level.
 Example: (1 2 (3 (4 5) (6 7)) 8 (9 10)) => 5 sublists :
(  (1 2 (3 (4 5) (6 7)) 8 (9 10))    (3 (4 5) (6 7))     (4 5)   (6 7)   (9 10) ) 

MathematicalModel:
subLists(l) = { nil if l = []
              { l1 U sublists(l1)Usublists(l2..ln) if l1 is a list
              { sublists(l2..ln) otherwise

  |#

  (defun subLists(l)
    (cond
        ((null l) nil)
        ((listp (car l)) (cons (car l) (append (subLists (car l)) (subLists (cdr l)))))
        (t (subLists(cdr l)))
    )
  )

;(print (subLists '(1 2 (3 (4 5) (6 7)) 8 (9 10))))

;d) Write a function to transform a linear list into a set. 

#|
MathematicalModel:
ListToSet(list copyList)={ nil if l=[]
                         { l1 U ListToSet(l2..ln, copyList) if noOfOccurences(copyList,l1) = 1
                         { ListToSet(l2..ln, copyList) otherwise

noOfOccurences(list,elem,counter)={counter if l=[]
                                  {noOfOccurences(l2..ln,elem,counter + 1) if l1 = elem
                                  {noOfOccurences(l2...ln,elem,counter) otherwise
wrapper2(list) = ListToSet(list list)
                                  
 |#

(defun noofoccurences (list elem c)
    (cond 
        ((null list) c)
        ((equal (car list) elem) (noofoccurences (cdr list) elem (+ c 1)))
        (t (noofoccurences (cdr list) elem c))
    )
)

(defun ListToSet (list copyList)
    (cond
        ((null list) nil)
        ((equal 1 (noofoccurences list (car list) 0)) 
         (cons (car list) (ListToSet (cdr list) copyList)))
        (t (ListToSet (cdr list) copyList))
    )
)

(defun wrapper2 (list)
    (cond
        (t (ListToSet list list))
    )
)

(print (wrapper2 '(1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8)))
