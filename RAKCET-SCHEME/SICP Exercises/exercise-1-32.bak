#lang racket

;Helper functions
(define (cube x)
  (* x x x )
  )
(define (identity x)
  x
  )

;; product : (Number -> Number) Number (Number -> Number) Number -> Number
; Computes the product of integers from a to b
; iterative recursion (accumulator style)
(define (product.v1 term a next b)
  ; result is an accumulator that stores 
  (define (iter a result)
    (if (> a b) ;base case - a reaches b 
        result
        (iter (next a) (* (term a) result) ))
    )
  (iter a 1)
  )
(product.v1 identity 1 add1 4)

; [Number -> Number] Number [Number -> Number] Number -> Number
; Computes the product of integers from a to b
; linear recursion style
(define (product.v2 term a next b) 
  (cond [(> a b) 1]
        [else (* (term a) (product.v2 term (next a) next b) ) ])
  )
(product.v2 identity 1 add1 4)

(define (factorial n)
  (product.v1 identity 1 add1 n)
  )
(factorial 3)

;; term : Number -> Number
;; Given a position k, computes (2k)^2 / ((2k - 1)(2k + 1))
(define (approx-pi-term k)
  (/ (expt (* 2 k) 2) (* (- (* 2 k) 1) (+ (* 2 k) 1)))
  )


(define (approx-pi n)
  (* 4 (product.v2 approx-pi-term 1 add1 n) )
  )
(approx-pi 1)