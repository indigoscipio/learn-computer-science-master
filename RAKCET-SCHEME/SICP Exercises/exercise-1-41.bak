#lang racket

(define (average x y) (/ (+ x y) 2))
(define tolerance 0.0001)


; .... ???
; Number Number Number -> [Number -> Number]
; returns a function that calculates zeroes of the cubic x^3 + ax^2 + bx + c
(define (cubic a b c)
  (lambda (x) (+ (expt x 3) (* a (sqr x)) (* b x) c)  )
  )
((cubic 1 2 3) 3)


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

(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))
(define dx 0.00001)

(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))

; [Number -> Number] Number -> Number
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(newtons-method (cubic 1 2 3) 1.0)