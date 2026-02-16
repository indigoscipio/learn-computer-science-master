#lang racket


; Number Number -> Interval
; An Interval is a pair of number
; where a is tbe lower bound and b is the upper bound
(define (make-interval a b) (cons a b))
(define interval1 (make-interval 3 9))

; Interval -> Number
; extracts the upper bound from the given interval
(define (upper-bound interval)
  (cdr interval)
  )
(upper-bound interval1)

; Interval -> Number
; extracts the lower bound from the given interval
(define (lower-bound interval)
  (car interval)
  )

