; d) Write a function to transform a linear list into a set.

; transformSet(l1l2...ln) = 
; = nil , if n = 0
; = {l1} U transformSet(removeApparences(l2...ln, l1)) , otherwise

(defun transformSet(l)
  (cond
    ((null l) nil)
    (t (cons (car l) (transformSet (removeApparences (cdr l) (car l)))))
  )
)


; removeApparences(l1l2...ln, elem) = 
; = nil , if n = 0
; = removeApparences(l2...ln, elem) , if l1 = elem
; = {l1} U removeApparences(l2...ln, elem) , otherwise

(defun removeApparences(l e)
  (cond 
    ((null l) nil)
    ((= (car l) e) (removeApparences (cdr l) e))
    (t (cons (car l) (removeApparences (cdr l) e)))
  )
)