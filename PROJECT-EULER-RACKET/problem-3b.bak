#lang racket

#|
PROBLEM 3: LARGEST PRIME FACTOR

The prime factors of 13195 are 5,7,13, and 29
what is the largest prime factor of the number 600851475143?
|#


;;pf: given a number, returns all of their prime factors
; number -> list-of-number
; VERSION 2: using sqrt N method
(define (largest-pf n)
  ; if N has a factor, the smallest remaining factor cannot be greater than sqrt(n)
  (define (helper curr-n curr-factor)
    (cond [(zero? (remainder curr-n curr-factor)) (helper (/ curr-n curr-factor)
                                                          curr-factor )] ;divide curr-n
          [(> curr-factor (sqrt curr-n)) curr-n]
          [else (helper curr-n (+ 1 curr-factor))] ;increase curr-factor
          )
    )
  ; initialize with curr-n = n, curr-factor = 2 and reuslt = '()
  (helper n 2)
  )
(largest-pf 120)
