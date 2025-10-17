#lang racket

; given a natural number n, computes its prime factors
; Number -> List-of-numbers
(define (factorize n)

 #|
  ; acc holds the prime factors seen
  ; Number Number List-of-numbers -> List-of-number
  (define (iter num curr-prime acc)
    (cond [(= num 1) acc]
          [(= (remainder num curr-prime) 0) (iter (/ num curr-prime) curr-prime (cons curr-prime acc))] ;set new num
          [else (iter num (+ curr-prime 1) acc)] ;doesn't divide evenly, move on to the next divisor
          )
    )
  (reverse (iter n 2 '()))
  |#


  
  )
(factorize 2) ;return 2
(factorize 9) ;'(3 3)
(factorize 60) ;

findf