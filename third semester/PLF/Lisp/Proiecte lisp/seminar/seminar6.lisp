;compute the product of all numerical elements in a nonlinear list

#|

product(x) = { 1 if x non numerical atom
             { x if x is a number
                n
             { PI(*) product(xi) if x is (x1x2...xn) list
               i=1
 |#

 (defun product(x)
    (cond
        ((numberp x) x)
        ((atom x) 1)
        (t (apply '* (mapcar #'product x)))
    )  
 )
 (print (product '(1 2 3 4 5)))