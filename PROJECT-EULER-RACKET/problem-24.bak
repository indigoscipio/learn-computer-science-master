#lang racket

#|
Problem 23
Non-abundant sums

a perfect number is a number for which the sum of its proper divisors is exactly equal to the number

for example the sum of proper divisors of 28 would be 1+2+4+7+14 = 28
which means that 28 is a perfect number

a number n is called deficient
if the sum of its proper divisors is less than n and
it is called abundant if this sum exceeds n.

as 12 is the smallest abundant number, 1+2+3+4+6 = 16, the smallest number that can be written
as the sum of two abundant numbers is 24.

by math analysis, it can be shown that all ints greater than 28123 can be written as the sum of two
abundant numbers. however this upper limit cannot be reduced any further by analysis even though it is
known that the greatest number that cannot be expressed as the sum of two abundant numbers
is less than this limit


find the sum of all posints which cannot be written as the sum of two abundant numbers.

; answer:
; we can just use the previous proper divisor functions from prev chapter

; let me just understand this
; n is perfect if sum_pd(n) = n
; n is deficient if sum_pd(n) < n
; n is abundant if sum_pd(n) > n

the question said all integers k > 28123 can be written as sum of two abundant numbers (ab1 + ab2)
and the question is asking for sum of all posints that cannot be written as the sum of two abundant numbers

; appraoch
- find a number that cannot be written as the sum of two abundant numbers
- collect those numbers and sum it up
- wait what if instead i colect the abundant numb

|#

; given a number n, finds all of its proper divisors, from prev chapter
; number -> list-of-number
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


; given a number n, returns its sum of proper divisors
; number -> number
(define (sum-of-proper-divisors n)
  (foldr + 0 (proper-divisors n))
  )

; boolean -> boolean
; given a number, check if that number is abundant
(define (is-abundant? n)
  (> (sum-of-proper-divisors n) n)
  )

; given a number n, generates all abundant numbers up to n
(define (generate-abundant-nums-up-to n)
  (define (loop curr-n result)
    (cond [(zero? curr-n) result]
          [(is-abundant? curr-n) (loop (- curr-n 1) (cons curr-n result)) ]
          [else (loop (- curr-n 1) result )]
          )
    )
  (loop n '())
  )
(generate-abundant-nums-up-to 25) ; '(12 18 20 24)
(generate-abundant-nums-up-to 50) ; '(12 18 20 24 30 36 40 42 48)


; given a number n returns true if n can be written as sum of two abundant number
; assume n is posint
(define (is-sum-of-two-abundant-nums? n abundant-nums abundant-vects)
  (define (helper curr-n ab-nums)
    (cond [(empty? ab-nums) #f]
          [else (let ((b (- curr-n (car ab-nums))))
                  (cond [(< b 0) (helper curr-n (cdr ab-nums))]
                        [else (if (vector-ref abundant-vects b)
                                  #t
                                  (helper curr-n (cdr ab-nums))
                                  )]
                        )
                  
                  )]
          )
    )
  (helper n abundant-nums)
  )

; number list-of-number -> vector
(define (populate-abundant-vect! n abundant-nums)
  (let ((vect (make-vector (+ n 1) #f) ))

    (define (helper ab-nums)
      (cond [(null? ab-nums) vect]
            [else (begin (vector-set! vect (car ab-nums) #t)
                         (helper (cdr ab-nums))) ]
            )
      )
    (helper abundant-nums)
    )
  )

; main function, given n returns sum of all posint which cant be written as the sum of two abundant numbers
; up to below n
(define (non-abundant-sums n)
  (let* ((abundant-nums (generate-abundant-nums-up-to n))
        (abundant-vects (populate-abundant-vect! n abundant-nums))
        (nums (range 1 n)))
    
    (foldr + 0 (filter (λ (k) (not (is-sum-of-two-abundant-nums? k abundant-nums abundant-vects)) ) nums))
    )
  )
(non-abundant-sums 24) ;66
(non-abundant-sums 281) ;19866
(non-abundant-sums 28123) ;4179871