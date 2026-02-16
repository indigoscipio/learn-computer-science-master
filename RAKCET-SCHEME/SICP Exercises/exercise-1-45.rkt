#lang racket

(define (inc x)
  (add1 x)
  )
(define (average x y)
  (/  (+ x y) 2)
  )

;exercise 1.42
; [Number -> Number] [Number -> Number] -> [Number -> Number]
; returns a function that applies f to the result of applying g to x
(define (compose f g)
  (lambda (x) (f (g x)))
  )
;((compose sqr inc) 6)


;exercise 1.43
; returns a function that does f applied n times
; [Number -> Number] Number -> [Number -> Number]
(define (repeated f n)
  (cond [(zero? n) (lambda (x) x) ]
        [else (compose f (repeated f (sub1 n)))])
  )
;((repeated sqr 2) 5)

;exercise 1.44
; smooth-avg : [Number -> Number] -> [Number -> Number]
; takes a function f and returns a new function that averages f(x - dx), f(x), and f(x + dx)
(define dx 0.00001)
(define (smooth-avg f)
  (lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx)))  3 ))
  )
;(((repeated smooth-avg 5) sqr) 3)


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

(define (average-damp f)
  (lambda (x) (average x (f x)))
  )

; nth-root : Number Number -> Number
; returns the nth root of x using fixed-point of a damped transformation
(define (nth-root x n)
  (let ((f (lambda (y) (/ x (expt y (- n 1))) ) )
        (k (floor (/ (log n) (log 2))))
        )
    (fixed-point ((repeated average-damp k) f) 1.0)
    ; where k depends on n
    )
  )
(nth-root 27 3)