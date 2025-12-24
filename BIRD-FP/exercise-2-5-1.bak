#lang racket

; rule 1: |y| <= 5
; rule 2: x = y + 10z
; rule 3: z is the smallest number of absolute values which satisfies I and II

; y z are uniquely determined

; given two integers, returns balanced number
; Number Number -> Number
(define (split n)
 (let* ((q (quotient n 10))
       (r (remainder n 10))
       (z (cond [(< r -5) (- q 1)]
                [(> r 5) (+ q 1)]
                [else q]
                )
          )
       [y (- n (* 10 z))]
       )

   (cons y z)
   
   )
  )
(split 17) ; x (target) = 17, z (quotient) = 2 , y = -3
