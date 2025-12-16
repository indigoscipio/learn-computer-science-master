#lang racket

; exercise 1.4.2

; (num -> num) -> num
; HOF style pattern - take a function and returns a number
(define (run-at-zero f)
  (f 0)
  )
(run-at-zero sqr)
(run-at-zero add1)


; num -> (num -> num)
; function factory
(define (add n)
  (lambda (x) (+ x n) )
  )
((add 5) 100) ; call add5 first -> call that result with 100

; (num -> num) -> (num -> num)
(define (twice f)
  (lambda (x) (f (f x)) )
  )
(twice add1)
((twice add1) 5)
