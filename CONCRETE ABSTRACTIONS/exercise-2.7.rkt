#lang racket
(require (lib "concabs"))


rcross-bb

; Exercise 2.7
; Rewrite sum-integers-from-to in this alternative way
; that is, by increseaing low
; Number Number -> Number 
(define (sum-integers-from-to a b)
  (cond [(> a b) 0]
        [else (+ (sum-integers-from-to (+ a 1) b) a)])
  )
(sum-integers-from-to 1 3)


; Exercise 2.8
; computes the sum of first n squares, where n is a nonnegative integer
(define (sum-of-squares n)

  )