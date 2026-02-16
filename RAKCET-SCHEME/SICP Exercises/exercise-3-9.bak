#lang racket


(define (square x)
  (* x x)
  )


; PROCEDURE
;(square 5) ; which is a lambda
;"procedure object" is created which contained which is a pair
;the parameter it takes & the function body (the lambda text)
;the pointer to the environment where it was created in this case its global

;square - its a lambda procedures that takes x, finds it tn the global env
;5 - evaluates to 5
;then applies the procedure to 5


;first it creates a new frame say E1

;set this new frame parent to the global env where square was created (eg points to that env)
;then the frame binds the argument it calls to the parameter procedure (binds x = 5)
;then inside E1 it evaluates the body (* x x), and return the result and E1 is destroyed

; DEFINE
; finds the first frame in the current environment, where the frame was created
; adds new binding, if its already defined it replaces it

; key takeaway
; procedure call creates a new frame
; procedure remembers the environment it was created i
; variables iwth same name in diff frame don't conflict (eg shadowing)


; Example

(define (square x)
  (* x x))
(define (sum-of-squares x y)
  (+ (square x) (square y)))
(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))

(f 5)
; calls to f with 5 as
; creates new frame E1
; inside  E1 it binds a (parameter of f) = 5
; then it evaluates (sum-of-squares (+ a 1) (* a 2))

; next we evaluate the subexpression sum-of-squares
; E1 has no binding for sum-of-squares
; it keeps finding sum-of-squares to the enclosing environment (the parent) in this case its the global environment is where it keeps sum-of-squares
; then it evaluates the other 2 subexpression (+ a 1) (* a 2) = (+ 5 1) (* 5 2) = (sum-of-squares 6 10)
; now we apply (sum-of-squares 6 10)

; new frame E2 is created from (sum-of-squares 6 10)
; parameterx x and y is bound to the argument x = 6, y = 10
; evaluates the function body (+ (square x) (square y)) and calls square

; new frame E3 is created
; square x - bounds x to 6
; evaluate the function body -> * 6 6

; new frame E4 is created
; square x - bounds x to 10
; evaluate the function body -> * 10 10
