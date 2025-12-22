#lang racket


; 2.2.
; For each of the following expressions, say whether or not it is well
;formed. If the expression is well-formed, then give its value; otherwise, say 
;whether the error is a syntax-error, type-error, or some other kind:

; (3 = - - 3) A True
; answer:
; im not sure what the LHS it has 2 negatives but assuming its negating 2 times then
;3 = 3 is true so true A true is true
; well formed expression? yes
; final value: True
; type: Boolean -> Boolean -> Boolean

; 1 A 1 = 2
; answer:
; LHS -> assuming 1 is a truthy value then 1 A 1 is truthy. a -> a -> Bool
; RHS -> 2 is a number
; well-formed? no, different type for LHS and RHS
; final value: undefined/type error
; type: Boolean -> Number

; order of operation: Negation, Comparison, A, V

; (1 < x A x < 100) v X = True v X = False
; answer:
; RHS -> true V x -> error, what is x?
; RHS -> same x is not defined
; not well defined

; false = (< 1 3)
; answer:
; LHS -> Boolean (false)
; RHS -> Boolean (true)
; final result = False
; yes its a well defined expression

;2.2.2
; define a function sumsqrs which takes three numbers
; and returns the sum of the squares of the larger two

; given three enumbers, computes sum of squares of the larger two
(define (sumsqrs a b c)

  #| version 1
  ; case 1: a is the smallest, sum b + c
  ; case 2: b is the smallest, sum a + c
  ; case 3: c is the smallest, sum a + b
  (cond [(and (<= a b) (<= a c) ) (+ (sqr b) (sqr c) )]
        [(and (<= b a) (<= b c) ) (+ (sqr a) (sqr c) )]
        [else (+ (sqr a) (sqr b)) ])
  |#

  ; v2, using min-max
  (- (+ (sqr a) (sqr b) (sqr c)) (sqr (min a b c)) )
  
  )
(sumsqrs 1 2 3)