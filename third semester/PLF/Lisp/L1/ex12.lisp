;EX 12

#|
a) Write a function to return the dot product of two vectors. https://en.wikipedia.org/wiki/Dot_product

Mathematical model:
                              { 0 if n = 0
dotProduct(a1a2..an,b1b2..bm)={ a1*b1+dotproduct(a2..an,b2..bm) otherwise 
|#

(defun dotProduct (a b)
	(cond
		((null a) 0)
		(t (+ (* (car a) (car b)) (dotProduct (cdr a) (cdr b))))
	)
)
(print (dotProduct '(1 2 3) '(4 5 6)))
;=> 1*4 + 2*5 + 3*6 = 4 + 10 + 18 = 32

#|
b) Write a function to return the maximum value of all the numerical atoms of a list, at any level.

Mathematical model:
myMax(a, b)={a if b is not a number
            {b if a is not a number
            {a if a >= b
            {b otherwise 
|#
(defun myMax (a b)
	(cond
		((not (numberp b)) a)
		((not (numberp a)) b)
		((>= a b) a)
		(t b)
 	)
)

#|
Mathematical model:
maxList(l1l2..ln)={ nil if n = 0
                  { myMax(l1,maxList(l2...ln)) if n>=1 and l1 atom
                  { myMax(maxList(l1),maxList(l2..ln)) otherwise (n>=1,
								 l1-list)
|#

(defun maxList (l)
	(cond
		((null l) nil)
		((atom (car l)) (myMax (car l) (maxList(cdr l))))
		(t (myMax (maxList(car l)) (maxList(cdr l))))
	)
)
(print (maxList '(3 (7 2) (5 8) 4)))
;=> max=8

#|
c) All permutations to be replaced by: Write a function to compute the result of an arithmetic expression
memorised 
 in preorder on a stack. Examples:
 (+ 1 3) ==> 4 (1 + 3)
 (+ * 2 4 3) ==> 11 [((2 * 4) + 3)
 (+ * 2 4 - 5 * 2 2) ==> 9 ((2 * 4) + (5 - (2 * 2))

Mathematical model:
myAppend(a1a2..an,b1b2..bm)={ b1b2..bm if n = 0
                            { a1 U myAppend(a2..an,b1b2..bm) otherwise
|#
(defun myappend (l p)
    (cond
        ((null l) p)
        (t (cons (car l) (myappend (cdr l) p)))
    )
)

#|
Mathematical model:
myReverse(l1l2..ln) = { nil if n = 0 
                      { myAppend(myReverse(l2..ln), list(myReverse(l1))) if l1 is a list
                      { myAppend(myReverse(l2..ln), list(l1)) otherwise
|#
(defun myreverse (l)
    (cond
        ((null l) nil)
        ((listp (car l)) (myappend (myreverse (cdr l)) (list (myreverse (car l)))))
        (t (myappend (myreverse (cdr l)) (list (car l))))
    )
)

#|
Mathematical model:
evaluate(l1..ln,s1..sm)={ s1, if n = 0
			{ evaluate(l2...ln, l1Us1s2..sm) if l1 is a number ;add the number to the stack
			{ evaluate(l2..ln, {s1 * s2}U(s3..sm)) if l1 = * ; mulitply the last two numbers added to the stack if the operand * and add the result back
			{ evaluate(l2..ln),{s1 + s2}U(s3..sm) if l1 = + ; add the last two numbers from the stack and add the result back to the stack
			{ evaluate(l2..ln),{s1 / s2}U(s3..sm) if l1 = / ; same as before
			{ evaluate(l2..ln),{s1 - s2}U(s3..sm) if l1 = - ; same as before
|#
(defun evaluate (l s)
    (cond
        ((null l) (car s))
        ((numberp (car l)) (evaluate (cdr l) (cons (car l) s)))
        ((string= (car l) "*") (evaluate (cdr l) (cons (* (car s) (cadr s)) (cddr s))))
        ((string= (car l) "+") (evaluate (cdr l) (cons (+ (car s) (cadr s)) (cddr s))))
        ((string= (car l) "/") (evaluate (cdr l) (cons (/ (car s) (cadr s)) (cddr s))))
        ((string= (car l) "-") (evaluate (cdr l) (cons (- (car s) (cadr s)) (cddr s))))
    )
)

#|
Mathematical model:
main(l)={evaluate(myReverse(l) ()) ; evaluate uses the reversed list and the stack is empty at the start
|#
(defun main (l)
    (evaluate (myreverse l) ())
)

(print (main '(+ * 2 4 - 5 * 2 2)))
;=>(2*4)+[5-(2*2)]=8+(5-4)=9

#|
d) Write a function to return T if a list has an even number of elements on the first level, and NIL on the
contrary case, without counting the elements of the list.
Mathematical model:
evenElems(l1l2..ln)={ T if n = 0
                    { Nil if n = 1
		    { evenElems(l3..ln) otherwise
|#

(defun evenelems (l)
  (cond
    ((null l) T)
    ((null (cdr l)) nil)
    (t (evenelems (cddr l)))
  )
)

(print (evenelems '(1 2 3 4 5 6)))
;=>T
