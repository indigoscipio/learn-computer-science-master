#lang racket

#|
AMICABLE NUMBERS
let d(n) be defined as the sum of proper divisors of n (numbers < n which divide evenly into n)
if d(a) = b and d(b) = a, where a does not equal b, then a and b are an amicable pair and
each of a and b are called amicable numbers.

for example, the proper divisors of 220 are 1,2,4,5,10,11,20,22,44,55, and 110;
therefore d(220) = 284. the proper divisors of 284 are 1,2,4,71 and 142, so d(284) = 220

evaluate the sum of all the amicable numbers under 10000

answer:

i know proper divisor is basically idvisors except that number itself
and  amicable numbers always exist in pairs, so it goes both ways

220,284 is one example, and we want to find all amicable numbers under 10000

so i think for the steps/implementation
; find all amicable number under 1000
; calculate the sum
keep it simple

|#

; given a number n, finds all of its proper divisors
; number -> list-of-number
; i remember using sqrt(n) optimization thing for this but i forgot or maybe even theres other method
(define (proper-divisors n)
  (define (helper curr-n curr-fact result)
    (cond [(> curr-fact (sqrt n)) result] ; return result
          [(zero? (remainder n curr-fact))
           (if (= curr-fact (quotient curr-n curr-fact))
               (helper curr-n (+ 1 curr-fact) (cons curr-fact result))
               (helper curr-n (+ 1 curr-fact) (cons curr-fact (cons (quotient curr-n curr-fact) result)))
               ) ] ;is a factor
          [else (helper curr-n (+ 1 curr-fact) result)] ; is not a factor
          )
    )
  (if (> n 1)
      (cons 1 (helper n 2 '()))
      (helper n 2 '())
      )
  )
(proper-divisors 1)
(proper-divisors 9)
(proper-divisors 12)
(proper-divisors 220)

; given a number n, returns its sum of proper divisors
; number -> number
(define (sum-of-proper-divisors n)
  (foldr + 0 (proper-divisors n))
  )
;(sum-of-proper-divisors 220) ;should return 284

; number number -> boolean
; given a number a and b, checks if thoe numbers is a amicable pair

(define (is-amicable-number? a)
  (let* ((da (sum-of-proper-divisors a)) ; sum pd of a
        (db (sum-of-proper-divisors da)) ;sum pd of da
        )
    (and (equal? a db) (not (equal? da a)) )
    )
  )
(is-amicable-number? 220)

; number -> number
; given a number n, finds the sum of amicable numbers under n
; pd of 220: 284
; pd of 284: 220
(define (sum-of-all-amicable-number-under n)
  ; generate amicable numbers
  ; sum the amicable numbers
  (let ((num-list (filter (λ (x) (is-amicable-number? x) ) (range 1 n))))
    (foldr + 0 num-list)
    )
  )
(sum-of-all-amicable-number-under 1000) ;504
(sum-of-all-amicable-number-under 10000) ;31626