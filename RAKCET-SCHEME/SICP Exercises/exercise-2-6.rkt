#lang racket


; zero is a function that takes an argument, and returns another function that returns its own argument
(define zero (lambda (f) (lambda (x) x)))
(define one (lambda (f) (lambda (x) (f x)) ) )
(define two (lambda (f) (lambda (x) (f (f x))) ))

((two (lambda (x) (* x 2))) 1)

; ChurchNumeral -> ChurchNumeral
; ???
(define (add1 n)
  (lambda (f) (lambda (x) (f ((n f) x)) ) )
  )
;add1 0
;(lambda (f) (lambda (x) (f ((zero f) x)) ) )
;(lambda (f) (lambda (x) (f (lambda (x) x) x)) ) )
;(lambda (f) (lambda (x) (f x)))

(define (plus m n)
  (lambda (f) (lambda (x) ((m f) ((n f) x)) ) )
  )

;goal: represent natural number using function
; a number is a process of doing something n times
