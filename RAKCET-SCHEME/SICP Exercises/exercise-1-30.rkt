#lang racket

;Helper functions
(define (cube x)
  (* x x x )
  )
(define (identity x)
  x
  )
(define (inc x)
  (add1 x)
  )

;Number Number -> Number
;Computes the sum of integers from a to b
(define (sum-integers term a next b)
  ; result is an accumulator that stores 
  (define (iter a result)
    (if (> a b) ;base case - a reaches b 
        result
        (iter (next a) (+ (term a) result) ))
    )
  (iter a 0)
  )
(sum-integers identity 1 inc 3)
