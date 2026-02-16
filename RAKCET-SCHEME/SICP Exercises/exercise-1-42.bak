#lang racket


(define (inc x)
  (add1 x)
  )

; [Number -> Number] -> [Number -> Number]
; Takes a procedure of one argument.
; Returns a procedure that applies the original procedure twice.
(define (double f)
  (lambda (x) (f (f x)))
  )


( ( (double (double double)) inc) 5)