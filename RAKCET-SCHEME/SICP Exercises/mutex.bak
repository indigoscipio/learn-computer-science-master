#lang sicp

; Exercise 3.43
; Account 1: $10
; Account 2: $20
; Account 3: $30

; if the processes are run sequentially
; after any number of concurrent exchanges
; the ccount balances should be $10, $20, $30 in some order


; using first version (without serialization)
; Exchange ACC1 ACC2 = 20/10/30
; Echange ACC3 ACC1 = 30/20/10
; Exchange ACC2 ACC3 = 10/30/20
; Exchange ACC2 ACC1 = 20/10/30
; therefore the total is always $60 if it runs sequentially


; What can go wrong when it runs concurrently?
; Here's an example,
; Exchange ACC1 ACC2, but during the process someone else calls the same exchange procedure
; Here's a rough timing diagram
; User1 -> Exchange ACC1 ACC2
; user1 reads ACC1 = $10
; User2 -> Exchange ACC1 ACC3
; user2 reads ACC1 = $10
; user1 evaluates the exchange procedure but didn't write/ finished yet
; User2 evaluates and finishes and sets the ACC1 balance to $30
; user1 now finish and sets acc1 balance to $20, overwriting user2's procedure


; total sum preservation is violated
; User 1 -> Echange ACC2 ACC3
; User 2 -> Exchange ACC1 ACC2
; User 1 reads ACC2 = $20
; User 2 reads ACC1 = $10
; User 1 evaluates exchange
; User 2 evaluates and finishes the changes, sets ACC1 = $20 and ACC2 = $10
; User 1 now finished the exchange, sets ACC2 = 30, ACC3 = 20
; total sum = $20 $30 $20 = 70

; ==========================================================================================

; Exercise 3.34

; ben's version of transfer
(define (transfer from-account to-account amount)
  ((from-account 'withdraw) amount)
  ((to-account 'deposit) amount))

; this version is safe to use as long as the withdraw and deposit is serialized
; we don't need to create another procedure like serializing both accounts like in exchange
; each operation is independent, we withdraw from from account and deposit to to account
; it doesn't read any balance and don't do any computation

; the differnece bwtween transfer and exchange
; in exchange we need to read both of the account balance
; and if something happens in the middle of process the operation can get messy
; but in transfer we don't need to read the variable between SHARED STATES

; ==========================================================================================

; Exercise 3.45
(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))

(define (make-account-and-serializer balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount)) balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount)) balance)
  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (balance-serializer withdraw))
            ((eq? m 'deposit) (balance-serializer deposit))
            ((eq? m 'balance) balance)
            ((eq? m 'serializer) balance-serializer)
            (else (error "Unknown request: MAKE-ACCOUNT" m))))
    dispatch))

(define (deposit account amount)
  ((account 'deposit) amount))

; answer:
; in the original code example, when the message is passed to dispatch
; it returns a unserialized procedure but here in lousis' code it returns a serialized procedure
; of withrdaw and deposit.

; in the original code, we define deposit by
; defining a serialized account
; and defining a deposit procedure
; and returns the serialized deposit procedure.

; So the difference here is lousis' code
; the withdraw and deposit procedure is serialized inside make account
; louis's deposit procedure didn't serialize the accuont
; but in the original code it's serialized inside the deposit operation

; so what happens when serialized exchange is called?
(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))
    ((serializer1 (serializer2 exchange))
     account1
     account2)))

; let say we run the serialized exchange
; In louis' code:
; locks acc2 -> locks acc1 -> runs echange procedure
; then in the exchange procedure
; withdraws the difference form acc2
; deposits the difference from acc2 but this one returns an serialized version
; therefore the value of deposit from acc2 can change creating an error