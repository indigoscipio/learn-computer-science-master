#lang sicp



; Exercise 3.48
; why deadlock avoidance method avoids deadlock in the exchange problem

; answer:
; lets say peter wants to exchange A1 -> A2
; paul wants to exchange A2 -> A1
; without using a unique idnetificatoin
; we can't tell when the operation is evaluation/finished when it's run concurrnetly.
; lets say peter reaches a process where he locks A1
; and paul proceeds protecting A2
; they both are waiting for the other to be unlocked, causing a deadlock

; the unique identification number ensures
; that the locking/serializing procedure happens in order on both peter and paul
; with this it avoids deadlock

; make account implementation with unique identifier
;???
(define (make-account balance id)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((protected (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (protected withdraw))
            ((eq? m 'deposit) (protected deposit))
            ((eq? m 'balance) balance)
            ((eq? m 'id) id)
            (else (error "Unknown request: MAKE-ACCOUNT"
                         m))))
    dispatch))