;13
;a) A linear list is given. Eliminate from the list all elements from N to N steps, N-given. 

#|
Mathematical model:                    
eliminate(l n c) = {nil if l=[] 
                   { eliminate(l2..ln n 1) if c=n
                   { l1Ueliminate(l2..ln n c+1)
wrapper(l n) = eliminate(l n 1)
 |#

 (defun eliminate (l n c)
    (cond
        ((null l) nil)
        ((= n c) (eliminate (cdr l) n 1))
        (t (cons (car l) (eliminate (cdr l) n (+ c 1))))
    )
 )
 (defun wrapper (l n)
    (cond
        (t (eliminate l n 1))
    )
 )
 ;(print (wrapper '(1 2 3 4 5 6 7 8 9) 3))

 ;b) Write a function to test if a linear list of integer numbers has a "valley" 
 ;aspect (a list has a valley aspect if the items decrease to a certain point and then increase. 
 ;Eg. 10 8 6 17 19 20). A list must have at least 3 elements to fullfill this condition. 

 #|
 valley(l flag counter) = 
                          { valley(l2..ln 1 c+1) if l1>l2 and flag=1 
                          { valley(l2..ln 0 c+1) if l1<l2 and flag=1
                          { valley(l2..ln 0 c+1) if l1<l2 and flag=0
                          { T if flag = 0 and c > 2 and l=[]
                          { nil otherwise
wrapper(l) = valley(l 1 0)
  |#

(defun valley (l f c)
  (cond
    ((and (= f 1) (> (first l) (second l))) (valley (rest l) 1 (+ c 1)))
    ((and (= f 1) (< (first l) (second l))) (valley (rest l) 0 (+ c 1)))
    ((and (= f 0) (< (first l) (second l))) (valley (rest l) 0 (+ c 1)))
    ((and (null l) (and (= f 0) (> c 2))) T)
    (t nil)
  )
)

(defun wrapper (l)
  (cond
    (t (valley l 1 0))
  )
)

(print (wrapper '(10 8 6 17 19 20)))
