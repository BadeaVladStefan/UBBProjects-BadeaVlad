; b) Write a function to test if a linear list of numbers has a "mountain" aspect (a list has a "mountain"
;    aspect if the items increase to a certain point and then decreases.
;    Eg. (10 18 29 17 11 10). The list must have at least 3 atoms to fullfil this criteria.

; f = 0 for an increasing sequence
; f = 1 for a decreasing sequence
; mountain(l1l2...ln, f) = 
; = true , if n <= 1 and f = 1
; = mountain(l2...ln, 0), if l1 <= l2 and f = 0
; = mountain(l2...ln, 1), if l1 >= l2 and f = 0
; = mountain(l2...ln, 1), if l1 >= l2 and f = 1
; = false , otherwise


(defun mountain(l f)
  (cond
    ((and (null (cdr l)) (= f 1)) t)
    ((and (<= (car l) (cadr l)) (= f 0)) (mountain (cdr l) 0))
    ((and (>= (car l) (cadr l)) (= f 0)) (mountain (cdr l) 1))
    ((and (>= (car l) (cadr l)) (= f 1)) (mountain (cdr l) 1))
    (t nil)
  )
)

; mainB(l1l2...ln) = 
; = nil (false) , if n = 0
; = nil (false) , if n = 1
; = nil (false) , if n = 2
; = mountain(l1l2...ln, 0) , otherwise

;In order to check for the mountain aspect, our list need to have at least 3 elements
(defun mainB(l)
  (cond
    ((null l) nil)
    ((null (cadr l)) nil)
    ((null (caddr l)) nil)
    (t (mountain l 0))
  )
)