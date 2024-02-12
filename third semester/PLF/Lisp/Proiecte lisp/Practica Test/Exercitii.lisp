;eliminate all appearances of the maximum value

#|
maxim(a b)={ a if b is not a number
           { b if a is not a number
           { a if a > b
           { b otherwise

maximlist(l)={ nil if l=[]
             { maxim(maxilist(l1), maximlist(l2...ln)) if l1 is a list
             { maxim(l1, maxilist(l2..ln)) otherwise  

removeelem(l e) = { nil if l=[] 
                  { removeelem(l1 e) U removeelem (l2..ln e) if l1 is a list
                  { removeelem(l2..ln e) if l1 = e
                  { l1Uremoveelem(l2...ln e)otherwise       
 |#

(defun maxim (a b)
    (cond
        ((not (numberp b)) a)
        ((not (numberp a)) b)
        ((> a b) a)
        (t b)
    )
)

(defun maximlist (l)
    (cond
        ((null l) nil)
        ((listp (car l)) (maxim (maximlist (car l)) (maximlist (cdr l)) ))
        (t (maxim (car l) (maximlist (cdr l) )))
    )
)

#|
removeelem(l e) = { nil if l=[] 
                  { removeelem(l1 e) U removeelem (l2..ln e) if l1 is a list
                  { removeelem(l2..ln e) if l1 = e
                  { l1Uremoveelem(l2...ln e)otherwise  
 |#

 (defun removeelem (l e)
    (cond
        ((null l) nil)
        ((listp (car l)) (append (removeelem (car l) e) (removeelem (cdr l) e)))
        ((= (car l) e) (removeelem (cdr l) e))
        (t (cons (car l) (removeelem (cdr l) e)))
    )
 )
#|
wrapper(l) = removeelem(l maxilist(l))
 |#

 (defun wrapper (l)
    (cond
        (t (removeelem l (maximlist l) ))
    )
 )
 (print (wrapper '((1 2 3 (4 5) 4 5) 10 10 (10 (2 3)) 5)))