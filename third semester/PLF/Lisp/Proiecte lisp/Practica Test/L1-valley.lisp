; f = 0 for an decreasing sequence
; f = 1 for a increasing sequence
; mathematical model:
; valley(l1l2...ln, f) = { t, if n <= 1 and f = 1
;                        { valley(l2...ln, 0), if l1 >= l2 and f = 0
;                        { valley(l2...ln, 1), if l1 <= l2 and f = 0
;                        { valley(l2...ln, 1), if l1 <= l2 and f = 1
;                        { nil, otherwise

(defun valley (l f)
    (cond
        ((and (null (cdr l)) (= f 1)) t)
        ((and (>= (car l) (cadr l)) (= f 0)) (valley (cdr l) 0))
        ((and (<= (car l) (cadr l)) (= f 0)) (valley (cdr l) 1))
        ((and (<= (car l) (cadr l)) (= f 1)) (valley (cdr l) 1))
        (t nil)
    )
)

(defun mainvalley (l)
    (cond 
        ((null l) nil)
        ((null (cadr l)) nil)
        ((<= (car l) (car(cdr l))) nil )
        (t (valley l 0))
    )
)

(print (mainvalley '(6 17 19 20)))