#lang racket

; exercise 1.4.3
;; sign: num -> num
(define (sign n)
  (cond [(> n 0) 1]
        [(< n 0) -1]
        [else 0])
  )
(sign 0)
