#lang sicp

; applicative = eager evaluation
; all of the arguments for a function gets evaluated first before performing the computation
; example:

; Exercise 4.25

(define (unless condition usual-value exceptional-value)
 (if condition exceptional-value usual-value))

(define (factorial n)
  (unless (= n 1)
    (* n (factorial (- n 1)))
    1)
  )

; answer
; this will not work becuase
; of the nature of scheme's applicative order
; all arguments are evaluated first before performing furhter computation

; calls for (unless ...) , evaluates the argument inside (= n 1) -> (= 5 1) -> false
; evaluates both the recursion and 1 befure unless runs
; before we evaluate unless, it evaluates the recursion continually, so unless can't choose what to return

; n reaches 1 but the function already builts a stack of recursion
; without actually checkinf if n = 1causes an infinite loop

; in a normal order language,  i think this will work because of lazy evaluation,
; uless checks (= 5 1) -> #f -> returns 1
; even though its wrong it still terminates and returns false
; only needed argument is evaluated and terminates