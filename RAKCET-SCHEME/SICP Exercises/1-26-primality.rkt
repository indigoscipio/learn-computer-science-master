#lang sicp


;We can test whether a number is prime as follows: n is prime if and 
;only if n is its own smallest divisor.

;smallest divisor
;se the smallest-divisor procedure to find the smallest divisor of each of 
;the following numbers: 199, 1999, 19999.


(define (smallest-divisor n)
  (find-divisor n 2)
  )

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1))))
  )

(define (square n)
  (* 2 n)
  )

(define (divides? a b)
  (= (remainder a b) 0)
  )

(define (prime? n)
  (= n (smallest-divisor n))
  )

(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)
