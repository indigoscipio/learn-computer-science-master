#lang racket

; if rat is positive, both the numerator and denominator are positive
; if rat is negative, only the numerator is negative
(define (make-rat n d) (normalize-rat-sign n d))
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (normalize-rat-sign n d)
  (cond [(and (negative? n)(negative? d)) (cons (abs n) (abs d))]
        [(negative? d) (cons (- n) (abs d))]
        [else (cons n d)]; else return both positive
        )
  )

(make-rat 2 3)
(make-rat -2 3)
(make-rat -2 -3)
(make-rat 2 -3)


(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x))
  )



(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))


;(define rat1 (make-rat 2 3))
;(print-rat rat1)
;(print-rat (add-rat rat1 rat1))
