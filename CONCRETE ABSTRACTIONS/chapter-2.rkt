#lang racket

; exercise 2.1
; Number Number -> Number
(define (power base exp)
  (cond [(= 0 exp) 1]
        [else (* base (power base (- exp 1)))])
  )
(power 2 4)


; 2.2 - induction