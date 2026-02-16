#lang sicp
;(require rnrs/mutable-pairs-6)
;(require compatibility/mlist)

; List-of-X List-of-Y -> List-of-Y
(define (append x y)
  (cond [(null? x) y]
        [else (cons (car x) (append (cdr x) y))])
  )

(define (last-pair l)
  (cond [(null? (cdr l)) l]
        [else (last-pair (cdr l))])
  )

; List-of-X List-of-Y -> List-of-Y
; like append but mutates the list
(define (append! x y)
  (set-cdr! (last-pair x) y)
  x
  )

#|
(define x (list 'a 'b))
; x --> [a | *] --> [b | nil]
(define y (list 'c 'd))
; y --> [c | *] --> [d | nil]
(define z (append x y))
; z --> [a | *] --> [b | *] --> [c | *] --> [d | nil]
; since we use the unmutable "append", we createa new copy

(cdr x)
; response = ('b)

(define w (append! x y))
; response = (append! '(a b) '(c d))
; mutates x to '(a b c d)
; binds w with x = '(a b c d)

(cdr x)
; response = '(b c d)


; Exercise 3.13
; List-of-X -> List-of-Y
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)


(define z (make-cycle (list 'a 'b 'c)))
; before mutation
; z --> [a | *] --> [b | *] --> [c | nil]

; It sets the last pair of argument '(c) into '(a b c)
; z --> [a | *] --> [b | *] --> [c | *] --> [a | *] --> [b | *] --> [c | *] --> continues infinitely, creating a cycle

z
; What happens if we try to compute last-pair z??
; seems to be running a infinite loop because z is a circular list


; Exercise 3.14
(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

; what does mystery do in general?
; answer:
; lets say we call (mystery '(1 2 3 4))
; it calls loop with the following:
; x = '(1 2 3 4), from mystery's parameter
; y = an empty list

; once evaluated, it checks if x (inside loop) is empty
; '(1 2 3 4) is not empty -> false
; then it sets up a let, creates a new lexical scope
; within this scope, it defines a new variable
; temp = (cdr x) = '(2 3 4)

; inside the body, it sets the cdr of x to y
; so now x = 1 + '() = '(1 '())
; then it calls a recursion to loop with the following
; new x = '(2 3 4)
; new y = '(1 '())

; 2nd call
; is x empty? - false
; temp = (cdr x) = '(3 4)
; set x's cdr to y, so x = '(2 (1 '()))
; new x = '(3 4)
; new y = '(2 (1 '()))

; 3rd call
; is x empty? - false
; temp = '(4)
; set x's cdr to y, so x = '(3 (2 (1 '())))
; new x = '(4)
; new y = '(3 (2 (1 '())))

; 4rd call
; is x empty? - false
; temp = '()
; set x's cdr to y, so x = '(4 (3 (2 (1 '()))))
; new x = '()
; new y = '(4 (3 (2 (1 '()))))

; 5th call
; is x empty? true
; returns y
; return value = '(4 (3 (2 (1 '()))))

; conclusion/final answer: it seems that mystery reverses the order given a list, kind of like reverse.
; but unlike reverse, it mutates the list (x's cdr)


; suppose v is define below
; (define v '(a b c d))
; draw the box and pointer diagram that represents the list to which v is bound.
; answer:
; v --> [a | *] -> [b | *] -> [c | *] -> [d | null]
(define v '(a b c d))
v ; should return '(a b c d)

; suppose now we evaluate (define w (mystery v))
; draw box and pointer diagram that show the structure v and w after evaluating this expression
; answer:
; w --> [d | *] -> [c | *] -> [b | *] -> [a | null]
(define w (mystery v))
w ; should return '(d c b a)


; what would be printed as the values of v and w??
v ; returns '(a)
w ; returns '(d c b a)


|#

(define a '(1 2 3 4 5))
(define z1 (cons a a))
(define z2 (cons '(a b) '(a b) ))

(define (set-to-wow! x) (set-car! (car x) 'wow ) x)
(set-to-wow! z1)
z1
z2
(set-to-wow! z2)

(eq? a a)

