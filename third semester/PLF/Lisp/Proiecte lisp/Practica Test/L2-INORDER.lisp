;Return the list of nodes of a tree of type (2) accessed inorder. 

; (car l) - the first element of the list is the root of the tree
; (cadr l) - the second element of the list, at superficial level, is the left subtree
; (caddr l) - the third element of the list, at the superficial level, is the right subtree

#|
inorder(l1l2l3)={ nil if l=[]
                { inorder(l2)Ulist(l1)Uinorder(l3) otherwise

    
 |#

(defun inorder(l)
  (cond
    ((null l) nil)
    (t (append (inorder (cadr l)) (append (list (car l)) (inorder (caddr l)))))
  )
)



(print (inorder '(a (b (c) (d)) (h (i) (l(n) (m))))))