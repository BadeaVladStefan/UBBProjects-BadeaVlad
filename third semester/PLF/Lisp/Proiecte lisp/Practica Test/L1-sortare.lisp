(defun inserare (l elem)
    (cond
        ((null l) (list elem ) )
        ( (= elem (car l)) l )
        ( (< elem (car l)) (cons elem l))
        (t (cons (car l) (inserare (cdr l) elem)))
    )
 )

 (defun sortare (l)
    (cond
        ((null l) nil)
        (t (inserare (sortare (cdr l)) (car l)))
    )
 )