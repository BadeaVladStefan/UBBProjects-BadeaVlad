;13. For a given tree of type (2) return the path from the root node to a certain given node X. 

; checkExistence(l1l2...ln, elem) = 
; = true, if l1 = elem
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

; path(l1l2l3, elem) = 
; = nil, if l1l2l3 is empty
; = l1, if elem = l1
; = path(l2), if checkExistence(l2) = true
; = path(l3), if checkExistence(l3) = true

(defun path(l elem)
  (cond 
    ((null l) nil)
    ((equal (car l) elem) (list (car l)))
    ((checkExistence (cadr l) elem) (cons (car l) (path (cadr l) elem)))
    ((checkExistence (caddr l) elem) (cons (car l) (path (caddr l) elem)))
  )
)

(print (path '(a (b (c) (d)) (h (i) (l(n) (m)))) 'n))