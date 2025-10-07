#lang racket

; Number Number -> Number
; multiply in terms of sum
; multiply a b times
(define (mult a b)
  (cond [(= b 0) 0]
        [else (+ a (mult a (- b 1)))])
  )
(mult 3 4) ;-> 3 x 3 x 3 x 3

