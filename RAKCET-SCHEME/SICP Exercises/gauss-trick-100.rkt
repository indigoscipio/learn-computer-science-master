#lang racket

; Sums the number by dividing each into a pair
; and sums that pair

; Number -> Number
(define (gauss-sum n)
  ; Number Number List-of-[Number Number] -> List-of-[List-of-Number Number]
  ; iter builds the list of pairs up to n
  (define (iter low high acc)
    (cond [(> low (/ n 2)) acc] ; base case: num reaches half of total num, sum the pairs
          [else (iter (add1 low) (sub1 high) (cons (list low high) acc) ) ]; else keep doing it
          )
    )
  ; initialize iter, and then sum the pairs afterwards - think about this later
  (foldr + 0 (map (lambda (pair) (+ (car pair) (cadr pair) ) ) (iter 1 n '()) )) 
  )

(gauss-sum 100)
(gauss-sum 3)
(gauss-sum 200)
(gauss-sum 1)
(gauss-sum 0)


; divide by 2 = 50 total pairs
; 1 + 100
; 2 + 99
; 3 + 98...

; enumerate interval 0 - 50
; add the pair
; add all of the pairs in interval
; enum -> sum -> sum

;Sieve of Eratosthenes
(define (sieve n)
  (define (iter num primes)
    0
    )
  ( ...)
  )