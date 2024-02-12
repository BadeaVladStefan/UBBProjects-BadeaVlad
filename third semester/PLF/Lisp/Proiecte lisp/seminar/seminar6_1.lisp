;check if e is an element of a non-linear list

#|

find(l,e)={ 0 if l != e
          { 1 if l = e
             n
          { Sigma(l,e) if l is (l1l2..ln) list
            i=1
 |#         

    (defun find (l e)
        (cond
            ((and (atom l) (eq l e )) 1)
            ((atom l) 0)
            (t (apply '+ (mapcar #'(lambda (x) (find x e)) l)))
        )
    )