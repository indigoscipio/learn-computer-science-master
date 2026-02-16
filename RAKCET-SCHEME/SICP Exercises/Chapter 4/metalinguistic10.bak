#lang sicp


(define (cons x y) (lambda (m) (m x y)))
(define (car z) (z (lambda (p q) p)))
(define (cdr z) (z (lambda (p q) q)))

(define j (cons 2 3))



; Exercise 4.32
; Example of Chapter 3 lazy list:

; (cons-stream a (delay b))
; car is computed immediately, cdr is delayed
; requires special forms (delay, force) and special stream-map, stream-append, etc.

; Example of this chapter's lazy evaluation (built in):

; By redefining cons, car, cdr with lambdas and using a lazy evaluator,
; both car and cdr are delayed automatically.
; No need for separate stream versions of map or append.
; Ordinary list operations just work.

; Advantages of the extra laziness:

; - Simpler code (no explicit delay needed)
; - Infinite lists are easier to define and process
; - Mutually recursive lazy lists work naturally
; - Differential equations and feedback models are easier to express
; - More composable and flexible


; Exercise 4.33

(car '(a b c))
; returns an error

; in the redefined lazy evaluator, we only modified the cons, car, and cdr
; list or quotes expressions is not redefined yet

(define (eval exp env)
  ((quoted? exp) (list->lazy-list exp))
  ; rest of the eval clause
  )

(define (list->lazy-list exp)
  (cond [(null? exp) '()]
        [else (cons (car exp) (list->lazy-list (cdr exp)) )])
  )

; Exercise 4.34
(define (cons x y)  
  (let ((pair (lambda (m) (m x y))))  
    (attach-tag 'lazy-pair pair)))  ; Tag for identification.  

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (if (= input lambda) ;evaluate it print, ekse  after a few elemtn )
    (let ((output
           (actual-value
            input the-global-environment)))
      (announce-output output-prompt)
      (user-print output))
    )
  (driver-loop))