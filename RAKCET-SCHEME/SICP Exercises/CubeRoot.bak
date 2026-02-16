#lang sicp

(define (sqrt-iter guess x)
  (if (good-enough?) guess (sqrt-iter (improve guess x) x))
  )

(define (improve guess x)
  (average guess (/ x guess))
  )

(define (average x y)
  (/ (+ x y) 2)
  )

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.1)
  )

(define (square x) (* x x))

(sqrt 0)