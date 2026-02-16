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


; Exercise 3.49

; The deadlock-avoidance mechanism based on using a unique ID for each account
; works only if the process knows in advance which accounts it will need to access.

; However, it fails in situations where the set of required resources (e.g., accounts)
; is not known until after the process has already locked one or more accounts.

; For example, suppose a process first locks Account A, then looks up a group of
; associated accounts (e.g., friends in a group chat or shared expenses group)
; stored *inside* Account A. Only after accessing A can it discover that it needs
; to access Accounts B and C.

; Meanwhile, another process locks Account B first, then discovers it needs Account A.
; Since both processes are now waiting on each other to release locks, we get a deadlock.

; This scenario shows that ID-based ordering cannot help if the full list of resources
; to be acquired is not known upfront.