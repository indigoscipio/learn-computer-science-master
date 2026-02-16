#lang racket

(define (inc x)
  (add1 x)
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
(((repeated smooth-avg 5) sqr) 3)

