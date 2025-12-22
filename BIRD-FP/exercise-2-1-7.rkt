#lang racket

(define eps 0.1)

; given a number guess and target,
; checks if its good enough
(define (good-enough? guess x)
  (< (abs (- (sqr guess) x)) eps)
  )

(define (improve guess x)
  (/ (+ guess (/ x guess)) 2)
  )

; regular square root
; Number -> Number
; given a number, finds if its a square root
(define (sqrt-iter guess x)
 (if (good-enough? guess x)
     guess
     (sqrt-iter (improve guess x) x) )
  )


(define (square-root x)
  (sqrt-iter 1.0 x))


(= (+ 0.1 0.2) 0.3)