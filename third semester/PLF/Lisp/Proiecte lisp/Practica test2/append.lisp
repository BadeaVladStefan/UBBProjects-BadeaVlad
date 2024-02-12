#|
myappend(a b) =   { b if a=[]
                  { a1 U myappend(a2...an, b) otherwise
 |#

 (defun myappend (a b)
    (cond
        ((null a) b)
        (t (cons (car a) (myappend (cdr a) b)))
    )
)

(print (myappend '(1 (2 3) 4) '(1 (2 (3) 4) 5)))