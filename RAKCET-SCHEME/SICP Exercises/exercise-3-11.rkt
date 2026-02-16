#lang racket
(require rnrs/mutable-pairs-6)


#|
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))
|#

; Environment model breakdown
; Step 1
; (sqrt 2)
; New frame E1 is created
; binds x = 2
; parent: global env
; defines/evaluates internal procedures good-enough, improve, and sqrt-iter inside E1
; Pointer -> E1 since this is where they are defined, they remember x from sqrt
; E1 : {x=2, good-enough: procedure E1, improve: procedure E1, sqrt-iter: procedure E1}

; step 2
; run (sqrt-iter 1.0)
; creates new frame E2
; binds guess = 1.0
; parent: E1 (since this is where sqrt-iter is defined)
; inside E2, it evaluates the (if ... (good-enough? guess)) ...

; step 3
; run (good-enough? guess)
; creates new frame E3
; binds guess = 1.0
; parent: E1 since thats where good-enough is created
; evaluates (< (abs) ...), uses x = 2 from E1


(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else
           (error "Unknown request: MAKE-ACCOUNT"
                  m))))
  dispatch)

; Exercise 3.11
; Environment model breakdown
(define acc (make-account 50))
; E1 frame is created
; global env: {make-account: procedure}
; binds balance = 50
; parent env: global env
; inside E1 , 3 procedure object is evaluated/defined: withdraw, deposit, and dispatch.
; These 3 closure points to E1 which is where they're created
; then it returns dispatch, so acc binds to dispatch which is a procedure object that remembers that balance = 50
; Acc = dispatch inside E1 : {balance = 50, procedure:withdraw, procedure:deposit, procedure:dispatch}

((acc 'deposit) 40)
; dispatch is called, new frame E2 is created
; inside E2, it binds m = 'deposit
; parent: E1 since this is where dispatch is created
; then it evaluates the body ((eq?) ...) )
; since m = deposit, it returns deposit which is a procedure

; new frame E3 is created
; now evaluate (deposit amount)
; parent: E1 since thats where deposit is created
; inside E3, binds amount = 40
; looks up for balance - not found in E3 -> goes up to E1 until its found, so balance = 50
; mutates the balance from E1 to 50 + 40 = 90
; returns balance (E1) = 90
; E2 and E3 is destroyed, operation is done


((acc 'withdraw) 60)
; dispatch is called, new frame E2 is created
; remembers E1's balance is 90 from previous operation/local state
; inside E2, binds meesage = withdraw
; parent: E1 since this is where dispatch is created
; evaluates dispatch's function body (cond (eq? ...))
; since m = 'withdraw, it returns wihtdraw

; new frame E3 is created, evaluate wihtdraw (procedure object created in E1)
; parent: E1 since this is whre wihtdraw is created
; binds amount = 60 from the argument
; evaluates withdraw's function body (if (>= balance amount) ...) inside E3
; since balance 90 is less than amount 60, we can withdraw it
; mutates balance (E1) to 30, returns balance
; operation completed, E2 and E3 is destroyed


; Where is the local state for acc kept? Suppose we define another account
; answer: local state for acc is kept within E1 (since we store the balance inside E1) and is not accessible globally

 (define acc2 (make-account 100))

; How are the local states for the two accounts kept distinct?
; answer: acc2 evaluates (make-account), creating new frame, say E2 that keeps the balance seperate from acc object with each having
; different local state. so acc=  E1, acc2 = another frame like E2

; Which parts of the environment structure are shared between acc and acc2?
; the code and procedures like dispatch, deposit, and withdraw are shared since the two objects can use these 3 procecdures
; but the procedure object (closure )is NOT shared.
; acc1
; withdraw -> code + env E1
; acc2
; withdraw -> code + env E4
; but the value for balance is different for each account
(define x (mcons 1 3))
(mpair? x)
(set-car! x 10)
x
(set-car! x 25)
x