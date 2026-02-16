#lang racket

(define (inc x)
  (add1 x)
  )

; [Number -> Number] [Number -> Number] -> [Number -> Number]
; returns a function that applies f to the result of applying g to x
(define (compose f g)
  (lambda (x) (f (g x)))
  )

((compose sqr inc) 6)