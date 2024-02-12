;10. Return the level of a node X in a tree of type (2). The level of the root element is 0. 

#|
findlevel(l x c) =   { 0 if l=[]
                     { c if x=l1
                     { findlevel(l2 x c+1) + findlevel(l3 x c+1)
wrapper(l x) = findlevel(l x 0)
 |#

(defun findLevel (tree x c)
  (cond
    ((null tree) 0) ; Node not found
    ((equal x (car tree)) c) ; Node found at current level
    (t (+ (findLevel (cadr tree) x (+ c 1)) ; Check left subtree
          (findLevel (caddr tree) x (+ c 1)))))) ; Check right subtree

(defun wrapper (tree x)
  (findLevel tree x 0))

; nodesFromLevel(l1l2l3, level, counter)
; = nil, if l1l2l3 is empty
; = l1 , if counter = level
; = myAppend((list (nodesFromLevel(l2, level, counter + 1))) (list (nodesFromLevel(l3, level, counter + 1)))), otherwise

(defun nodesFromLevel(l level counter)
  (cond
    ((null l) nil)
    ((equal counter level) (list (car l)))
    (t (Append (nodesFromLevel (cadr l) level (+ 1 counter)) (nodesFromLevel (caddr l) level (+ 1 counter))))
  )
)

; checkExistence(l1l2...ln, elem) = 
; = true, if elem = l1
; = false, if n = 0
; = checkExistence(l1, elem) or checkExistence(l2...ln, elem), if l1 is a list
; = checkExistence(l2...ln, elem), otherwise


(defun checkExistence(l elem)
  (cond
    ((null l) nil)
    ((equal (car l) elem) t)
    ((listp (car l)) (or (checkExistence (car l) elem) (checkExistence (cdr l) elem)))
    (t (checkExistence (cdr l) elem))
  )
)

(defun main(l elem)
  (cond
    ((checkExistence l elem) (nodesFromLevel l (findLevel l elem 0) 0))
    (t nil)
  ) 
)
(print (wrapper '(a (b (c) (d)) (h (i) (l(n) (m)))) 'b))
(print (main '(a (b (c) (d)) (h (i) (l(n) (m)))) 'n))