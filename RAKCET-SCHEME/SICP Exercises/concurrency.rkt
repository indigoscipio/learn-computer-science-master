#lang sicp


; Exercise 3.38

; Peter, Paul, Mary = $100

; Concurrently:
; Peter deposits $10
; Paul withdraws $20
; Mary withdraws 50% of the account balance (half the money

; Peter: (set! balance (+ balance 10))
; Paul: (set! balance (- balance 20))
; Mary: (set! balance (- balance (/ balance 2)))

; All different possible values for balance after these transaction have been completed
; assuming that the banking system forces three processes to run sequentially in some order

; I'm gusessing that the possible value = 3! = 3 . 2 . 1 = 6 possible values
; Peter -> Paul -> Mary (original sequence)
; 100 - 20 = 

; Peter -> Mary -> Paul

; Paul -> Peter -> Mary

; Paul -> Mary -> Peter

; Mary -> Peter -> Paul

; Mary -> Paul -> Peter