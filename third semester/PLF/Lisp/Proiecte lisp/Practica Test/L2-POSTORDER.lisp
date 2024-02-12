; 15. Determine the list of nodes accesed in postorder in a tree of type (2).

#|
postorder(l) = { nil if l=[]
               { postorder(l2)Upostorder(l3)Ulist(l1)
 |#

 (defun postorder (l)
    (cond
        ((null l) nil)
        (t (append (postorder (cadr l)) (append (postorder (caddr l)) (list (car l)))))
    )
 )

  (print (postorder '(a (b (c) (d)) (h (i) (l(n) (m))))))