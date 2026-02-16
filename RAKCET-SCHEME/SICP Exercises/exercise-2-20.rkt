#lang racket

;exercise 2.20

;(define (f . z)  z  )
;(f 2 5 5 7 8 9 4)

;filteres a list of numbers into odd only
; List-of-Number -> List-of-number
(define (filter-odd l)
  (filter (lambda (x) (odd? x) ) l )
  )

(define (filter-even l)
  (filter (lambda (x) (even? x) ) l )
  )

; given a list of arguments using the dot notation,
; takes one or more integers and returns a list of all the arguments
; that have the same even-odd-parity as the first argument
; List-of-arguments -> List-of-X
(define (same-parity arg-first . arg-rest)
  (cond [(empty? arg-rest) '()]
        [(odd? arg-first) (cons arg-first (filter-odd arg-rest)) ] ;put it on the list and recurse
        [else (cons arg-first (filter-even arg-rest)) ] ;else recurse to the rest of the args
        )
  )
(same-parity 1 2 3 4 5 6 7) ; should return '(1 3 5 7)
(same-parity 2 3 4 5 6 7) ; should return '(2 4 6)