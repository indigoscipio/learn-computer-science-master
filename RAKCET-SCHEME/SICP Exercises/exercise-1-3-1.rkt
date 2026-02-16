#lang racket

;Number Number -> Number
;Computes the sum of integers from a to b
(define (sum-integers a b)
(cond [(> a b) 0]
      [else (+ a(sum-integers (add1 a) b) ) ]
      )
  )
(sum-integers 1 3)


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
;Computes the sum of cubes
(define (sum-cubes a b)
  (cond [(> a b) 0]
        [else (+ (cube a) (sum-cubes (add1 a) b ))])
  )
(sum-cubes 1 3)


;Number -> Number
; Sums of squares with the SICP template (seperated term & next)
(define (sum-square.v2 term a next b)
  (cond [(> a b) 0]
        [else (+ (term a) (sum-square.v2 term (next a) next b) ) ]
        )
  )
(sum-square.v2 sqr 1 inc 3) 