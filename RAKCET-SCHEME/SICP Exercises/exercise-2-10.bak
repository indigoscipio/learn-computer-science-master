#lang racket


; Number Number -> Interval
; An Interval is a pair of number
; where a is tbe lower bound and b is the upper bound
(define (make-interval a b) (cons a b))
(define interval1 (make-interval -1 1))
(define interval2 (make-interval 1 -1))

; Interval -> Number
; extracts the upper bound from the given interval
(define (upper-bound interval)
  (cdr interval)
  )


; Interval -> Number
; extracts the lower bound from the given interval
(define (lower-bound interval)
  (car interval)
  )


; Interval Interval -> Interval
; computes the product of two intervals
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

; Interval Interval -> Interval
; computes the division between two intervlas
(define (div-interval x y)
  (mul-interval
   x
   (make-interval (/ 1.0 (upper-bound y))
                  (/ 1.0 (lower-bound y)))))

; Interval Interval -> interval
; computes the difference of two intervals
(define (sub-interval x y)
  (make-interval (min (- (lower-bound x) (lower-bound y))
                      (- (lower-bound x) (upper-bound y))
                      (- (upper-bound x) (lower-bound y))
                      (- (upper-bound x) (upper-bound y))
                      )
                 (max (- (lower-bound x) (lower-bound y))
                      (- (lower-bound x) (upper-bound y))
                      (- (upper-bound x) (lower-bound y))
                      (- (upper-bound x) (upper-bound y))
                      )
                 )
  )



; width = 1/2 * (upper - lower)
; computes the width of an interval
(define (width interval)
  (/ (- (upper-bound interval) (lower-bound interval)) 2)
  )
(width interval1) ; 1
(width interval2) ; 2
(+ (width interval1) (width interval2)) ;addition = 1 + 2 = 3
(- (width interval1) (width interval2)) ;subtraction = 1 - 2 = -1
(width (mul-interval interval1 interval2)) ; product = 11, does not equal to 1 x 2
(width (div-interval interval1 interval2)) ; division = 0.24444...., does not equal 1 / 2