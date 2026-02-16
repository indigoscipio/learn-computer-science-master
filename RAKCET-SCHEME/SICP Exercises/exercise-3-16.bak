#lang sicp

(define x '(a b))
(define z1 (cons x x))
(define z2 (cons '(a b) '(a b) ))

(define (set-to-wow! x) (set-car! (car x) 'wow ) x)

; Exercise 3.15
; box and pointer diagram for (set-to-wow! z1)
; answer: 
; before function call
; x = [a | *] [b | null] 
; z1 = [x | *] -> [x | null]
; z1 = '((a b) a b)

(set-to-wow! z1)
; After function call, the list (x) is mutated
; (set-to-wow! (cons x x))
; (set-car! x 'wow) -> x's car becomes 'wow
; so new x = '(wow b)
; because of the mutation, this changes the structure of z1
; why? because x is referenced inside z1 as (cons x x), so the two x will also change

; new x = ['wow | *] -> [b | null]
; new z1 = [new x | *] -> [new x | null]
; new z1 = '((wow b) wow b )

; Exercise 3.16
; box and pointer diagram for (set-to-wow! z2)
; answer:
; before function call, heres what the z2 look like
; z2 = ['(a b) | *] -> [a | *] -> [b | null]

(set-to-wow! z2)
; after function call, the list is mutated,
; but unlike z1, it only mutatest z2's first item in the list aka first '(a b)
; (set-car! x 'wow) -> '(a b) becomes '(wow b) but only applies to the first item sinze z2 does not reference x
; x is not being mutated because we did not reference it
; new x = stays the same because we do not involve x/share here
; new z2 = ['(wow b) | *] -> [a | *] -> [b | null]
