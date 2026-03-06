#lang racket

; helper to find median
(define (median xs)
  (list-ref xs (quotient (length xs) 2))
  )
(median '(2 3 4 6))

; lets simplify input for now, divide into relatives and street num instead of bundling it all
(define (find-optimal-distance relatives street-nums)
  
  ; sort the street nums
  (define sorted-street-nums (sort street-nums <))
  ; pick a median
  (define m (median sorted-street-nums))
  (foldr (λ (x acc) (+ (abs (- m x)) acc) ) 0 sorted-street-nums)
  
  )
(find-optimal-distance 3 '(4 2 6))
(find-optimal-distance 2 '(2 4))