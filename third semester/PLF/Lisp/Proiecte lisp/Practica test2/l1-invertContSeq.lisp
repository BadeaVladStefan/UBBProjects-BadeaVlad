;c) Write a function that, with a list given as parameter, inverts only continuous
;   sequences of atoms. Example:
;   (a b c (d (e f) g h i)) ==> (c b a (d (f e) i h g)


; invertCont (l1l2...ln, aux) = 
; = aux , if n = 0
; = myAppend(aux, myAppend(list(invertCont(l1, NIL)), invertCont(l2...ln, NIL))) , if l1 is a list
; = invertCont(l2...ln, myAppend(list(l1), aux)) , otherwise


(defun invertCont (l aux)
  (cond
    ((null l) aux)
    ((listp (car l)) (myAppend aux (myAppend (list (invertCont (car l) nil)) (invertCont (cdr l) nil))))
    (t (invertCont (cdr l) (myAppend (list (car l)) aux)))
  )
)