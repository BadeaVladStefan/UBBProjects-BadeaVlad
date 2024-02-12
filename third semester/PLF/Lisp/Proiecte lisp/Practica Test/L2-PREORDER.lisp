; 12. Determine the list of nodes accesed in preorder in a tree of type (2). 
#|
preorder(l)= { nil if l=[]
             { list(l1)Upreorder(l2)Upreorder(l3)
 |#

 (defun preorder (l)
    (cond
        ((null l) nil)
        (t (append (list (car l)) (append (preorder (cadr l)) (preorder (caddr l)))))
    )
 )
 (print (preorder '(a (b (c) (d)) (h (i) (l(n) (m))))))