#lang racket

; DirectAccessTable = (vectorof ValueOrEmpty)
; where each index corresponds exactly to the key
(define dat (make-vector 5 '()))

; lookup O(1)
(vector-ref dat 0)

; insert O(1)
(vector-set! dat 0 100)

; delete O(1)
(vector-set! dat 0 '())

dat