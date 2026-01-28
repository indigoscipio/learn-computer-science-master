#lang racket

;RECURSION

; with pattern matching
(define (expo base pow)
  (match pow
    [0 1]
    [n (* base (expo base (- n 1)))]
    )
  )
(expo 2 3)
