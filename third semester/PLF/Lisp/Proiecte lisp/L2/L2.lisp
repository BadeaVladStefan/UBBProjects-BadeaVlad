#|
A binary tree is memorised in the following two ways:
(node no-subtrees list-subtree-1 list-subtree-2 ...) (1)
(node (list-subtree-1) (list-subtree-2) ...) (2)

As an example, the tree
  A
 / \
 B  C
   / \
  D   E

is represented as follows:
(A 2 B 0 C 2 D 0 E 0) (1)
(A (B) (C (D) (E))) (2)

12. Determine the list of nodes accesed in preorder in a tree of type (2).
 |#

#|
Mathematical model:

                                           { a1 U myAppend(a2..an,b1b2...bm,c1c2..ck) if a is not null
myAppend(a1a2..an, b1b2..bm,c1c2..ck) =    { b1 U myAppend(a1a2..an,b2..bm,c1c2..ck) if a is null and b is not null
                                           { c1 U myAppend(a1a2..an,b1b2..bm,c2..ck) if a and b are null and c is not null
                                           { nil if a,b and c are null


Mathematical model:
                   { nil if l1 is null
preorder(l1l2..ln)={ list(l1) U preorder(l2) U preorder(l3) otherwise (l1 is an internal node - is a list)

; (car l) - the first element of the list is the root of the tree
; (cadr l) - the second element of the list, at superficial level, is the left subtree
; (caddr l) - the third element of the list, at the superficial level, is the right subtree                    
 |#

(defun myAppend (a b c)
  (cond
    ((null a)
      (cond ((null b) c) 
      (t (cons (car b) (myAppend a (cdr b) c)))))
    (t (cons (car a) (myAppend (cdr a) b c)))
  ) 
)

(defun preorder (tree)
  (cond 
    ((null tree) nil)
    (t (myAppend (list (car tree)) (preorder (cadr tree)) (preorder (caddr tree))))
  )
)

;(print (preorder '(A (B) (C (D) (E))))) ;(A B C D E)
;(print (preorder '(A (B (C (D) (E))) (F (G))))) ;(A B C D E F G)
;(print (preorder '(A (B (C (D) (E))) (F (G (H (I (J)))))))) ;(A B C D E F G H I J)
;(print (preorder '())) ;nil
(print (preorder '(A (B (D (E (F(G)(H(J)(K))))))(C(L(N)(Q(P)(R)))(M)))))

