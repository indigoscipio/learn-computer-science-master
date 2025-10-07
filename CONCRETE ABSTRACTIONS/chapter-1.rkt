#lang racket

; candy-temperature: Number Number -> Number
; calculates the cooking temperature for a given recipe temperature at a given elevation

(define (candy-temperature temp elevation)
  (- temp (round (/ elevation 500)))
  )
;(candy-temperature 250 5000)

; =================================================

; exercise 1.5
; add marginal tax rate,
(define tax
  (lambda (income)
    (if (< income 10000)
        0
        (* (- income 10000) 20/100) )
    )
  )
(tax 20000)

; =================================================

; exercise 1.6
(define (turkey-servings weight)
  (if (<= weight 12)
      (/ weight 0.75) 
      (/ weight 0.5 )
      )
  )
(turkey-servings 10)

; =================================================

; exercise 1.7
;a. Returns the sum of the first number and the larger of the second and third numbers.
;b. it computes the absolute value of x by cleverly using function selection.

; =================================================

; Exercise 1.12
(define f
  (lambda (x y)
    (if (even? x)
        7
        (* x y))))
(f 1 16)

; Exercise 1.13
(define foo
  (lambda (x y)
    (if (zero? y)
        (+ x y)
        (/ x y))))
(foo 10 0)