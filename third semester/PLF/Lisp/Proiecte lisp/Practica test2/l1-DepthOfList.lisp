; findDepth(l1l2...ln, c) = 
; = c , if n = 0
; = myMax(findDepth(l1,c+1), findDepth(l2...ln, c)) , if l1 is a list
; = findDepth(l2...ln, c) , otherwise


(defun findDepth (l c)
  (cond
    ((null l) c)
    ((listp (car l)) (myMax (findDepth (car l) (+ c 1)) (findDepth (cdr l) c)))
    (t (findDepth (cdr l) c))
  )
)