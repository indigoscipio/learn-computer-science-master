#lang racket

#|
PROBLEM 37 - TRUNCABLE PRIMES
The number 3797 has an interesting property.
Being prime itself, it is possible to continuously
remove digits from left to right, and remain prime at each stage:

3797, 797, 97, and 7

Similarly we can work from right to left:

3797, 379, 37, and 3

find the sum of the only 11 primes that are both truncatable from left to right
and right to left

note: 2,3,5,7 are not considered to be truncatable primes

__

answer:
let me understand this
the question wants me to find truncatbale primes
both truncated from left to right each truncation still remains prime until theres 1 digit

left truncation: 3797 -> 797 -> 97 -> 7 - all primes on each stage
right truncation: 3797 -> 379 -> 37 -> 3 - all primes on each stage

now the question said ther are only 11 primes
i dont know which those are so we need to find them
the thing is i dont know the search space limit,
maybe could be up to a billion or more as far as i know


but once i discover the search space the approach shoudl be simple
- is-truncatable-prime-left? - helper that checks if a number is truncatable at every stage
and remains prime. left truncation (remove left digit at each stage)
- is-truncatable-prime-right? - same, but right truncation (remove right digit at each stage)
- could possible combine those 2 into 1, is-truncatable-prime? that acceps direction left or right,
but lets think thisfor later
- is-prime? simple primality check
- main function that does the sum of the 11 primes

or wait, what if i set a limit for the main function if there is 11 primes found
then stop, so thats the base case, so no need to find the max search space ceiling
but then again could be a huge number, but lets try


Look at is-truncable-prime-ltr? carefully.
You're passing in a list of digits, but then calling is-prime?
on fst — the first element of that list. That's a single digit,
not a number. For example with 3797, you'd be checking if 3 is prime,
not if 3797 is prime. The first truncation stage should check the whole number,
not just its leading digit.

Ask yourself: what does "one truncation step from the left"
actually produce as a number? What should the recursive call receive?
The deeper question to sit with:
You noted "wait i think this won't work with list,
gotta work with numbers instead" — trust that instinct!
There are two ways forward:

Work purely with numbers (no digit list needed) —
how do you chop a digit off a number arithmetically?
Work with the digit list, but convert sub-lists back to
numbers before primality-checking

Either works. Which feels more natural to you given the functions
you already have?
|#

; given a number, checks if it's prime
; number -> boolean
(define (is-prime? n)
  (define (helper curr-fact)
    (cond [(> curr-fact (sqrt n)) #t] ;divisibly only by that number
          [(zero? (remainder n curr-fact)) #f] ;false, divisible by factor other than n
          [else (helper (+ 1 curr-fact))]
          )
    )
  (if (< n 2)
      #f
      (helper 2))
  )
(is-prime? 1)
(is-prime? 2)
(is-prime? 3)
(is-prime? 6)
(is-prime? 7)

; given a number n, returns a list of digits that represents n
(define (num->digits n)
  (map (λ (c) (- (char->integer c) (char->integer #\0))) (string->list (number->string n)))
  )

; digits->number:: given a list of digits, converts it back to a number
(define (digits->number xs)
  (foldl  (λ (d acc) (+ d (* 10 acc)) ) 0 xs)
  )
(digits->number '(1 0 1)) ; 1 + 0 + 100


; number -> boolean
; given a number, checks if that number is a truncatble prime from LTR and RTL
; LTR: just cdr down
; RTL: reverse -> cdr -> reverse again
; wait i think this wont work with list gotta work with numbers instead
(define (is-truncatable-prime? n)
  (let ((num-digits (num->digits n)))

    (define (is-truncatable-prime-dir? xs strategy)
      (cond [(null? xs) #t]
            [else (let* ((rest-xs (strategy xs))
                         (curr-num (digits->number xs)))
                    (and (is-prime? curr-num) (is-truncatable-prime-dir? rest-xs strategy))
                    )]
            )

      )
    ; combine
    (and (is-truncatable-prime-dir? num-digits cdr)
         (is-truncatable-prime-dir? num-digits (λ (xs) (reverse (cdr (reverse xs)))) ))
    )
  )
(is-truncatable-prime? 3797) ; t
(is-truncatable-prime? 7) ;t
(is-truncatable-prime? 26) ;f


; number -> number
; given a number, finds all the sum of 11 primes that
; are truncatable from LTR & RTL
(define (truncatable-primes)
  ; number number -> number
  (define (helper curr-n counter result)
    (cond [(>= counter 11) result]
          [(is-truncatable-prime? curr-n) (helper (+ 1 curr-n) (+ 1 counter) (+ curr-n result) )]
          [else (helper (+ 1 curr-n) counter result)]
          )
    )
  (helper 11 0 0)
  )
(truncatable-primes)

