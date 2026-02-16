#lang racket

;(define add4 (lambda (x) (+ x 4)))

;(define thing (lambda (x y z) (+ x y (sqr z)) ))
;(thing 1 2 3)


;  (define a (+ 1 x y))
;  (define b (- 1 y))

;  (+ (* x (sqr a)) (* y b) (* a b) )

(define (f x y)
  (let ((a (+ 1 x y))
        (b (- 1 y))
        )
    (+ (* x (sqr a)) (* y b) (* a b) )
    )
  )
(f 1 2)

(define (g x)
  (+ (let ((x 3))
       (+ x (* x 10)))
     x)
  )
(g 5)