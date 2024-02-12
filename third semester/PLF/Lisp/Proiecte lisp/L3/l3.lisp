;Write a function to check if an atom is member of a list (the list is non-linear)

#|
MathematicalModel:
                                { True(T) ,if l = elem and l is an atom                              
checkExistence(list, element) = { false(NIL) ,if l != elem and l is an atom
                                { checkExistence(l1, elem) or checkExistence(l2, elem) or ... or checkExistence(ln, elem) otherwise
 |#

 (defun checkExistence (list element)
    (cond
        ((and (atom list) (eq list element)) t)
        ((atom list) nil)
        (t (some #(mapcar #'(lambda (x) (checkExistence x element)) list)))
    )
 )
 
(print (checkExistence '(1 (2) (3 (4)) 5) 4))
(print (checkExistence '(1 (2) (3 (4)) 5) 6))
