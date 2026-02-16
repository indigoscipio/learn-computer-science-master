#lang sicp


; Exercise 3.38a

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
; 100 + 10 = 110
; 110 - 20 = 90
; 90/2 = 45 -> final balance = $45

; Peter -> Mary -> Paul
; 100 + 10 = 110
; 110/2 = 55
; 55 - 20 = 35 -> final balance = $35

; Paul -> Peter -> Mary
; 100 - 20 = 80
; 80 + 10 = 90
; 90 / 2 = 45 -> final balance = $45

; Paul -> Mary -> Peter
; 100-20 = 80
; 80/2 = 40
; 40+10 = 50 -> final balance - $50

; Mary -> Peter -> Paul
; 100/2 = 50
; 50+10 = 60
; 60-20 = 40 -> final balance = $40

; Mary -> Paul -> Peter
; 100/2 = 50
; 50-20 = 30
; 30+10 = 40 -> final balance = $40


;exercise 3.38b
; Timing diagram

; Bank: $100
; Case 1:
; start
; Peter reads balance = 100
; Peter reads balance = 100
; Paul withraws balance -20
; Peter deposits balance +10
; Paul writes balance = 80
; Peter writes balance = 110

; Bank: $100
; Case 2
; start
; Peter reads balance = 100
; Mary reads balance = 100
; Peter deposits balance +10
; Mary withdraws balance $50 (50% of 100 which is the old balance)
; Mary writes balance = $50
; Peter writes balance = $110