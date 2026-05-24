#lang racket

#|
The sum of the squares of the first ten natural numbers is,
1^2 + 2^2 + ... + 10^2 = 385

the square of the sum of the first 10 natural numbers is

(1+2+3+...+10)^2 = 55^2 = 3025

hence the difference between the sum of the squares and the first 10 natural numbers of the square
of the sum is 3025 - 385 = 2640

find the difference between the sum of the squares of the first one hundred natural numbers
and the square of the sum.
|#

; given a number n, returns the sum of squares up to 1^2 + .. + n^2
; sum-of-squares:: number->number
(define (sum-of-squares n)
  ; using HOF chains
  (foldr + 0 (map sqr (range 1 (+ n 1))))
  )

; given a number n, returns the square of the sum of the first n natural number (1+2+...+n)^2
(define (square-of-sum n)
  ; using HOF chains
  (sqr (foldr + 0 (range 1 (+ n 1))))
  )

; finds diference between sum of sqr of first n and square of the sum
(define (diff n)
  (- (square-of-sum n) (sum-of-squares n))
  )
(diff 10) ;2640
(diff 100) ;25164150