#lang racket

#|
PROBLEM 35
CIRCULAR PRIMES

the number 197 is called circular primes because all rotations of the digits:
197 971 and 719 are themselves prime

there are thirteen such primes below 100:
2 3 5 7 11 13 17 31 37 71 73 79 and 97

how many circular primes are themselves below one million?

answer:
ok so we need to find circular primes
a circular prime is a prime when the digit is rotated is also a prime

exmample shows 2,3,5,7 is circular prime, so 1 digit prime is circular by defualt?
2 digit -> (11, 11),(13,31),(17,71),(37,73),(79,97)
3 digit -> one example is (197,971,719)
4 digit ->(dddd,dddd,dddd,ddd), ...
5 digit ->(ddddd,ddddd,ddddd,ddddd,ddddd), ...
6 digit ->(dddddd,dddddd,dddddd,dddddd,dddddd,dddddd,), ...

6 digit is the max ceiling
so each digit grows length of pair grows
the max bound is one million so search space is 2 - 999999

approach
- basic prime check function helper
- helper that checks if a prime is circular
- main function that accumulates count to those

or simpler maybe just do
- gnerate prime from 2 to 999999
- filter by is-circular-prime?
- then just sum it with foldr

|#

; i dont remember how to check for primality
; numer -> boolean
(define (is-prime? n)
  (define (helper curr-fact)
    (cond [(> curr-fact (sqrt n)) #t] ;prime
          [(zero? (remainder n curr-fact)) #f] ;divides evenly with fact other than n, not prime
          [else (helper (+ 1 curr-fact))] ;keep finding factor
          )
    )
  (if (<= n 1)
      #f
      (helper 2)
      )
  )
(is-prime? 2) ; should return #t
(is-prime? 1) ; should return #f
(is-prime? 0) ; should return #f
(is-prime? 97) ; should return #t

; number -> boolean
; given a number, checks if that number is circula prime
#|
Think about what "rotating digits" means mechanically.
If you have 197, you get 971, then 719.
What arithmetic operation produces a rotation?
Think about what happens to the digits when you move the last digit to the front
— or the first digit to the back. What math does that?
Once you can generate rotations, the rest follows naturally from your prime checker.
|#

; number -> number
(define (num-digit n)
  (string-length (number->string n))
  )

; number -> boolean
(define (is-circular-prime? n)
  (let ((d (num-digit n)))
    ; number -> number
    ; rotates a number (moves digit to the right). eg 197 -> 719
    (define (rotate-num n digit)
      (let ((q (quotient n 10))
            (r (remainder n 10))
            (magnitude (expt 10 (- digit 1)))
            )
        (+ (* magnitude r) q)
        )
      )

    ; number -> list-of-number
    ; generate number rotations
    (define (generate-all-rotations n digit-counter)
      ; 123 -> 123, 312, 231
      ; rotate digit times
      (cond [(zero? digit-counter) '()]
            [else (let ((curr-rotated (rotate-num n d)))
                    (cons n (generate-all-rotations curr-rotated (- digit-counter 1)))
                    ) ]
            )
      )

    ; main function
    (andmap is-prime? (generate-all-rotations n d))
    
    )
  )
(is-circular-prime? 2)
(is-circular-prime? 3)
(is-circular-prime? 5)
(is-circular-prime? 11)
(is-circular-prime? 13)
(is-circular-prime? 97)
(is-circular-prime? 16)

; main function
; void -> number
(define (circular-primes)
  (define (loop curr-n result)
    ; base: number reaches 1mil -> stop and return result
    ; case: number is circular prime -> add to count
    ; else: skip and recurse
    (cond [(> curr-n 1000000) result]
          [(is-circular-prime? curr-n) (loop (+ 1 curr-n) (+ 1 result))]
          [else (loop (+ 1 curr-n) result)]
          )
    )
  (loop 2 0)
  ; initialize with curr-n = 2
  )
(circular-primes)