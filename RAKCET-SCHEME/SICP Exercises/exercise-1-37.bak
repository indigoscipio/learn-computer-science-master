#lang racket

(define (average x y) (/ (+ x y) 2))
(define tolerance 0.0001)

; [Number -> Number] Number -> Number
; finds the fixed point of a function
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance)
    )
  (define (iter guess)
    (display guess) (newline)
    (let ((next-guess (f guess)))
      (cond [(close-enough? guess next-guess) next-guess]
            [else (iter next-guess) ])
      )
    )
  (iter first-guess)
  )
;(fixed-point cos 1)

;(fixed-point (lambda (x) (+ 1 (/ 1 x))) 2.0)
;(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)
(fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 3.0)