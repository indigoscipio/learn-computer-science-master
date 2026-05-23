#lang racket

#|
PROBLEM 3: LARGEST PRIME FACTOR

The prime factors of 13195 are 5,7,13, and 29
what is the largest prime factor of the number 600851475143?
|#


;;pf: given a number, returns all of their prime factors
; number -> list-of-number
(define (pf n)=
  (define (helper curr-n curr-factor result)
    (cond [(<= curr-n 1) result]
          [(zero? (remainder curr-n curr-factor)) (helper (/ curr-n curr-factor)
                                                          curr-factor
                                                          (cons curr-factor result) )] ;divide curr-n
          [else (helper curr-n (+ 1 curr-factor) result)] ;increase curr-factor
          )
    )
  ; initialize with curr-n = n, curr-factor = 2 and reuslt = '()
  (helper n 2 '())
  )
(pf 600851475143?)


;;largest-pf
; given a list of prime factors, returns its largest prime number
(define (largest-pf n)
  (car (pf n))
  )
(largest-pf 600851475143)

