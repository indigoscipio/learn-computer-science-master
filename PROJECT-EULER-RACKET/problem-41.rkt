#lang racket

#|
PROBLEM 41: PANDIGITAL PRIME
we shall say that an n digit number is pandigital if it makes use of all digits
1 to n exactly once
for example, 2143 is a 4 digit pandigital and is also prime

what is the largest n digit pandigital prime that exists?

answer:
ok so let me understand the qeustion
we wanna find largest n-digit pandigital prime that exists

for n=1 -> 2,3,5,7 -> 1 to 1 -> 1 digit is all pandigital
for n=2 -> 1 to 2 -> ... somethiing like that

as for the upper bound
upper limit for n is 9 so from digit 1 to 9 needs to be complete
and lower bound is n = 1
digit wise thats so its 2 - 999999999

hmm wait if we only care about thel argest why even bother with n = 1?
just check and start with n = 9 ?? or maybe i misubderstood the question
ah but what if there is no prime number in 9 digit at all? that makes sense s
gotta check everything

approach
- helper that checks if number is n-digit pandigial?
- helper that checks if number is prime
- main function that checks largest n digit pandigital prime: fix digit,
for each digit check is there n-digit pandigital prime and is it the greatest? repeat

or maybe simpler
- generate primes sequece up to upper bound
- then for each of those check if its pandigital
- then just get the max number
not sure if this is efficient or not but let me just tryit whocares

Your examples in the comments are exactly right.
For a 3-digit pandigital number, you need all digits 1, 2, 3
each exactly once — so 123, 132, 213, 231, 312, 321 are the only candidates.
Notice that "pandigital" fully determines which digits appear,
just not their order.

So the key question for is-n-digit-pandigital? is:
given a number, how do you check which digits it contains
and whether each appears exactly once?


|#

; number -> boolean
(define (is-prime? n)
  (define (helper curr-fact)
    (cond [(> curr-fact (sqrt n)) #t]
          [(zero? (remainder n curr-fact)) #f] ;divisible
          [else (helper (+ curr-fact 1))]
          )
    )
  (if (< n 2) #f (helper 2))
  )
(is-prime? 1) ;f
(is-prime? 2) ;t
(is-prime? 3) ;t
(is-prime? 4) ;f
(is-prime? 5) ;t
(is-prime? 7) ;t

; number -> list-of-number
; given a number, generate list of prime numbers from 2 up to including upper bound
(define (generate-prime-seq upper-bound)
  (filter is-prime? (range 1 (+ upper-bound 1)))
  )
;(generate-prime-seq 120) ;primes up to 50

; number -> number
; given a number, returns is digit length
(define (digit-length n)
  (string-length (number->string n))
  )
(digit-length 100) ;3

; number -> list-of-number
(define (number->list n)
  (map (λ (c) (- (char->integer c) (char->integer #\0)))
       (string->list (number->string n)))
  )
(number->list 123) ; '(1 2 3)

; checks if all element in xs is in ys
(define (all-xs-in-ys? xs ys)
  (andmap (λ (x) (member x ys)) xs)
  )
(display 'all-xs-in-ys)
(all-xs-in-ys? '(1 2 3) '(3 2 1))    

; number -> boolean
; do my digits form a complete set from 1 to digit-length of n?
(define (is-pandigital? n)
  (let* ((n-xs (number->list n))
         (d (digit-length n))
         (valid-digits (range 1 (+ d 1))) ;i dont think we ven need valid digits here?
         )

    ; list-of-number list-of-number -> boolean
    (define (contains-no-dup? num-lst digits-seen)
      (cond [(null? num-lst) #t] ;base
            [(member (car num-lst) digits-seen) #f] ; duplicate check
            [else (contains-no-dup? (cdr num-lst) (cons (car num-lst) digits-seen)) ]
            )
      )

    (and (all-xs-in-ys? n-xs valid-digits)
         (contains-no-dup? n-xs '()))
      
    )
  )
(display 'is-pandigital?)(newline)
(is-pandigital? 012)
(is-pandigital? 120)
(is-pandigital? 2)
(is-pandigital? 12)
(is-pandigital? 21)
(is-pandigital? 122)
(is-pandigital? 32)
(is-pandigital? 13)

; given an element x returns new xs with x removed
; or maybe use filter?
; list-of-x -> list-of-y
(define (remove x xs)
  (cond [(null? xs) '()]
        [(equal? x (car xs)) (cdr xs)]
        [else (cons (car xs) (remove x (cdr xs)))]
        )
  )
(remove 1 '(1)) ; '()
(remove 1 '(2 1)) ; '(2)
(remove 1 '(2 1 3)) ; '(2 3)

; given a list of numbers in increasing order,
; generate all list of list of possible permutations
(define (list->number xs)
  (foldl (λ (d acc) (+ d (* acc 10))) 0 xs)
  )
(list->number '(1 2 3))

; number list-of-list-of-number -> list-of-list-of-number
(define (prepend-to-each x xxs)
  (map (λ (xs) (cons x xs) ) xxs)
  )
(prepend-to-each 9 '((1 2) (3 4)))

(define (permutations xs)
  ;1 followed by all perms of '(2 3)
  (cond [(null? xs) (cons '() xs)]
        [else (apply append (map (λ (x) (prepend-to-each x (permutations (remove x xs)))) xs))]
        )
  )
(display 'permutations)(newline)
(permutations '()) 
(permutations '(1))
(permutations '(1 2))
(permutations '(1 2 3))

;void -> number
(define (pandigital-prime)
  (let* ((perms (permutations (number->list 7654321)))
         (prime-perms (filter (λ (xs) (is-prime? (list->number xs))) perms)))
    
    ;(apply max (map list->number prime-perms))

    (define (helper curr-n curr-max)
      
      )
    (helper 7 0)
  
    )
  )
(pandigital-prime)