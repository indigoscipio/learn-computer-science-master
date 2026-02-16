#lang racket


(define (make-rat n d o) (cons n d o))
(define (numer x) (car x))
(define (denom x) (cdr x))
(define (op x) (third x))

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
