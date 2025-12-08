#lang racket

; A Stack is a list of x
; where the first element is the top of the stack

(define empty-stack '())

; Stack -> Stack
; return a new stack with x added on top
(define (push x stack)
  (cons x stack)
  )

(define s1 (push 23 empty-stack))
(define s2 (push 66 s1))

; Stack -> Stack
; removes the top element of a stack, return error if empty
(define (pop stack)
  (cdr stack)
  )
(pop s1)

; top
; Stack -> stack
; gets the first item of the stack
(define (top stack)
  (car stack)
  )

; empty?