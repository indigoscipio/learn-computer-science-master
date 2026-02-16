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