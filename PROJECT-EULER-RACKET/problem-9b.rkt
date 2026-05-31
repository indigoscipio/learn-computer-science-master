#lang racket

#|
PROBLEM 10

The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17
find the sum of all the primes below two million.


answer:
ok so i think this is a simple one
1. gather/find all valid primes up to n
2. sum those primes since we only care about the sum

|#

; is-prime?:: given a number, checks if its a valid prime
; i dont rememebr how to find prime but maybe using the n > sqrt n thing
; if i remmeber a number is prime if it has only 2 divisor: 1 and itself
(define (is-prime? n)

  (define (helper curr-factor curr-n)
    (cond [(> curr-factor (sqrt curr-n)) #t]
          [(zero? (remainder curr-n curr-factor)) #f]
          [else (helper (+ 1 curr-factor) curr-n)]
          )
    )
  (helper 2 n)
  )
(is-prime? 7)


(define (sum-of-primes n)

  (define (helper curr-prime curr-sum)
    (cond [(> curr-prime n) curr-sum] ;curr-sum exceeds n, return it
          [(is-prime? curr-prime) (helper (+ 2 curr-prime) (+ curr-prime curr-sum) )] ;check if number is a prime, if so add it to curr sum
          [else (helper (+ 2 curr-prime) curr-sum)] ;else check for next number
          )
    )
  ; initialize with curr-prime = 2 and curr-sum = 0
  (helper 3 2)
  )
(sum-of-primes 2000000)