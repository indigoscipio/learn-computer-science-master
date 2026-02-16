#lang sicp

; Exercise 4.70

(define (add-assertion! assertion)
  (store-assertion-in-index assertion)
  (set! THE-ASSERTIONS
        (cons-stream assertion THE-ASSERTIONS))
  'ok)

; what would be wrong with the following implmeentation of add-assertion?

; answer:
; the code first stores the assertio in index
; then it puts the new assertion in front of the the cons stream
; mutating the whole THE-ASSERTIONS
; the let binding prevents mutation and make sure the data mutation is performed safely