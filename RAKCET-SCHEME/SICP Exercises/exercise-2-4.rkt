#lang racket

; Any Any -> Pair
; Given two numbers, returns a function that takes a "selector function"
; and applies it to the two original numbers
(define (cons x y)
  (lambda (m) (m x y))
  )

; Cons -> Number
(define (car z)
  (z (lambda (p q) p))
  )
;First it calls cons
; x = 2 y = 5
; so cons 2 5 becomes (lambda (m) (m 2 5) )
; then it becomes (car (lambda (m) (m 2 5) ))
; now calculate car
; car = (z (lambda (p q) p)), where z is the given cons function
; ((lambda (m) (m 2 5) ) (lambda (p q) p))
(car (cons 2 5))

; Cons (Function) -> Number
(define (cdr z)
  (z (lambda (p q) q) )
  )
(cdr (cons 2 5))

