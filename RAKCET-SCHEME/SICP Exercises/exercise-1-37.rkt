#lang racket

; cont-frac: (Nat -> Number) (Nat -> Number) Nat -> Number
; computes the k-term continued fraction where:
; - n is a function that gives the numerator for index i,
; - d is a function that gives the denominator for index i,
; - k is the number of terms in the continued fraction.

;iterative recursion style
(define (cont-frac n d k)
  ; accumulator iter accumulates ????
  ; Number Number -> Number
  (define (iter i result)
    (cond [(= i 0) result ]
          [else (iter (sub1 i) (/ (n i) (+ (d i) result)))])
    )
  (iter k 0)
  )

;linear recursion style
;(Nat -> Num) (Nat -> Num) Nat -> Num
(define (cont-frac.v2 n d k)
  (cond [(= k 0) 0]
        [else (/ (n k) (+ (d k) (cont-frac.v2 n d (sub1 k)) ))  ])
  )

(cont-frac.v2 (lambda (i) 1.0)
           (lambda (i) 1.0)
           123)