#lang racket

#|
9.1
EXERCSE

a. find y^3 given integer y
b. find x implies y from x implies y == not x or y given x and y
the function implies should be prefix
c. find smallest integers a b and c
d. join strings s1 and s2 together in descending alphabetical order
e. find shorter of strings s1 and s2


|#
; cubed:: number -> number
(define (cubed n)
  (expt n 3)
  )

(define (implies x y)
  (not (or x y))
  )

(define (smallest a b c)
  (cond [(and (< a b) (< a c)) a]
        [(and (< b a) (< b c)) b]
        [else c])
  )

(define (s-join-az s1 s2)
  (if (string<? s1 s2)
      (string-append s1 s2)
      (string-append s2 s1)
      )
  )
(s-join-az "cc" "b")

(define (find-shorter s1 s2)
  (if (< (string-length s1) (string-length s2))
      s1
      s2
      )
  )
(find-shorter "a" "")


#|
9.3 
Write and test functions to: 
(a) Find the sum of the integers between 1 and n. 
(b) Find the sum of the integers between m and n. 
(0) Repeat a string 5 integer n times. 
|#

(define (sum-from-1-to n)
  (cond []
        []
        )
  )
