#lang racket

#|
PROBLEM 7: 10,001ST PRIME

By listing the first six prime numbers: 2,3,5,7,11,13, we can see that the 6th prime is 13
what is the 10001st prime number?

answer:
lets keep this simple.
if i remember there are lots of ways to calculate primes,
like the stick of eristhanes thing is one of them (id dont know if this is corect name lol)
and other way is checking if the curr n > sqr(n) or (sqrt n) > n or smth i dont remember

|#

; assume n is posint
(define (is-prime? n)
  (define (helper curr-fact)
    (cond [(> curr-fact (sqrt n)) #t] ;stop
          [(zero? (remainder n curr-fact)) #f] ;divides evenly, return false
          [else (helper (+ 1 curr-fact))] ; otherwise keep dividing
          )
    )
  (if (<= n 1) #f (helper 2))
  )
(is-prime? 17) ; #t
(is-prime? 1) ; #f
(is-prime? 2) ; #t

(define (first-n-prime n)
  (define (helper curr-prime curr-n)
    (cond [(>= curr-n n) curr-prime] ;done, return the result
          [(is-prime? curr-prime) (if (= (+ curr-n 1) n)
                                      curr-prime
                                      (helper (+ 1 curr-prime) (+ 1 curr-n))
                                      )] ;encounters next prime, update curr-prime value and increment curr-n
          [else (helper (+ 1 curr-prime) curr-n)] ;next number is not prime, just recurse with only curr prime increased
          )
    )
  (helper 2 1)
  )
(first-n-prime 1) ;2
(first-n-prime 2) ;3
(first-n-prime 3) ;4
(first-n-prime 6) ;12
(first-n-prime 100) ; 524 - isn't 524 not a prime??
(first-n-prime 1000) ; 7920
(first-n-prime 10002) ; 104729

