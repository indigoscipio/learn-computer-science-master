#lang racket

(define (square n)
  (* n n)
  )

;Using the function square, design a function quad which raises its ar
;gument to the fourth power.
; Number -> Number
(define (quad n)
  (square (square n))
  )
(quad 4)

;Define a function max which returns the greater of its two arguments.
; Number Number -> Number
(define (my-max a b)
  (if (< a  b)
      b
      a
      )
  )
(my-max 101 100)


; Define a function for computing the area of a circle with given radius
; r (use 22/7 as an approximation to 71"). 
(define (area-circle r)
  (* (/ 22 7) (square r))
  )
(area-circle 10)