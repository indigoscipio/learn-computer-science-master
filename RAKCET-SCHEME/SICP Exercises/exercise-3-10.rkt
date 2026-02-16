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
; E1 frame is created where it binds
; balance (parameter) = 100 (argument)
; evaluates the lambda within E1's environment
; Code: (amount) (If ....)
; Env pointer: E1
; the procedure is bound to W1
; W1 is a procedure object with its own code and environment (which holds balance = 100).
; W1 remembers the balance through environment E1
; Global env: W1: <procedure with env E1>
; E1: balance: 100

;(W1 50)
; A new frame E2 is created since this is calls to a procedure
; it binds the amount = 50
; points to E1 as its parent environment (not global), so it can see balance
; then it evaluates the function body
; Since (>= balance amount) is false, it mutates the balalnce in E1
; set! modifies balance in E1, ; E1 stil has the balance 50
; E1: {balance: 50}

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
; This assigns W1 as procedure make-withdraw, which is a procedure that takes a number and returns either number or string
; First a new frame is created - E1
; Inside E1, looks for (make-withdraw) but since its not here it points to the global environment #<procedure:make-withdraw>
; it binds initial-amount (parameter) to 100 (argument)
; then it creates another scope definition (let ...)

; since let is another alternate syntax for lambda, it creates a new procedure object - E2
; inside E2, it binds balance to initial amount, so balance = 100
; (let ...)'s parent environment is E1

; E1 : initial amount  = 100
; E2 = balance = initial amount = 100
; W1 remembers initial amount


(W1 50)
; A new frame E3 is created since this calls to a procedure
; binds amount to 50
; points to E1 (or E2??) its parent environment so it can see the balance
; (let ...) is called - new frame is created
; binds balance to initial amount

; points E1/E2 as its parent environment to get balance
; a new frame is created - E3
; the body is evaluated, checks if (>= balance amount)
; false, mutate the balance/reduce it -50
; the parent environment is not global bu the frame that calls it


(define W2 (make-withdraw 100))
; Assigns W2 as procedure make-withdraw but its seperate from W1, it has each different local state
; W1 = 100 balance, W2 = 100 balance but different frame and different enclosed environment
; process is kinda similar to (define W1 (make-withdraw 100))
