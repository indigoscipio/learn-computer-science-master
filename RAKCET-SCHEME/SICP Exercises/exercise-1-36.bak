#lang racket

(define tolerance 0.0001)

; [Number -> Number] Number -> Number
; finds the fixed point of a function
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance)
    )
  (define (iter guess)
    (let ((next-guess (f guess)))
      (cond [(close-enough? guess next-guess) next-guess]
            [else (iter next-guess) ])
      )
    )
  (iter first-guess)
  )
(fixed-point cos 1)

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 2.0)