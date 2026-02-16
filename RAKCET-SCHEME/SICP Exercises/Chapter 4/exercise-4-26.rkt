#lang sicp

; applicative = eager evaluation
; all of the arguments for a function gets evaluated first before performing the computation
; example:

; Exercise 4.25

#|
(define (unless condition usual-value exceptional-value)
 (if condition exceptional-value usual-value))

(define (factorial n)
  (unless (= n 1)
    (* n (factorial (- n 1)))
    1)
  )
|#

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

; Exercise 4.26

; Ben's side
; how unless can be implemented as a special form
; unless as derived expression special form, like built-in scheme "if"
; (unless (= x 0) "safe" "error")  -> (if (= x 0) "error" "safe")


; I'm not sure how it can be implemented asderive expression

; Alyssa's sside
; we cannot pass it as argument to another function or return it from functions
; So, you cannot pass it as an argument to higher-order functions,
; or return it from other functions.
; This limits its use in abstract and composable code.
(define (force-it obj)
  (if (thunk? obj)
      (actual-value (thunk-exp obj) (thunk-env obj))
      obj)
  )

(define (thunk? obj)
  (tagged-list? obj 'thunk)
  )

(define (delay-it exp env)
  (list 'thunk exp env)
  )

(define (evaluated-thunk? obj)
  (tagged-list? obj 'evaluated-thunk))

(define (thunk-value evaluated-thunk)
  (cadr evaluated-thunk))

; ==================================================================

; Exercise 4.27
; 