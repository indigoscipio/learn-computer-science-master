#lang sicp

#|
(define (cons x y)
  (define (set-x! new-value)
    (set! x new-value)
    new-value
    )
  (define (set-y! new-value)
    (set! y new-value)
    new-value
    )
  
  (define (dispatch m)
    (cond [(eq? m 'car) x]
          [(eq? m 'cdr) y]
          [(eq? m 'set-car!) set-x!]
          [(eq? m 'set-cdr!) set-y!]
          [else (error "Unknown Operations" m)]
          )
    )
  dispatch
  )
(define (car z) (z 'car))
(define (cdr z) (z 'cdr))
(define (set-car! z new-value)
  ((z 'set-car!) new-value) z)
(define (set-cdr! z new-value)
  ((z 'set-cdr!) new-value) z)
|#


; Exercise 3.20
; draw environment diagram to illustrate the evaluation
; using the implementation of pairs given above

(define x (cons 1 2))
; creates a closure
; E1: {x = 1, y = 2, set-x!: procedure, set-y!: procedure}
; returns lambda (m) within E1
; global env: x
; x is initiated as a pair with 1 as car and 2 as cdr

(define z (cons x x))
; creates new closure
; E2: {x = x, y = x, set-x!: procedure, set-y! procedure}
; returns lambda(m) within E2
; global env: x,z

(set-car! (cdr z) 17)
; set car is applied to cdr z (a refrence of x)
; this mutates x with 17, since z has 2 references of x this mutates the whole thing
; so new x = [ 17 | 2 ]
; new z = [new x | new x] -> '((17 2) 17 2)

(car x)
; this returns 17
