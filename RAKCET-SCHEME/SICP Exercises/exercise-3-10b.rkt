#lang racket


; Key takeaways for local state:
; procedures can remember things because they carry their own scope/environment
; where variables can persist and change across calls



#|
(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))

; (define (make-withdraw balance)) function does the followig:
; every time you call it, it checks for the balance, subtracts money and mutates the balance for future
; balance is persistent and lives in a environment frame captured by the lamdba
; each call to (make-withdraw ) creates a kind of a private vault only accessible when the procedures is called (creates a closure that captures state)

; When make withdraw is called, it creates a procedure object that points to the global environment
; Global Env: #<procedure:make-withdraw>
; Its a factory that takes Number (balance) and returns Lambda.

; define (W1 (make-withdraw 100))
; Global env: {make-withdraw: procedure} is created
; call make withdraw 100
; frame E1 created
; Parent env: Global

; evaluate lambda E1
; procedure object is created
; code: amount ... if ....
; env: E1 to get balance

; finally binds W1 to this procedure object in the global env

;(W1 50)
; new frame E2 is created
; Parent: E1
; evaluate body in E2
; updates balance in E1

;(define W2 (make-withdraw 100))
; procedure object is created -> points to global env for make-withdraw
; then evaluates make-withdraw 100
; new frame E3 is created, which is the closure
; binds balance = 100
; W2's lambda points to its environment frame

; W1 uses E1
; W2 uses E2

|#


; Exercise 3.10
; Number -> [Number -> MaybeNumber]
(define (make-withdraw initial-amount)
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))))


(define W1 (make-withdraw 100))
; Global env: {make-withdraw: procedure}
; creates frame E1 - call (make-withdraw 100)
; initial amount = 100
; parent: global

; evaluate let...
; which is the same as (lambda (balance))
; E2 is created
; binds balance to initial amount  = 100
; parent: E1, since it needs initial amount

; evaluate let's body - it returns a lambda
; creates procedure oject W1 with
; paremeter: amount
; body: (if ...)
; env: E2

; W1 is bound in global env
; W1's procedure obejct points to E2 where balance = 100



(W1 50)
; A new frame E3 is created
; enclosing environment = E2, where balance = 100 (let ...)
; evaluate procedure body (100 >= 50) -> mutates
; set! mutates balance in E2 -> now balance is 50
; E3 is removed after call ends
; E2 is still there

; points E1/E2 as its parent environment to get balance
; a new frame is created - E3
; the body is evaluated, checks if (>= balance amount)
; false, mutate the balance/reduce it -50
; the parent environment is not global bu the frame that calls it

; E1 has initial amount = 100
; E2 has balance = 100
; lambda captures E2
; introduces extra frame

; Lambda definition does not euqal frame creation
; but when a lambda is called, it calls a new frame