#lang racket

(define counter 0) 

; returns the same value as cons and counts how many times it sees
; its arguments
counter
(define consC
  (let ((n 0))
    (set! counter (lambda () n) )
    (lambda (x y)
      (set! n (+ 1 n))
      (cons x y)
      )
    )
  )
(consC 2 0)
(consC 2 0)
(consC 2 0)
(counter)