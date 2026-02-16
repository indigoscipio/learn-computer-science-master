#lang racket

;Helper functions
(define (cube x)
  (* x x x )
  )
(define (identity x)
  x
  )

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))


;; accumulate : [X Y -> Y] Y (Number -> X) Number (Number -> Number) Number -> Y
;; General recursion to accumulate values over a range using a combiner and base
;Linear recursion style
(define (accumulate combiner null-value term a next b)
  (cond [(> a b) null-value]
        [else (combiner (term a) (accumulate combiner null-value term (next a) next b) ) ])
  )
(accumulate * 1 identity 1 add1 4)

;Iterative recursion version
(define (accumulate.v2 combiner null-value term a next b)
  (define (acc-iter a result)
    (cond [(> a b) result]
          [else (acc-iter (next a) (combiner (term a) result)  ) ])
    )
  (acc-iter a null-value)
  )
(accumulate.v2 * 1 identity 1 add1 4)

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;; filtered-accumulate : [X Y -> Y] Y (Number -> X) (Number -> Boolean)
;;                       Number (Number -> Number) Number -> Y
;; Combines values from a to b, skipping any value that fails the predicate
(define (filtered-accumulate combine null-value term predicate a next b)
  (cond [(> a b) null-value]
        [(predicate a) (combine (term a) (filtered-accumulate combine null-value term predicate (next a) next b) )
                       ]
        [else (filtered-accumulate combine null-value term predicate (next a) next b) ])
  )
(filtered-accumulate + 0 identity odd? 1 add1 4) 